# -*- coding: utf-8 -*-：
# 文件扫描程序

import common.dao.import_tables as tb_import_tables
import common.dao.table_schema as tb_table_schema
import common.db.db_config as db
from common.dao.import_tables import Stage
import os, re, shutil, json, time
import merge, common.config.config as config
import create_dir
import trigger_servers
from sqlalchemy import desc
import sys
import common.util.schema_paser as schema_paser
import traceback
from common.util.util import CommonUtil as util

reload(sys)
sys.setdefaultencoding("utf-8")

setting = None

env = util.getParam("env")

if env == "pro":
    setting = config.pro_path
else:
    setting = config.dev_path

# 系统配置的前缀
prefix = setting.get("prefix")

# 存放parquet文件的地址
parquet_path = setting.get("parquet_path")

pattern = re.compile(r'^\d{8}_\d{2}_\d{2}_\d{2}$')


# 获取当前的时间
def get_time_format():
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))


# 判断目录中文件是否上传完成
def upload_completed(file_path):
    if "upload_completed" in '|'.join(os.listdir(file_path)):
        return True
    return False


# 获取删除标志
def get_delete_flag(id, str):
    if str is None:
        return 0
    if id in str:
        return 1
    return 0


# 转换类型 TODO
def get_stand_type(old_type):
    if "char" in old_type:
        return "string"
    return old_type


# 获取schema描述
def get_schema(json_str, table):
    json_dict = {}
    json_dict['db_type'] = table.src_db_type
    json_dict['db_version'] = table.src_db_version
    json_dict['db_name'] = table.src_db
    json_dict['table_name'] = table.src_table
    json_dict['schema'] = json.loads(json_str)
    return json.dumps(json_dict)


def get_type(o_type):
    if 'decimal' in o_type:
        return 'double'
    if 'datetime' in o_type:
        return 'timestamp'
    return 'string'


def get_json_schema(path):
    schema = open(path)
    lines = schema.readlines(100000)
    string = ''
    for line in lines:
        string += line
    string = string.lower()
    json_str = json.loads(string)
    array_origin = []
    array_spark = []
    array_name = []
    for s in json_str.get("schema"):
        dic = {}
        diu = {}
        name = s.get("name")
        type = s.get("type")
        dic["name"] = name
        dic["type"] = type
        array_origin.append(dic)
        diu["name"] = name
        diu["type"] = get_type(type)
        array_spark.append(diu)
        array_name.append(name)
    return {'origin_json': json.dumps(array_origin), 'spark_json': json.dumps(array_spark), 'name_array': array_name}


# 处理schema
def do_schema(schema_path, table):
    obj = None
    if os.path.exists(schema_path + '/schema.json'):
        obj = get_json_schema(schema_path + '/schema.json')
    else:
        obj = schema_paser.get(schema_path + '/schema.sql')

    # 这里需要获取原有schema的json和转换后的schema的json, 原有json
    json_origin = obj.get('origin_json')

    # 转换后的json
    json_spark = obj.get('spark_json')

    name_array = obj.get('name_array')

    # 没对应的schema信息就添加，有的话就把version+1
    schema_str_origin = get_schema(json_origin, table)
    schema_str_spark = get_schema(json_spark, table)

    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=table.id).order_by(desc(TableSchema.id)).first()

    if schema is None:
        schema = TableSchema()
        schema.table_id = table.id
        schema.version = 1
        schema.schema = schema_str_origin
        schema.spark_schema = schema_str_spark
        schema.create_time = get_time_format()
        schema.update_time = get_time_format()
        db.session.add(schema)
    else:
        schema_1 = TableSchema()
        schema_1.table_id = table.id
        schema_1.version = int(schema.version) + 1
        schema_1.schema = schema_str_origin
        schema_1.spark_schema = schema_str_spark
        schema_1.create_time = get_time_format()
        schema_1.update_time = get_time_format()
        db.session.add(schema_1)
    db.session.commit()

    return ','.join(name_array)


# 修改stage信息
def do_stage(stage_id, table_id, import_type="full", inserted_num=0, updated_num=0, deleted_num=0, record_num=0):
    StagePoJo = Stage
    table_stage = db.session.query(StagePoJo).filter_by(id=stage_id).first()
    table_stage.inserted_num = 0 if inserted_num is None else inserted_num
    table_stage.updated_num = 0 if updated_num is None else updated_num
    table_stage.deleted_num = 0 if deleted_num is None else deleted_num
    table_stage.record_num = 0 if record_num is None else record_num
    table_stage.end_time = get_time_format()
    table_stage.process_status = 0
    table_stage.status = 1
    db.session.commit()


def update_stage_fail(stage_id, e):
    StagePoJo = Stage
    table_stage = db.session.query(StagePoJo).filter_by(id=stage_id).first()
    table_stage.process_status = -2
    table_stage.fail_info = str(e)
    table_stage.end_time = get_time_format()
    db.session.commit()


# 先创建stage_id
def create_stage(table_id, import_type):
    # 查询出最新一条stage信息
    StagePoJo = Stage
    table_stage = db.session.query(StagePoJo).filter_by(import_table_id=table_id).order_by(desc(StagePoJo.id)).first()

    # 添加stage判断为空和上一次的stage_id
    new_stage = StagePoJo()
    new_stage.import_table_id = table_id
    new_stage.import_type = 0 if import_type == "full" else 1
    new_stage.inserted_num = 0
    new_stage.updated_num = 0
    new_stage.deleted_num = 0
    new_stage.record_num = 0
    new_stage.status = 0
    new_stage.create_time = get_time_format()
    new_stage.update_time = get_time_format()
    new_stage.begin_time = get_time_format()
    # 起始状态给-1，失败給-2，成功給0
    new_stage.process_status = -1
    if table_stage is None:
        new_stage.stage_id = 1
    else:
        new_stage.stage_id = table_stage.stage_id + 1
    db.session.add(new_stage)
    db.session.commit()
    return new_stage.id


# 更新数据的时候检查表的schema信息是不是一致
def do_check_schema(data_path, table, stage_id):
    obj = None
    if os.path.exists(data_path + '/schema.json'):
        obj = get_json_schema(data_path + '/schema.json')
    else:
        obj = schema_paser.get(data_path + '/schema.sql')

    json_origin = obj.get('origin_json')
    # 转换后的json
    name_array = obj.get('name_array')

    schema_str = get_schema(json_origin, table)

    # 查询数据库存的schema
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=table.id).order_by(desc(TableSchema.id)).first()

    # 做对比，schema与数据库存的schema信息不一致，记录信息
    if schema.schema != schema_str:
        new_stage = db.session.query(Stage).filter_by(id=stage_id).first()
        new_stage.status = -2
        new_stage.fail_info = "schema not same as old, the file path is : " + data_path
        new_stage.update_time = get_time_format()
        db.session.commit()
        return False

    return ','.join(name_array)


def load():
    # 获取数据库中存储的表的信息
    for table in db.session.query(tb_import_tables.ImportTable).filter(tb_import_tables.ImportTable.flag == 0).filter(tb_import_tables.ImportTable.active == 0).all():

        # 主键，可能是多个，按分号分割的
        src_keys = table.src_keys

        # 需要去掉字段结尾的分号
        if src_keys.endswith(";"):
            src_keys = str[0:(len(src_keys) - 1)]

        src_keys = ''.join(src_keys.split(" "))

        # 主键列,可能是多个列合并成主键列
        keys_array = src_keys.split(";")

        # 获取表路径
        path = prefix + table.dbname + "/" + table.table_name

        this_table_change = False

        # -----------------------------------------------------全量-----------------------------------------------------

        #  获取full下面文件名
        full_files = os.listdir(path + "/full")

        # 遍历每个文件夹
        for full_file_name in full_files:

            full_path = path + "/full/" + full_file_name

            if pattern.match(full_file_name) and upload_completed(full_path):
                # peocessing路径
                processing_path = path + "/processing/" + full_file_name

                # processed路径
                processed_path = path + "/processed/" + full_file_name

                # 转移文件
                shutil.move(full_path, processing_path)

                # 更新schema文件
                schema_str = do_schema(processing_path, table)

                # 先创建stage_id
                stageid = create_stage(table.id, "full")

                try:
                    # 全量更新
                    count_info = merge.merge(processing_path, "full", table.dbname, table.table_name, keys_array, schema_str, stageid, table.id)
                    # 更新此次录入的数据信息,只插入count的信息就行了
                    do_stage(stageid, table.id, inserted_num=count_info.get("inserted_num"), record_num=count_info.get("record_num"))
                except Exception as e:
                    print 'exception: ' + str(e)
                    update_stage_fail(stageid, str(e))

                # 将 processing 目录下面的东西移动到 processed目录下
                shutil.move(processing_path, processed_path)

                this_table_change = True

        # -----------------------------------------------------增量-----------------------------------------------------

        # 获取incremental下面的文件名称
        full_files = os.listdir(path + "/incremental")

        # 遍历文件家
        for full_file_name in full_files:

            full_path = path + "/incremental/" + full_file_name

            if pattern.match(full_file_name) and upload_completed(full_path):

                # processing路径
                processing_path = path + "/processing/" + full_file_name

                # processed路径
                processed_path = path + "/processed/" + full_file_name

                # 转移文件
                shutil.move(full_path, processing_path)

                # 先创建stage_id
                stageid = create_stage(table.id, "incremental")

                # 检查schema文件是否一致
                flag = do_check_schema(processing_path, table, stageid)
                if flag == False:
                    update_stage_fail(stageid, 'schema is not same as old !')
                    break
                try:
                    # 增量更新
                    count_info = merge.merge(processing_path, "incremental", table.dbname, table.table_name, keys_array, flag, stageid, table.id)
                    # 更新此次录入的数据信息,只插入count的信息就行了
                    do_stage(stageid, table.id, inserted_num=count_info.get("inserted_num"), updated_num=count_info.get("updated_num"), deleted_num=count_info.get("deleted_num"), record_num=count_info.get("record_num"))
                except Exception, e:
                    print e
                    update_stage_fail(stageid, e)

                # 将旧文件移除
                if env != 'pro':
                    shutil.rmtree(parquet_path + table.src_db + "/" + table.src_table + ".parquet")

                    # 把新生成的 temp 文件 命名为正式文件
                    os.rename(parquet_path + table.src_db + "/" + table.src_table + "_temp.parquet", parquet_path + table.src_db + "/" + table.src_table + ".parquet")

                # 将 processing 目录下面的东西移动到 processed目录下
                shutil.move(processing_path, processed_path)

                this_table_change = True

        if this_table_change is True:
            print '--->begin export to hive'
            trigger_servers.hive_server(table.id, table.dbname, table.table_name)

        if table.export_to_sql_warehouse == 1 and this_table_change is True:
            print '--->begin export to spark'
            trigger_servers.thrift_server(table.id, table.dbname, table.table_name)

        if table.export_to_es_index_warehouse == 1 and this_table_change is True:
            print "--->begin export to elasticsearch"
            trigger_servers.es_server(table.id, table.dbname, table.table_name)


while True:
    print '--->开始扫描 : ' + get_time_format()
    load()
    print '--->扫描完成 : ' + get_time_format()
    print ''
    time.sleep(2)

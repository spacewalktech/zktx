#!/usr/local/bin/python2.7
# -*- coding: utf-8 -*-：
# 文件扫描程序，扫描数据库表对应的目录下面是否有上传完成文件

import common.dao.import_tables as tb_import_tables
import common.dao.table_schema as tb_table_schema
import common.db.db_config as db
import common.dao.stage as stage
import os
import re
import time
import shutil
import json
from pyspark.sql import SparkSession
from sqlalchemy import desc
from pyspark.sql.types import *
from pyspark.sql import Row

# 系统配置的前缀
prefix = "/Users/lzf/data/"
parquet_path = "/Users/lzf/data/zktx_data/"
pattern = re.compile(r'^\d{8}_\d{2}_\d{2}_\d{2}$')
spark_master_ip = "spark://127.0.0.1:7077"
spark_warehouse = "/Users/lzf/data/warehouse"


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

# 更新parquet文件
def update_data(data_path, data_type, src_db, src_table, table_id, schema_str,stage_id):

    count_info = {}

    # 启动spark任务
    spark = SparkSession.builder.appName(" python full update ").config("spark.master", spark_master_ip).config("spark.sql.warehouse.dir", spark_warehouse).getOrCreate()

    # 表的schema
    schema_string = schema_str + ",resvd_stage_id,resvd_flag,resvd_create_time,resvd_latest_update_time"

    # 构建DF的schema
    fields = [StructField(field_name, StringType(), False) for field_name in schema_string.split(",")]
    schema_df = StructType(fields)

    # 全量更新
    if data_type == "full":
        df = spark.read.load(data_path + "/data_full.csv", format="csv", encoding="gbk", schema=schema_df)
        count = df.count()
        # TODO 这里有问题，需要动态构建
        new_data = spark.createDataFrame(df.rdd.map(lambda p: Row(
            id=p.id,
            name=p.name,
            sex=p.sex,
            age=p.age,
            info=p.info,
            resvd_stage_id=stage_id,
            resvd_flag=0,
            resvd_latest_update_time=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time())),
            resvd_create_time=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
            )))
        # 按照源表schema顺序加上隐藏字段写成parquet文件
        new_data.createOrReplaceTempView(src_db + "_" + src_table + "_temp")
        new_schema_org_df = spark.sql("select " + schema_string + " from " + src_db + "_" + src_table + "_temp")
        new_schema_org_df.write.format("parquet").mode("overwrite").save(parquet_path + src_db + "/" + src_table + ".parquet")

        count_info["inserted_num"] = count
        count_info["record_num"] = count

        return count_info
    # 增量更新
    else:


        # 需要和原有的parquet文件做对比，进行添加、修改、和删除（删除也是修改标志位）
        # 加载data_insert_updated.csv
        update_df = None
        if os.path.exists(data_path + "/data_insert_updated.csv"):
            update_df = spark.read.load(data_path + "/data_insert_updated.csv", format="csv", encoding="gbk",schema=schema_df)

        total = 0

        # 加载data_deleted.csv
        delete_df = None
        delete_id_str = None
        if os.path.exists(data_path + "/data_deleted.csv"):
            delete_df = spark.read.load(data_path + "/data_deleted.csv", format="csv", encoding="gbk", schema=schema_df)
            delete_ids = delete_df.select("id").collect()
            delete_id_arry = []
            for id in delete_ids:
                delete_id_arry.append(id.id)
            # 获取被删除的标志位 TODO,需要设计成动态获取
            delete_id_str = ",".join(delete_id_arry)

        # 加载原有parquet文件
        org_parquet_df = spark.read.load(parquet_path + src_db + "/" + src_table + ".parquet")

        # 遍历原有parquet文件，做修改和标记删除的操作 TODO 属性需要动态获取与判断修改
        new_data = spark.createDataFrame(org_parquet_df.rdd.map(lambda p: Row(
            id=p.id,
            name=p.name,
            sex=p.sex,
            age=p.age,
            info=p.info,
            resvd_stage_id=stage_id,
            resvd_flag=get_delete_flag(p.id, delete_id_str),
            resvd_create_time = p.resvd_create_time,
            resvd_latest_update_time=time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
            )))

        if delete_df is not None:
            count_info["deleted_num"] = delete_df.count()
            total += delete_df.count()

        count_info["record_num"] = total

        # 将新的DF写成parquet文件
        new_data.createOrReplaceTempView(src_db + "_" + src_table + "_temp")
        new_schema_org_df = spark.sql("select " + schema_string + " from " + src_db + "_" + src_table + "_temp")
        new_schema_org_df.write.format("parquet").mode("overwrite").save(parquet_path + src_db + "/" + src_table + "_temp.parquet")

        return  count_info

# 转换类型 TODO
def get_stand_type(old_type):
    if "char" in old_type:
        return "string"
    return old_type

# 获取schema描述
def get_schema(schema_path):
    file_object = open(schema_path + "/schema.json")
    schema_str = ""
    try:
        for line in file_object.readlines():
            schema_str += line.strip("\n")
    finally:
        file_object.close()
    return schema_str

# 获取schema的string
def get_schema_str(schema_str):
    schema = json.loads(schema_str)
    array = []
    for i in schema.get("schema"):
        array.append(i.get("name"))
    return ",".join(array)

# 处理schema
def do_schema(schema_path, id):
    schema_str = get_schema(schema_path)
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=id).first()

    if schema is None:
        schema = TableSchema()
        schema.table_id = id
        schema.version = 1
        schema.schema = schema_str
        schema.create_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        schema.update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        db.session.add(schema)
    else:
        schema.version = int(schema.version) + 1
        schema.schema = schema_str
        schema.update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    db.session.commit()

    return get_schema_str(schema_str)


# 添加stage
def do_stage(stage_id , table_id, import_type="full", inserted_num=0, updated_num=0, deleted_num=0, record_num=0):
    StagePoJo = stage.Stage
    table_stage = db.session.query(StagePoJo).filter_by(id=stage_id).first()
    table_stage.inserted_num =  0 if  inserted_num is None else inserted_num
    table_stage.updated_num = 0 if  updated_num is None else updated_num
    table_stage.deleted_num = 0 if  deleted_num is None else deleted_num
    table_stage.record_num = 0 if  record_num is None else record_num
    db.session.commit()

# 先创建stage_id
def create_stage(table_id ,import_type):
    StagePoJo = stage.Stage
    table_stage = db.session.query(StagePoJo).filter_by(import_table_id=table.id).order_by(desc(StagePoJo.id)).first()
    # 添加stage判断为空和上一次的stage_id
    new_stage = StagePoJo()
    new_stage.import_table_id = table_id
    new_stage.import_type = 0 if import_type == "full" else 1
    new_stage.inserted_num = 0
    new_stage.updated_num = 0
    new_stage.deleted_num = 0
    new_stage.record_num = 0
    new_stage.create_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    new_stage.update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    new_stage.process_status = 0
    if table_stage is None:
        new_stage.stage_id = 1
    else:
        new_stage.stage_id = table_stage.stage_id + 1
    db.session.add(new_stage)
    db.session.commit()
    return new_stage.id

def do_check_schema(data_path , table_id, stage_id):
    # 需要对比schema信息是不是与数据库的schema一样
    schema_str = get_schema(data_path)
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=table_id).first()
    if schema.schema != schema_str:
        # schema与数据库存的schema信息不一致，记录信息
        Stage = stage.Stage
        new_stage = db.session.query(Stage).filter_by(id=stage_id).first()
        new_stage.status = 1
        new_stage.fail_info = "增量更新时发现schema不一致"
        new_stage.update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        db.session.commit()
        return False
    return get_schema_str(schema_str)

# 获取数据库中存储的表的信息
for table in db.session.query(tb_import_tables.ImportTable).all():

    # 获取表路径
    path = prefix + table.src_db + "/" + table.src_table

    # 找到时间戳文件夹
    # -----------------------------------------------------全量-----------------------------------------------------
    # full_files = os.listdir(path + "/full")
    # for full_file_name in full_files:
    #     full_path = path + "/full/" + full_file_name
    #     processing_path = path + "/processing/" + full_file_name
    #     processed_path = path + "/processed/" + full_file_name
    #
    #     if pattern.match(full_file_name) and upload_completed(full_path):
    #         # 转移文件
    #         shutil.move(full_path, processing_path)
    #         # 更新schema文件
    #         schema_str = do_schema(processing_path, table.id)
    #         # 先创建stage_id
    #         stageid = create_stage(table.id , "full")
    #         # 全量更新
    #         count_info = update_data(processing_path, "full", table.src_db, table.src_table, table.id,schema_str,stageid)
    #         # 更新此次录入的数据信息,只插入count的信息就行了
    #         do_stage(stageid, table.id, inserted_num=count_info.get("inserted_num"), record_num=count_info.get("record_num"))
    #         # 将 processing 目录下面的东西移动到 processed目录下
    #         shutil.move(processing_path, processed_path)
    # -----------------------------------------------------增量-----------------------------------------------------
    full_files = os.listdir(path + "/incremental")
    for full_file_name in full_files:
        full_path = path + "/incremental/" + full_file_name
        processing_path = path + "/processing/" + full_file_name
        processed_path = path + "/processed/" + full_file_name

        if pattern.match(full_file_name) and upload_completed(full_path):
            # 转移文件
            # shutil.move(full_path, processing_path)
            # 先创建stage_id
            stageid = create_stage(table.id , "full")
            # 检查schema文件是否一致
            flag = do_check_schema(processing_path , table.id, stageid)
            if flag == False:
                break
            # 增量更新
            count_info = update_data(processing_path, "incremental", table.src_db, table.src_table, table.id, flag, stageid)
            # 更新此次录入的数据信息,只插入count的信息就行了
            do_stage(stageid, table.id, inserted_num=count_info.get("inserted_num"), updated_num=count_info.get("updated_num"), deleted_num=count_info.get("deleted_num"), record_num=count_info.get("record_num"))
            # 将temp文件移动到正式里面去
            shutil.rmtree(parquet_path + table.src_db + "/" + table.src_table + ".parquet")
            os.rename(parquet_path + table.src_db + "/" + table.src_table + "_temp.parquet" , parquet_path + table.src_db + "/" + table.src_table + ".parquet")
            # # 将 processing 目录下面的东西移动到 processed目录下
            shutil.move(processing_path, processed_path)



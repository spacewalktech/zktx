#!/usr/local/bin/python2.7
# -*- coding: utf-8 -*-：
# 文件扫描程序，扫描数据库表对应的目录下面是否有上传完成文件

import common.dao.tb_import_tables as tb_import_tables
import common.dao.tb_table_schema as tb_table_schema
import common.db.db_config as db
import os
import re
import time
import shutil
from pyspark.sql import SparkSession

# 系统配置的前缀
prefix = "/Users/lzf/data/"
parquet_path = "/Users/lzf/data/zktx_data/"
pattern = re.compile(r'^\d{8}_\d{2}_\d{2}_\d{2}$')


# 判断目录中文件是否上传完成
def upload_completed(file_path):
    if "upload_completed" in '|'.join(os.listdir(file_path)):
        return True
    return False


# 全量更新
# df = spark.read.load("/Users/lzf/python/zktx/filescan/ABC.parquet", format="parquet")
# df.show()
# df.createOrReplaceTempView("abc")
# spark.sql("select * from abc").show()
# spark.sql("alter abc set serdeproperties('serialization.encoding'='GBK')")
# spark.sql("select * from abc").show()
def update_data(data_path, data_type, src_db, src_table):
    # 启动spark任务,将文件以parquet的形式存放到指定目录下
    spark = SparkSession.builder.appName(" python full update ").config("spark.master",
                                                                        "spark://127.0.0.1:7077").getOrCreate()
    df = spark.read.load(data_path + "/data_full.csv", format="csv")
    count = df.count()
    df.write.format("parquet").mode("overwrite").save(parquet_path + src_db + "/" + src_table + ".parquet")
    return count


# 处理schema
def do_schema(schema_path, id):
    file_object = open(schema_path + "/schema.json")
    schema_str = ""
    try:
        for line in file_object.readlines():
            schema_str += line.strip("\n")
    finally:
        file_object.close()
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=id).first()
    schema.version = int(schema.version) + 1
    schema.schema = schema_str
    schema.update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    db.session.commit()


# 获取数据库中存储的表的信息
for table in db.session.query(tb_import_tables.ImportTable).all():

    # 获取表路径
    path = prefix + table.src_db + "/" + table.src_table

    # 找到时间戳文件夹
    full_files = os.listdir(path + "/full")
    for full_file_name in full_files:

        full_path = path + "/full/" + full_file_name
        processing_path = path + "/processing/" + full_file_name
        processed_path = path + "/processed/" + full_file_name

        if pattern.match(full_file_name) and upload_completed(full_path):
            # 转移文件
            shutil.move(full_path, processing_path)
            # 全量更新
            count = update_data(processing_path, "full", table.src_db, table.src_db)
            # 更新schema文件
            do_schema(processing_path, table.id)
            # 更新此次录入的数据信息,只插入count的信息就行了
            print "此次插入了：" + str(count) + " 条"
            # 将 processing 目录下面的东西移动到 processed目录下
            shutil.move(processing_path, processed_path)

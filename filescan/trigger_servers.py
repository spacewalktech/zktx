# -*- coding: utf-8 -*-：
# 扫描触发 thriftserver服务 ES 服务

import common.dao.table_schema as tb_table_schema
import common.db.db_config as db
from pyspark.sql import SparkSession
import json
import common.config.config as common_config, common.util.util as common_util
from impala.dbapi import connect
from es.es_client import ESClient
from sqlalchemy import desc

env = common_util.getParam("env")

if env == "pro":
    setting = common_config.pro_path
else:
    setting = common_config.dev_path

# 存放parquet文件的地址
parquet_path = setting.get("parquet_path")


def get_cursor():
    conn = connect(host='hadoop01', port=10000, auth_mechanism='PLAIN', user='hadoop', password='hadoop')
    cur = conn.cursor()
    return cur


def get_hive_cursor():
    conn = connect(host='hadoop01', port=10001, auth_mechanism='PLAIN', user='hadoop', password='hadoop')
    cur = conn.cursor()
    return cur


def get_schema(table_id):
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=table_id).order_by(desc(TableSchema.id)).first()
    return schema


def get_create_sql(schema, db_name, table_name):
    schema = json.loads(schema)
    sql = 'create external table if not exists ' + db_name + '.' + table_name + '_text ' + '('
    array = []
    for i in schema.get("schema"):
        array.append(i.get("name") + ' string')
    array.append('resvd_flag string')
    sql += ', '.join(array) + ')'
    sql += "row format serde 'org.openx.data.jsonserde.JsonSerDe' location 'hdfs://hadoop01:9000/spacewalk/hdfs/parquet_file/" + db_name + "/" + table_name + ".json'"
    return sql


def get_parquet_sql(schema, db_name, table_name):
    schema = json.loads(schema)
    array = []
    for i in schema.get("schema"):
        array.append(i.get("name"))
    sb = ', '.join(array)
    sql = 'create table if not exists ' + db_name + '.' + table_name + ' stored as parquetfile as select ' + sb + ' from ' + db_name + '.' + table_name + '_text where resvd_flag !=1'
    return sql


def es_server(table_id, db_name, table_name):
    spark = SparkSession.builder.appName(" python es [ " + db_name + "_" + table_name + " ]") \
        .config("spark.master", "yarn") \
        .config("spark.yarn.jars", "hdfs://hadoop01:9000/user/spark-with-hive/lib/*.jar") \
        .config("spark.sql.warehouse.dir", "hdfs://hadoop01:9000/user/spark-with-hive/warehouse").getOrCreate()
    path = parquet_path + db_name + "/" + table_name + ".json"
    df = spark.read.json(path)
    esClient = ESClient(index=db_name, type=table_name)
    esClient.writeDF2ES(df)


def hive_server(table_id, db_name, table_name):
    try:
        # 获取schema
        schema = get_schema(table_id)
        # 获取建表语句
        sql = get_create_sql(schema.schema, db_name, table_name)
        # 获取连接
        cur = get_hive_cursor()
        # 需要创建数据库
        cur.execute('create database if not exists ' + db_name)
        # 移除以前的旧表
        cur.execute('drop table if exists ' + db_name + '.' + table_name + '_text')
	# 添加json的jar
	cur.execute('add jar /opt/spacewalk/spark-with-hive/jars/json-serde-1.3.9-SNAPSHOT-jar-with-dependencies.jar')
        # 创建外表
        cur.execute(sql)
        # 移除以前的parquet表
        cur.execute('drop table if exists ' + db_name + '.' + table_name)
        # 获取parquet表语句
        sql = get_parquet_sql(schema.schema, db_name, table_name)
        # 创建parquet表
        cur.execute(sql)
        # 移除text表
        cur.execute('drop table if exists ' + db_name + '.' + table_name + '_text')
    except Exception, e:
        print e


def thrift_server(table_id, db_name, table_name):
    try:
        # 获取schema
        schema = get_schema(table_id)
        # 获取建表语句
        sql = get_create_sql(schema.schema, db_name, table_name)
        # 获取连接
        cur = get_cursor()
        # 需要创建数据库
        cur.execute('create database if not exists ' + db_name)
        # 移除以前的旧表
        cur.execute('drop table if exists ' + db_name + '.' + table_name + '_text')
        # 创建外表
        cur.execute(sql)
        # 移除以前的parquet表
        cur.execute('drop table if exists ' + db_name + '.' + table_name)
        # 获取parquet表语句
        sql = get_parquet_sql(schema.schema, db_name, table_name)
        # 创建parquet表
        cur.execute(sql)
        # 移除text表
        cur.execute('drop table if exists ' + db_name + '.' + table_name + '_text')
    except Exception, e:
        print e


def load():
    hive_server(1, 'spark', 'utiisales')

#load()

# -*- coding: utf-8 -*-：
# 扫描触发 thriftserver服务 ES 服务

import common.dao.table_schema as tb_table_schema
import common.db.db_config as db
import json
from impala.dbapi import connect


def get_cursor():
    conn = connect(host='hadoop01', port=10000, auth_mechanism='PLAIN', user='hadoop', password='hadoop')
    cur = conn.cursor()
    return cur


def get_schema(table_id):
    TableSchema = tb_table_schema.TableSchema
    schema = db.session.query(TableSchema).filter_by(table_id=table_id).first()
    return schema


def get_create_sql(schema, db_name, table_name):
    schema = json.loads(schema)
    sql = 'create table if not exists ' + db_name + '.' + table_name + '_text ' + '('
    array = []
    for i in schema.get("schema"):
        array.append(i.get("name") + ' string')
    sql += ', '.join(array) + ')'
    sql += "row format serde 'org.apache.hive.hcatalog.data.JsonSerDe' location 'hdfs://hadoop01:9000/spacewalk/hdfs/parquet_file/" + db_name + "/" + table_name + ".json'"
    return sql


def get_parquet_sql(schema, db_name, table_name):
    schema = json.loads(schema)
    sql = 'create table if not exists ' + db_name + '.' + table_name + ' stored as parquetfile as select * from ' + db_name + '.' + table_name + '_text '
    return sql


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
    thrift_server(1, 'spark', 'utiisales')

#load()

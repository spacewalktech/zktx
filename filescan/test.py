# -*- coding: utf-8 -*-：

import os
import time
import common.config.config as common_config, common.util.util as common_util
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from hdfs import *
from impala.dbapi import connect

# spark = SparkSession.builder.appName(" python update table").config("spark.master", "yarn").config("spark.sql.warehouse.dir", "/opt/spacewalk/data").getOrCreate()
# df = spark.read.load("hdfs://hadooop01:9000/spacewalk/hdfs/parquet_file/test_db/test_table.parquet", format='parquet')
# df.limit(10).show()


# client = Client('http://hadoop01:50070')
# print(client.list('/'))

# while True:
#     print 1
#     time.sleep(3)

conn = connect(host='hadoop01', port=10000, auth_mechanism='PLAIN')
cur = conn.cursor()
cur.execute('show databases')
print cur.fetchall()


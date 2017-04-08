# -*- coding: utf-8 -*-：

import os
import time
import common.config.config as common_config, common.util.util as common_util
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from hdfs import *
from impala.dbapi import connect

# spark = SparkSession.builder.appName(" python test ").config("spark.master", "spark://LZFdeMacBook-Pro.local:7077").config("spark.sql.warehouse.dir", "/opt/spacewalk/data").getOrCreate()
# schema_str = "usercode,username,comcodetype,companyname,comcode,manorgcode,manorgname,groupusercode,newusercode,idtypecode,idtypename,identifynumber,articlecode,phonenumber,faxnumber,mobilephone,email,postaddress,postcode,remark,tcol1,tcol2,tcol3,tcol4,tcol5,validstatus,flag"
# fields = [StructField(field_name, StringType(), False) for field_name in schema_str.split(",")]
# schema_df = StructType(fields)
# df = spark.read.format('csv').schema(schema_df).option("delimiter", "|").load("/Users/lzf/ZKTX/utiisales.txt")
# df.show()


# client = Client('http://hadoop01:50070')
# print(client.list('/'))

# while True:
#     print 1
#     time.sleep(3)

# conn = connect(host='hadoop01', port=10000, auth_mechanism='PLAIN')
# cur = conn.cursor()
# cur.execute('show databases')
# print cur.fetchall()

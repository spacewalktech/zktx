from pyspark.sql import SparkSession
from datetime import datetime
import json
from es.es_client import ESClient

spark = SparkSession.builder.master("yarn").appName("Simple App").getOrCreate()
path = "/spacewalk/hdfs/parquet_file/ahpicc/prplwideclaim.json"
df = spark.read.json(path)
esClient = ESClient(index="ahpicc_v1", type="prplwideclaim")
esClient.writeDF2ES(df)


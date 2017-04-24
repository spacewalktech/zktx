from pyspark.sql import SparkSession
from es.es_client import ESClient

spark = SparkSession.builder.master("yarn").appName("Simple App").getOrCreate()
# sc = SparkContext("local", "Simple App")
path = "file:///opt/spark-2.1.0-bin-hadoop2.7/python/test_support/sql/people.json"
df = spark.read.json(path)
esClient = ESClient(index="db_people", type="tb_people")

esClient.writeDF2ES(df)

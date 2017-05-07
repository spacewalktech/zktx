from pyspark.sql import SparkSession
from es.es_client import ESClient

# spark = SparkSession.builder.master("yarn").appName("Simple App").getOrCreate()
# # sc = SparkContext("local", "Simple App")
# path = "file:///opt/spark-2.1.0-bin-hadoop2.7/python/test_support/sql/people.json"
# df = spark.read.json(path)
esClient = ESClient(index="test_db_people2", type="test_tb_people2", id_field="name")

# esClient.writeDF2ES(df)
esClient.deleteItem()
from pyspark.sql import SparkSession
from es.es_client import ESClient

spark = SparkSession.builder.master("yarn").appName("Simple App").getOrCreate()
# sc = SparkContext("local", "Simple App")
path = "/spacewalk/hdfs/parquet_file/ahpicc/prplwideclaim.json"
#path = "/wenjun/one_line.json"
df = spark.read.json(path)
#df.printSchema()
#df.select('exgratiafee').limit(10).show()
#df.select('compensateno').limit(10).show()
#df.limit(10).show()
# ahpicc/prplcompensate
esClient = ESClient(index="ahpicc_v1", type="prplwideclaim")
esClient.writeDF2ES(df)
#esClient.deleteItem("Andy")

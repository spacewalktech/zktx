from pyspark.sql import SparkSession
from datetime import datetime
import json
from es.es_client import ESClient

spark = SparkSession.builder.master("yarn").appName("Simple App").getOrCreate()
# sc = SparkContext("local", "Simple App")
#path = "file:///opt/spacewalk/spark-with-hive/examples/src/main/resources/people.json"
#df = spark.read.json(path)

# doc = {
#     'author': 'kimchy',
#     'text': 'Elasticsearch: cool. bonsai cool.',
#     'timestamp': datetime.now(),
# }

esClient = ESClient(index="test_db_people", type="test_tb_people", id_field="name")
# res = esClient.es.index(index="test-index", doc_type='tweet', id=1, body=doc)
#esClient.writeDF2ES(df)
#esClient.deleteItem("Andy")
mapping = """
{
    "properties":{
       "author":{
          "type":"text"
       },
       "text":{
          "type":"text"
       },
       "timestamp2":{
          "type":"date"
       }
    }
}
"""
mp = json.loads(mapping)
res = esClient.es.indices.put_mapping("test_tb_people2", body=mapping, index='test_db_people2')


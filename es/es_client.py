# -*- coding: utf-8 -*-：
from common import config
from elasticsearch import Elasticsearch
from common.util.logger import Logger
from common.config import config

class ESClient(object):

    """
    Elasticsearch client, used to interact with elasticsearch cluster,
    also it can write spark rdd and its higher derivative type like dataframe and so on.
    """

    def __init__(self,  index, type, nodes=None):
        self.logger = Logger(self.__class__.__name__).get()
        if not nodes:
            self.nodes = config.es_hosts
        else:
            self.nodes = nodes
        self.es = Elasticsearch(nodes)
        self.es_conf = {}
        self.es_conf["es.resource"] = index + "/" + type
        self.es_conf["es.nodes"] = convertArrayToFlatString(self.nodes)

    def __str__(self):
        return "[ESClient: %s]" % self.es_conf

    def writeRDD2ES(self, rdd):
        try:
            rdd.saveAsNewAPIHadoopFile(
                path='-',
                outputFormatClass="org.elasticsearch.hadoop.mr.EsOutputFormat",
                keyClass="org.apache.hadoop.io.NullWritable",
                valueClass="org.elasticsearch.hadoop.mr.LinkedMapWritable",
                conf=self.es_conf)
        except:
            self.logger.error("Failed to write es(%s)" % self)
            raise

    def writeDF2ES(self, df):
        dfRDD = df.rdd.map(lambda row: (None, row.asDict()))
        self.writeRDD2ES(dfRDD)

    def createIndex(self):
        pass

def convertArrayToFlatString(array):
    s = ""
    for i in array:
        s += str(i)
        s += ","
    return s[:-1]

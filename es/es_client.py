# -*- coding: utf-8 -*-：
from common import config
from common.util.logger import Logger
from common.util.util import CommonUtil
from common.config import config
from elasticsearch import Elasticsearch

class ESClient(object):

    """
    Elasticsearch client, used to interact with elasticsearch cluster,
    also it can write spark rdd and its higher derivative type like dataframe and so on.
    """

    def __init__(self,  index, type, id_field=None, nodes=None):
        self.logger = Logger(self.__class__.__name__).get()
        self.index = index
        self.type = type
        self.id_field = id_field

        self.es_conf = {}
        if id_field:
            self.es_conf["es.mapping.id"] = id_field
        if not nodes:
            self.es_conf["es.nodes"] = convertArrayToFlatString(config.es_hosts)
            self.nodes = config.es_hosts
            self.es = Elasticsearch(config.es_hosts)
        else:
            self.es_conf["es.nodes"] = convertArrayToFlatString(nodes)
            self.nodes = nodes
            self.es = Elasticsearch(nodes)

        self.es_conf["es.resource"] = index + "/" + type

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
        self.createIndexFromDF(df)
        dfRDD = df.rdd.map(lambda row: (None, row.asDict()))
        self.writeRDD2ES(dfRDD)

    def deleteItem(self, id_value):
        if not self.id_field:
            raise Exception("The ESClient(%s) does not specify id_field, can not delete item" % self.es_conf)
        self.es.delete(self.index, self.type, id_value)

    def createIndexFromDF(self, df):
        mp_dict = {}
        property_dict = {}
        mp_dict["mappings"] = {}
        mp_dict["mappings"][self.type] = {}
        mp_dict["mappings"][self.type]["properties"] = property_dict
        for col in df.schema:
            f_dict = {}
            property_dict[col.name] = f_dict
            f_dict["type"] = CommonUtil.getESType(col.dataType.typeName())
        self.es.indices.put_mapping(self.type, body=mp_dict, index=self.index)

def convertArrayToFlatString(array):
    s = ""
    for i in array:
        s += str(i)
        s += ","
    return s[:-1]

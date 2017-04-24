# -*- coding: utf-8 -*-:
import sys
import json
from common.config import config
from common.util.util import HDFSUtil
from common.util.logger import Logger
from pyspark.sql import SparkSession
reload(sys)
sys.setdefaultencoding('utf-8')

class DataContext(object):

    def __init__(self):
        self.logger = Logger(self.__class__.__name__).get()
        self.sparkSession = SparkSession \
            .builder.master("yarn") \
            .appName("Spark SQL for DataContext") \
            .getOrCreate()

    def getDataFrameByDBTable(self, db_name, table_name):
        parquet_file = config.pro_path["parquet_path"] + "/" + db_name + "/" + table_name + ".parquet"
        df = self.sparkSession.read.load(parquet_file)
        return df

    def saveDataFrame(self, df, db_name, table_name, is_full):
        if len(sys.argv) < 2:
            raise Exception("Export destination path should be given as an argument")
        export_dir_path = sys.argv[1]
        export_base_path = export_dir_path + "/" + db_name + "/" + table_name
        if is_full:
            export_file_path = export_base_path + "/full/data.parquet"
        else:
            export_file_path = export_base_path + "/incremental/data.parquet"
        try:
            df.write.parquet(export_file_path)
        except:
            self.logger.error("Write parquet %s Error" % export_file_path)
            raise

        export_schema_path = export_base_path + "/schema.json"
        destSchema = {}
        destSchema["db_type"] = "derivative"
        destSchema["db_version"] = None
        destSchema["db_name"] = db_name
        destSchema["table_name"] = table_name
        destSchema["schema"] = df.schema.jsonValue()["fields"]
        tmp_schema_path = "/tmp/" + db_name + "_" + table_name + ".json"
        localTempFile = open(tmp_schema_path, mode="w")
        localTempFile.write(json.dumps(destSchema))
        localTempFile.close()
        hUtil = HDFSUtil()
        hUtil.upload2HDFS(tmp_schema_path, export_schema_path)

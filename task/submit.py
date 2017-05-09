# -*- coding: utf-8 -*-:

import subprocess
import datetime
from common.util import util
from common.util.util import CommandExecutor, HDFSUtil, HiveUtil
from common.config import config
from common.util.logger import Logger

TASK_TYPE = {
    0: "SPARK",
    1: "HIVE"
}

class Submitter(object):

    """
    :arg spark_submit_bin: spark-submit script location
    :arg hive_submit_bin: :hive script location
    :arg hdfs_bin: :hdfs script location
    """

    def __init__(self, spark_submit_bin=None, hive_submit_bin=None):
        self.logger = Logger(self.__class__.__name__).get()
        if not spark_submit_bin:
            if not config.spark_home:
                raise RuntimeError("spark_home must be specified in config")
            self.spark_submit_bin = config.spark_home + "/bin/spark-submit"

        if not hive_submit_bin:
            if not config.hive_home:
                raise RuntimeError("spark_home must be specified in config")
            self.hive_submit_bin = config.hive_home + "/bin/hive"

    def submit(self, active_task):
        if TASK_TYPE[active_task.type] == "HIVE":
            hiveUtil = HiveUtil()
            for tab in active_task.export_table_list:
                hiveUtil.dropTable(tab)
            cmd_exec = CommandExecutor(self.hive_submit_bin, "-f", active_task.bin_file_uri)
            cmd_exec.execute()
            self.logger.debug("Export export_table_list: (%s)", active_task.export_table_list)
            for tab in active_task.export_table_list:
                # export hive table (data & schema) to hdfs similar to spark task
                #export_sub_dir = active_task.export_dir_uri + "/" + active_task.db_name + "." + tab
                db_name, table_name = util.splitDBAndTable(tab)
                hiveUtil.exportTable(db_name, table_name, True, active_task.export_dir_uri)

        elif TASK_TYPE[active_task.type] == "SPARK":
            hdfsUtil = HDFSUtil()
            local_bin_file = "/tmp/" + util.getPathFlat(active_task.bin_file_uri)
            hdfsUtil.downloadFileFromHDFS(local_bin_file, active_task.bin_file_uri)
            cmd_exec = CommandExecutor(self.spark_submit_bin, local_bin_file, active_task.export_dir_uri)
            cmd_exec.execute()
            if local_bin_file:
                util.removeLocalFile(local_bin_file)
        if active_task.has_derivative_table:
            hdfsUtil = HDFSUtil()
            tables_in_file = []
            for tab in active_task.export_table_list:
                db_tb = util.splitDBAndTable(tab)
                d, t = db_tb[0], db_tb[1]
                tables_in_file.append(d + "--" + t)
            export_files = hdfsUtil.extractFilesFromDir(active_task.export_dir_uri, *tables_in_file)
            self.logger.debug("Files generated in (%s) are (%s)" % (active_task.export_dir_uri, export_files))
            #data_files = hdfsUtil.getFilesBySuffix(export_files, ".parquet")
            data_files = hdfsUtil.getFilesBySuffix(export_files, ".csv")
            data_files.sort()
            self.logger.debug("Data files are (%s)" % data_files)
            schema_files = hdfsUtil.getFilesBySuffix(export_files, "schema.sql")
            schema_files.sort()
            self.logger.debug("Schema files are (%s)" % schema_files)
            for data_file in data_files:
                # data_file = data_files[i]
                db_name, tb_name, timestamp, is_full = hdfsUtil.getExportProperties(data_file)
                schema_file = util.getFileFromTimestamp(schema_files, timestamp)
                if is_full:
                    full_str = "full"
                else:
                    full_str = "incremental"
                cur_time = datetime.datetime.now()
                date_str = util.paddingTimeNum(cur_time.year) + util.paddingTimeNum(cur_time.month) + util.paddingTimeNum(cur_time.day) + "_" \
                           + util.paddingTimeNum(cur_time.hour) + "_" + util.paddingTimeNum(cur_time.minute) + "_" + util.paddingTimeNum(cur_time.second)
                dest_dir = config.pro_path["prefix"] + "/" + db_name + "/" + tb_name + "/" + full_str + "/" + date_str
                if is_full:
                    data_file_dest = dest_dir  + "/" + "data_full.csv"
                else:
                    data_file_dest = dest_dir  + "/" + "data_incremental.csv"
                #data_file_dest = dest_dir  + "/" + "data_full.parquet"
                schema_file_dest = dest_dir + "/" + "schema.sql"
                hdfsUtil.copyMRResults2Local(data_file, data_file_dest)
                hdfsUtil.copyMRResults2Local(schema_file, schema_file_dest)
                util.convertCSV2PipeDelimited(data_file_dest)
                done_indicator_file = dest_dir + "/" + "upload_completed"
                util.touch(done_indicator_file)

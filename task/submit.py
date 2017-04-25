# -*- coding: utf-8 -*-:

import subprocess
import datetime
from common.util import util
from common.util.util import CommandExecutor, HDFSUtil
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
        cmd_exec = None
        if TASK_TYPE[active_task.type] == "HIVE":
            cmd_exec = CommandExecutor(self.hive_submit_bin, "-e")
        elif TASK_TYPE[active_task.type] == "SPARK":
            cmd_exec = CommandExecutor(self.spark_submit_bin, active_task.bin_file_uri, active_task.export_dir_uri)
        cmd_exec.execute()
        if active_task.has_derivative_table:
            hUtil = HDFSUtil()
            export_files = hUtil.extractFilesFromDir(active_task.export_dir_uri)
            data_files = hUtil.getFilesBySuffix(export_files, ".parquet").sort()
            schema_files = hUtil.getFilesBySuffix(export_files, "schema.json").sort()
            for i in range(len(data_files)):
                data_file = data_files[i]
                schema_file = schema_files[i]
                db_name, tb_name, is_full = hUtil.getExportProperties(data_file)
                if is_full:
                    full_str = "full"
                else:
                    full_str = "incremental"
                cur_time = datetime.datetime.now()
                date_str = util.paddingTimeNum(cur_time.year) + util.paddingTimeNum(cur_time.month) + util.paddingTimeNum(cur_time.day) + "_" \
                           + util.paddingTimeNum(cur_time.hour) + "_" + util.paddingTimeNum(cur_time.minute) + "_" + util.paddingTimeNum(cur_time.second)
                dest_dir = config.pro_path["prefix"] + "/" + db_name + "/" + tb_name + "/" + full_str + "/" + date_str
                data_file_dest = dest_dir  + "/" + "data_full.parquet"
                schema_file_dest = dest_dir + "/" + "schema.json"
                hUtil.copyMRResults2Local(data_file, data_file_dest)
                hUtil.copyMRResults2Local(data_file, schema_file_dest)



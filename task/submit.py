# -*- coding: utf-8 -*-:

import subprocess
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
            hUtil.copyMRResults2Local(active_task.bin_file_uri, config.pro_path["prefix"])

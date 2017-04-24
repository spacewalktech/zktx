# -*- coding: utf-8 -*-:
# 工具类

import sys
import json
import subprocess
from common.entity.triggle_cond import TriggleCond
from common.entity.stage_to_process import StageToProcess
from common.config import config

def get_param(param_name=None):
    if (param_name == None):
        return None
    param_name = str.strip(param_name)
    argv = sys.argv

    for index, item in enumerate(argv):
        item = str.strip(item)
        if (param_name == item):
            return argv[index + 1]
          
def decode_triggle_conds(triggle_cond_in_text):
    triggle_list = [] # [<table_id, import_type>, ...]
    triggles = json.loads(triggle_cond_in_text)
    for triggle_dict in triggles:
        for table_id in triggle_dict:
            triggle_obj = TriggleCond()
            triggle_obj.table_id = int(table_id)
            triggle_obj.import_type = triggle_dict[table_id]
            triggle_list.append(triggle_obj)
    return triggle_list

def decode_table_stage_info(stage_info):
    # return stage info list [<table, stage_begin, stage_end>]
    table_stage_dict = json.loads(stage_info) # {"table_a": [1,5],"table_b":[5,7]}
    stage_info_list = []
    for tab in table_stage_dict:
        stage_info = StageToProcess(tab, table_stage_dict[tab][0], table_stage_dict[tab][1])
        stage_info_list.append(stage_info)
    return stage_info_list

def encode_table_stage(stage_info_list):
    stp_dict = {}
    for stp in stage_info_list:
        stp_dict[stp.table_id] = [stp.stage_begin, stp.stage_end]
    return json.dumps(stp_dict)

def object_list_to_str(object_list):
    ret_str = "["
    for obj in object_list:
        ret_str = "%s, %s" % (ret_str, obj)
    ret_str += "]"
    return ret_str

class HDFSUtil(object):
    def __init__(self, hdfs_bin=None):
        if hdfs_bin == None:
            if not config.hadoop_home:
                raise RuntimeError("spark_home must be specified in config")
            self.hdfs_bin = config.hadoop_home + "/bin/hdfs"

    def copyMRResults2Local(self, src_path, dest_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-getmerge", src_path, dest_path)
        cmd_exec.execute()

    def upload2HDFS(self, src_path, dest_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-put", src_path, dest_path)
        cmd_exec.execute()

class CommandExecutor(object):

    def __init__(self, bin_file, *args):
        self.bin_file = bin_file
        self.args = args

    def execute(self):
        cmd_with_args = [self.bin_file]
        for arg in self.args:
            cmd_with_args.append(arg)
        try:
            subprocess.call(cmd_with_args)
        except:
            self.logger.info("exec cmd: %s Error", cmd_with_args)
            raise
        return 0
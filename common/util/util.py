# -*- coding: utf-8 -*-:
# 工具类
import os
import sys
import json
import subprocess
from common.entity.triggle_cond import TriggleCond
from common.entity.stage_to_process import StageToProcess
from common.config import config
from common.util.logger import Logger

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

def convertCSV2PipeDelimited(data_file_path):
    new_data_file_path = rreplace(data_file_path, ".csv", ".txt", 1)
    with open(data_file_path, 'rt') as fin, \
            open(new_data_file_path, 'wt') as fout:
        reader = csv.DictReader(fin)
        writer = csv.DictWriter(fout, reader.fieldnames, delimiter='|', lineterminator = '\n')
        writer.writeheader()
        writer.writerows(reader)
        fin.close()
        fout.close()
    os.remove(data_file_path)

def rreplace(s, old, new, occurrence):
	li = s.rsplit(old, occurrence)
	return new.join(li)

class HDFSUtil(object):
    def __init__(self, hdfs_bin=None):
        self.logger = Logger(self.__class__.__name__).get()
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

    def extractFilesFromDir(self, dir_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-ls", dir_path)
        output = cmd_exec.execute_output()
        outputs = output.split("\n")
        files = []
        for line in outputs:
            line_arr = line.split()
            if len(line_arr) > 5:
                files.append(line_arr[-1])
        return files

    def getFilesBySuffix(self, files, suffix):
        ret_files = []
        slen = len(suffix)
        for fname in files:
            self.logger.debug("suffix is: (%s), fname is: (%s)" % (suffix, fname))
            if suffix == fname[-slen:]:
                ret_files.append(fname)
        return ret_files

    def getExportProperties(self, data_file):
        file_name = os.path.basename(data_file)
        name_splits = file_name.split("--")
        db_name = name_splits[0]
        tb_name = name_splits[1]
        is_full = 1 if name_splits[2] == "full" else 1
        return db_name, tb_name, is_full

class CommandExecutor(object):

    def __init__(self, bin_file, *args):
        self.logger = Logger(self.__class__.__name__).get()
        self.bin_file = bin_file
        self.args = args

    def execute(self):
        cmd_with_args = [self.bin_file]
        local_env = os.environ.copy()
        local_env["SPARK_HOME"] = config.spark_home 
        for arg in self.args:
            cmd_with_args.append(arg)
        try:
            subprocess.call(cmd_with_args, env=local_env)
        except:
            self.logger.info("exec cmd: %s Error", cmd_with_args)
            raise
        return 0

    def execute_output(self):
        cmd_with_args = [self.bin_file]
        local_env = os.environ.copy()
        local_env["SPARK_HOME"] = config.spark_home
        for arg in self.args:
            cmd_with_args.append(arg)
        try:
            output = subprocess.check_output(cmd_with_args, env=local_env)
        except:
            self.logger.info("exec cmd: %s Error", cmd_with_args)
            raise
        return output

def paddingTimeNum(num):
    if num < 10:
        return "0" + str(num)
    return str(num)

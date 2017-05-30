# -*- coding: utf-8 -*-:
# 工具类
import os
import sys
import json
import subprocess
import csv
import time
import datetime
import pytz
from common.entity.triggle_cond import TriggleCond
from common.entity.stage_to_process import StageToProcess
from common.config import config
from common.util.logger import Logger

# 获取文件大小
def get_file_size(file_path):
    if file_path is None:
        return 0
    size = os.path.getsize(file_path)
    return formatSize(size)


# 转换文件大小单位
def formatSize(bytes):
    try:
        bytes = float(bytes)
        kb = bytes / 1024
    except:
        print("传入的字节格式不对")
        return "Error"

    if kb >= 1024:
        M = kb / 1024
        if M >= 1024:
            G = M / 1024
            return "%fG" % (G)
        else:
            return "%fM" % (M)
    else:
        return "%fkb" % (kb)

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

def readFile2Str(file_name):
    ret_strs = []
    with open(file_name) as f:
        for line in f:
            ret_strs.append(line)
    return "".join(ret_strs)

def getPathFlat(file_path):
    f = file_path.replace("/", "__")
    return f.replace(":", "__")

def removeLocalFile(file_path):
    try:
        os.remove(file_path)
    except:
        pass

def insertContent2File(content, file_path):
    tmp_path = file_path + ".temp"
    with open(tmp_path, "w") as tf:
        tf.write(content + "\n")
        with open(file_path) as f:
            for line in f:
                tf.write(line)
    removeLocalFile(file_path)
    os.rename(tmp_path, file_path)

def splitString(input_str, separator):
    arr1 = input_str.split(separator)
    ret_arr = []
    for s in arr1:
        ret_arr.append(s.strip())
    return ret_arr

def convertCSV2PipeDelimited(data_file_path):
    if os.path.getsize(data_file_path) == 0:
        return
    new_data_file_path = rreplace(data_file_path, ".csv", ".txt", 1)
    with open(data_file_path, 'rt') as fin, \
            open(new_data_file_path, 'wt') as fout:
        reader = csv.DictReader(fin)
        writer = csv.DictWriter(fout, reader.fieldnames, delimiter='|', lineterminator = '\n')
        try:
            writer.writeheader()
            writer.writerows(reader)
        except Exception as e:
            raise Exception("convertCSV2PipeDelimited Error: " + str(e))
        fin.close()
        fout.close()
    os.remove(data_file_path)

def rreplace(s, old, new, occurrence):
    li = s.rsplit(old, occurrence)
    return new.join(li)

def touch(file_path):
    with open(file_path, "a"):
        os.utime(file_path, None)

def getCurrentDatetime():
    #return datetime.datetime.now(tz=pytz.timezone("Asia/Shanghai"))
    return datetime.datetime.now()

def getExportPath(db_name, table_name, is_full, export_dir_path, file_suffix):
    cur_timestamp = str(int(time.time()))
    export_base_path = export_dir_path + "/" + db_name + "--" + table_name
    if is_full:
        # export_file_path = export_base_path + "--full--data.parquet"
        export_data_path = export_base_path + "--" + cur_timestamp + "--full"
    else:
        # export_file_path = export_base_path + "--incremental--data.parquet"
        export_data_path = export_base_path + "--" + cur_timestamp + "--incremental"
    export_data_path += "." + file_suffix
    export_schema_path = export_base_path + "--" + cur_timestamp + "--schema.sql"
    return export_data_path, export_schema_path

def getFileFromTimestamp(files, timestamp):
    for f in files:
        if timestamp in f:
            return f

def splitDBAndTable(table_with_db):
    li = table_with_db.split(".")
    return li[0], li[1]

def convertParam2List(params):
    ret_list = []
    kvs = params.split(",")
    for kv in kvs:
        ret_list.append(kv)
    return ret_list

class HDFSUtil(object):
    def __init__(self, hdfs_bin=None):
        self.logger = Logger(self.__class__.__name__).get()
        if hdfs_bin == None:
            if not config.hadoop_home:
                raise RuntimeError("hadoop_home must be specified in config")
            self.hdfs_bin = config.hadoop_home + "/bin/hdfs"

    def copyMRResults2Local(self, src_path, dest_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-getmerge", src_path, dest_path)
        cmd_exec.execute()

    def upload2HDFS(self, src_path, dest_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-put", src_path, dest_path)
        cmd_exec.execute()

    def extractFilesFromDir(self, dir_path, *keywords):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-ls", dir_path)
        output = cmd_exec.execute_output()
        outputs = output.split("\n")
        files = []
        for line in outputs:
            line_arr = line.split()
            if len(line_arr) < 5:
                continue
            cur_file_name = line_arr[-1]
            for k in keywords:
                if k in cur_file_name:
                    files.append(cur_file_name)
                    break
        return files

    def getFilesBySuffix(self, files, suffix):
        ret_files = []
        slen = len(suffix)
        for fname in files:
            if suffix == fname[-slen:]:
                ret_files.append(fname)
        return ret_files

    def getExportProperties(self, data_file):
        file_name = os.path.basename(data_file)
        name_splits = file_name.split("--")
        db_name = name_splits[0]
        tb_name = name_splits[1]
        timestamp = name_splits[2]
        is_full = 1 if name_splits[3] == "full" else 1
        return db_name, tb_name, timestamp, is_full

    def downloadFileFromHDFS(self, local_path, remote_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-get", local_path, remote_path)
        cmd_exec.execute()

    def deleteFileFromHDFS(self, file_path):
        cmd_exec = CommandExecutor(self.hdfs_bin, "dfs", "-rm", "-r", file_path)
        cmd_exec.execute()

from impala.dbapi import connect

def get_clean_schema(db_name, table_name):
    conn = connect(host='hadoop01', port=10001, auth_mechanism='PLAIN', user='hadoop', password='hadoop')
    cur = conn.cursor()
    cur.execute('show columns in '+ db_name +'.' + table_name)
    data = cur.fetchall()
    clean_str = []
    for i in data:
        clo = str(i).replace('(','').replace(')','').replace(',','').replace('\'','')
	clean_str.append('case when ' + clo + ' is null then "" else ' + clo  + ' end ' + clo)
    return ','.join(clean_str)

class HiveUtil(object):
    def __init__(self, hive_bin=None):
        self.logger = Logger(self.__class__.__name__).get()
        if hive_bin == None:
            if not config.hive_home:
                raise RuntimeError("hive_home must be specified in config")
            self.hive_bin = config.hive_home + "/bin/hive"

    def getCreateStatement(self, db_name, table_name):
        query_str = "SHOW CREATE TABLE " + db_name + "." + table_name
        cmd_exec = CommandExecutor(self.hive_bin, "-e", query_str)
        output = cmd_exec.execute_output()
        beg_index = output.index("CREATE TABLE")
        for i in range(beg_index, len(output)-1):
            if output[i] == ")" and output[i+1] == "\n":
                end_index = i+1
                break
        return output[beg_index:end_index]

    def exportTable(self, db_name, table_name, is_full, export_dir_uri, compress=False):
        self.logger.info("Begin to exportTable: db_name(%s), table_name(%s), is_full(%s), export_dir_uri(%s)" %
                         (db_name, table_name, is_full, export_dir_uri))
        # First export data
        export_data_path, export_schema_path = getExportPath(db_name, table_name, is_full, export_dir_uri, "csv")
        if compress:
            export_statement = "set hive.exec.compress.output=true;"
        else:
            export_statement = "set hive.exec.compress.output=false;"
        export_statement += "INSERT OVERWRITE DIRECTORY '" + export_data_path +  """' ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE """

	clean_schema = get_clean_schema(db_name, table_name)

	print get_clean_schema

        export_statement += "select " + clean_schema  + "  from " + db_name + "." + table_name

	print export_statement	

        cmd_exec = CommandExecutor(self.hive_bin, "-e", export_statement)
        cmd_exec.execute()

        # Second export schema
        schema_content = self.getCreateStatement(db_name, table_name)
        tmp_schema_file = "/tmp/" + db_name + "__" + table_name + "__schema.sql"
        with open(tmp_schema_file, "w") as sf:
            insertContent2File(schema_content, tmp_schema_file)
        hdfsUtil = HDFSUtil()
        hdfsUtil.upload2HDFS(tmp_schema_file, export_schema_path)

    def dropTable(self, table_name):
        drop_statement = "DROP TABLE " + table_name
        cmd_exec = CommandExecutor(self.hive_bin, "-e", drop_statement)
        cmd_exec.execute()

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
        ret_code = 0
        try:
            self.logger.debug("Try to execute command: (%s)" % cmd_with_args)
            ret_output = subprocess.check_output(cmd_with_args, env=local_env)
        except subprocess.CalledProcessError as e:
            ret_code, ret_output = e.returncode, e.message
            raise
        if ret_code != 0:
            raise Exception("exec cmd: %s Exception(%s)" % (cmd_with_args, ret_output))

    def execute_output(self):
        cmd_with_args = [self.bin_file]
        local_env = os.environ.copy()
        local_env["SPARK_HOME"] = config.spark_home
        for arg in self.args:
            cmd_with_args.append(arg)
        try:
            self.logger.debug("Try to execute_output command: (%s)" % cmd_with_args)
            output = subprocess.check_output(cmd_with_args, env=local_env)
        except:
            self.logger.info("Error: ", self.__str__())
            raise
        return output

    def __str__(self):
        return "CommandExecutor: [" + self.bin_file + " " + str(self.args) + "]"

def paddingTimeNum(num):
    if num < 10:
        return "0" + str(num)
    return str(num)

CRON_RANGE = {
    0: (0, 59),     # minutes
    1: (0, 23),     # hours
    2: (1, 31),     # days_in_month
    3: (1, 12),     # months
    4: (1, 7),      # days_in_week
    5: (1900, 3000) # years
}

WEEKDAY_INDEX = {
    "mon": "1",
    "tue": "2",
    "wed": "3",
    "thu": "4",
    "fri": "5",
    "sat": "6",
    "sun": "7"
}



MONTH_INDEX = {
    "jan": "1",
    "feb": "2",
    "mar": "3",
    "apr": "4",
    "may": "5",
    "jun": "6",
    "jul": "7",
    "aug": "8",
    "sep": "9",
    "oct": "10",
    "nov": "11",
    "dec": "12"
}

class CronUtil(object):
    def __init__(self, minutes=None, hours=None, days_in_month=None, months=None, days_in_week=None, years=None):
        self.minutes = minutes
        self.hours = hours
        self.days_in_month = days_in_month
        self.months = months
        self.days_in_week = days_in_week
        self.years = years

    def parseLinuxCron(self, cron_str):
        cstr_new = self._preProcess(cron_str)
        params = cstr_new.split()
        self.minutes = self._parseField(params[0], 0)
        self.hours = self._parseField(params[1], 1)
        self.days_in_month = self._parseField(params[2], 2)
        self.months = self._parseField(params[3], 3)
        self.days_in_week = self._parseField(params[4], 4)
        if len(params) > 5:
            self.years = self._parseField(params[5], 5)
        else:
            self.years = set([i for i in range(2000, 2100)])

    def _preProcess(self, cron_str):
        cron_str = cron_str.lower()
        for k in MONTH_INDEX:
            cron_str = cron_str.replace(k, MONTH_INDEX[k])
        for k in WEEKDAY_INDEX:
            cron_str = cron_str.replace(k, WEEKDAY_INDEX[k])
        return cron_str

    def _parseField(self, field_str, index):
        field_values = []
        f1 = splitString(field_str, "/")
        range_field = f1[0]
        stride = 1
        if range_field == "*":
            beg, end = CRON_RANGE[index]
        elif "-" in range_field:
            rr = range_field.split("-")
            beg, end = int(rr[0]), int(rr[1])
        elif len(f1) < 2:
            vals = splitString(range_field, ",")
            for v in vals:
                field_values.append(int(v))
            return field_values
        else:
            raise ValueError("_parseField field_str(%s) Error" % field_str)
        # update the default stride 1
        if len(f1) > 1:
            stride = int(f1[1])
        for i in range(beg, end+1, stride):
            field_values.append(i)
        return set(field_values)

    def __str__(self):
        return "{" + "minutes: " + str(self.minutes) + \
            ", hours: " + str(self.hours) + ", days_in_month: " + str(self.days_in_month) + \
            ", months: " + str(self.months) + ", days_in_week: " + str(self.days_in_week) + \
            "}"




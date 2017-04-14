# -*- coding: utf-8 -*-：
# 根据表创建文件夹

import common.dao.import_tables as import_tables
import common.db.db_config as db
import os
import common.util.util as util

prefix = None

env = util.get_param("env")

if env == "pro":
    prefix = "/opt/spacewalk/data/orgin_file/"
else:
    prefix = "/Users/lzf/data/"


# 根据我们的库名和表名来创建对应的目录
def create_dir(db_name, table_name):
    path = prefix + db_name + "/" + table_name

    if os.path.exists(path) is False:
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "full")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "incremental")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "processed")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "processing")


# 查询出的是我们自己库和表的名称
def get_table():
    ImportTable = import_tables.ImportTable
    importtable = db.session.query(ImportTable.dbname, ImportTable.table_name).filter(ImportTable.flag == 0).filter(ImportTable.active == 0).distinct().all()
    return importtable


# 在每次import这个表的时候去查询和创建目录
def load():
    for i in get_table():
        dbname = i[0]
        table_name = i[1]
        create_dir(dbname, table_name)

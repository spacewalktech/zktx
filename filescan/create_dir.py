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


def create_dir(db_name, table_name):

    path = prefix + db_name + "/" + table_name

    if os.path.exists(path) is False:
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "full")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "incremental")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "processed")
        os.makedirs(prefix + db_name + "/" + table_name + "/" + "processing")


def get_table():
    ImportTable = import_tables.ImportTable
    importtable = db.session.query(ImportTable.src_db, ImportTable.src_table).distinct().all()
    return importtable


def load():
    for i in get_table():
        src_db = i[0]
        src_table = i[1]
        create_dir(src_db, src_table)

load()

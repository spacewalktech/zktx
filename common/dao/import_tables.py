# -*- coding: utf-8 -*-：

from sqlalchemy import Column, Integer, TEXT, String, DateTime
import common.db.db_config as db


# 定义db_import_tables对象:
class ImportTable(db.Base):
    # 表名：
    __tablename__ = "tb_import_tables"

    # 表结构
    id = Column(Integer, primary_key=True, nullable=True)
    src_db = Column(String(50))
    src_table = Column(String(50))
    src_keys = Column(String(500))
    src_db_type = Column(String(10))
    src_db_version = Column(String(50))
    schema_source = Column(Integer)
    src_db_connection = Column(String(100))
    src_db_user = Column(String(50))
    src_db_password = Column(String(50))
    dbname = Column(String(50))
    table_name = Column(String(50))
    table_type = Column(Integer)
    active = Column(Integer)
    export_to_sql_warehouse = Column(Integer)
    export_to_es_index_warehouse = Column(Integer)
    es_index_schema = Column(TEXT)
    creator_id = Column(Integer)
    flag = Column(Integer)
    process_info = Column(TEXT)
    create_time = Column(DateTime)
    update_time = Column(DateTime)

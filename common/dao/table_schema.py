#!/usr/local/bin/python2.7
# -*- coding: utf-8 -*-:

from sqlalchemy import Column, Integer, TEXT, DateTime, ForeignKey
import common.db.db_config as db


# 定义tb_tables_schema对象:
class TableSchema(db.Base):
    # 表名：
    __tablename__ = "tb_table_schema"
    __table_args__ = {'extend_existing': True}

    # 表结构
    id = Column(Integer, primary_key=True, nullable=True)
    table_id = Column(Integer, ForeignKey("tb_import_tables.id"))
    version = Column(Integer)
    schema = Column(TEXT)
    spark_schema = Column(TEXT)
    create_time = Column(DateTime)
    update_time = Column(DateTime)

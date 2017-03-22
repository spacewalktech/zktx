#!/usr/local/bin/python2.7
# -*- coding: utf-8 -*-：
# 数据库连接

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

import common.config.config as config

# 创建对象的基类:
Base = declarative_base()

# 初始化数据库连接:
url = 'mysql+{0}://{1}:{2}@{3}:{4}/{5}?charset=utf8'.format(
    config.mysql_db.get("driver"),
    config.mysql_db.get("user"),
    config.mysql_db.get("password"),
    config.mysql_db.get("host"),
    config.mysql_db.get("port"),
    config.mysql_db.get("db"),

)
engine = create_engine(url, echo=False)

# 创建DBSession类型:
DBSession = sessionmaker(bind=engine)
session = DBSession()

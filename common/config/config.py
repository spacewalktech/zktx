# -*- coding: utf-8 -*-：
# 配置信息

mysql_db = {
    "host": '192.168.56.101',
    "port": 3306,
    "user": "test",
    "password": "test",
    "db": "test2",
    "driver": "pymysql"
}

# 测试
dev_path = {
    # 存储源文件的路径前缀
    "prefix": "/Users/lzf/data/",
    # 存放parquet文件的地址
    "parquet_path": "/Users/lzf/data/zktx_data/",
    # master 的地址
    "spark_master_ip": "spark://127.0.0.1:7077",
    # warehouse的位置
    "spark_warehouse": "/Users/lzf/data/warehouse"
}

# 正式
pro_path = {
    # 存储源文件的路径前缀
    "prefix": "/opt/spacewalk/data/orgin_file",
    # 存放parquet文件的地址
    "parquet_path": "hdfs://spacewalk/spacewalk/hdfs/parquet_file",
    # master 的地址
    "spark_master_ip": "spark://hadoop01:7077",
    # warehouse的位置
    "spark_warehouse": "hdfs://spacewalk/spacewalk/hdfs/ware_house"
}
LOGGING_DIR = "../logs"
LOGGING_STDOUT = True
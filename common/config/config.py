# -*- coding: utf-8 -*-：
# 配置信息

mysql_db = {
    "host": '192.168.1.50',
    "port": 3306,
    "user": "root",
    "password": "passwd",
    "db": "zktx_data_platform",
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
    "prefix": "/data/spacewalk/origin_file/",
    # 存放parquet文件的地址
    "parquet_path": "hdfs://hadoop01:9000/spacewalk/hdfs/parquet_file/",
    # master 的地址
    "spark_master_ip": "yarn"
}
logging_dir = "../logs"
logging_stdout = True
stage_scan_interval = 600
task_queue_scan_interval = 600

# es服务列表
es_hosts = ["192.168.56.101:9200"]

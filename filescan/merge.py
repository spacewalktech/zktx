# -*- coding: utf-8 -*-：
# 合并上传完成的文件

import os
import time
from pyspark.sql import SparkSession
from pyspark.sql.types import *

# master 的地址
spark_master_ip = "spark://127.0.0.1:7077"

# warehouse的位置
spark_warehouse = "/Users/lzf/data/warehouse"

# parquet文件的隐藏列
hidden_colum = "resvd_stage_id,resvd_flag,resvd_create_time,resvd_latest_update_time"

# 隐藏列数组
hidden_colum_array = ["resvd_stage_id", "resvd_flag", "resvd_create_time", "resvd_latest_update_time"]

# 存放parquet文件的地址
parquet_path = "/Users/lzf/data/zktx_data/"


# 获取当前的时间
def get_time_format():
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))


# 更新parquet文件
def merge(data_path, data_type, src_db, src_table, schema_str, stage_id):
    # 用来记录更新的数据信息
    count_info = {}

    # 启动spark任务
    spark = SparkSession.builder.appName(" python update table [ " + src_db + "_" + src_table + " ]").config("spark.master", spark_master_ip).config("spark.sql.warehouse.dir", spark_warehouse).getOrCreate()

    # 表的schema
    schema_string = schema_str + "," + hidden_colum

    # 构建DF的schema
    fields = [StructField(field_name, StringType(), False) for field_name in schema_str.split(",")]
    schema_df = StructType(fields)

    # 全量更新
    if data_type == "full":

        # 读取源文件
        df = spark.read.load(data_path + "/data_full.csv", format="csv", encoding="gbk", schema=schema_df)
        count = df.count()

        # 创建4个隐藏列
        hidden_cloum = [(stage_id, 0, get_time_format(), get_time_format())]
        hidden_df = spark.createDataFrame(hidden_cloum, hidden_colum_array)

        # 创建新的datafeame
        new_data = df.crossJoin(hidden_df)

        # 需要对列进行排序，不然会按照schema的字典顺序排列
        new_data.createOrReplaceTempView(src_db + "_" + src_table + "_temp")
        new_schema_org_df = spark.sql("select " + schema_string + " from " + src_db + "_" + src_table + "_temp")

        # 写成parquet文件
        new_schema_org_df.write.format("parquet").mode("overwrite").save(parquet_path + src_db + "/" + src_table + ".parquet")

        # 返回统计信息
        count_info["inserted_num"] = count
        count_info["record_num"] = count

        return count_info
    # 增量更新
    else:

        # 加载原有parquet文件
        org_parquet_df = spark.read.load(parquet_path + src_db + "/" + src_table + ".parquet")

        # 创建表
        # org_parquet_df.createOrReplaceTempView(src_db + "_" + src_table)

        # 修改和添加的 dataframe
        update_df = None

        # 用来记录变化的数据的主键，如果是联合的主键需要转化
        id_arry = []

        # 更新的数量
        update_count = 0

        # 添加的数量
        insert_count = 0

        # 构建额外的4个隐藏字段dataframe : resvd_stage_id,resvd_flag,resvd_create_time,resvd_latest_update_time
        hidden_cloum = [(stage_id, 0, get_time_format(), get_time_format())]
        hidden_df = spark.createDataFrame(hidden_cloum, hidden_colum_array)

        fields = [StructField(field_name, StringType(), False) for field_name in schema_str.split(",")]
        schema_df = StructType(fields)

        # 有 data_insert_updated.csv 文件
        if os.path.exists(data_path + "/data_insert_updated.csv"):

            # 加载文件
            update_df = spark.read.load(data_path + "/data_insert_updated.csv", format="csv", encoding="gbk", schema=schema_df)

            # 总的数量
            update_insert_count = update_df.count()

            # 构造逗号分割的主键串
            ids = update_df.select("id").collect()
            for delete_id in ids:
                id_arry.append(delete_id.id)
            update_ids = ",".join(id_arry)

            # 查询在源数据里面的数据个数
            update_count = org_parquet_df.filter("id in (" + update_ids + ")").count()

            # 减去得到添加的数据个数
            insert_count = update_insert_count - update_count

            # 构建带有隐藏列的df
            update_df = update_df.crossJoin(hidden_df)

        # 删除的 dataframe
        delete_df = None

        # 删除的数据的个数
        delete_count = 0

        # 构建额外的4个隐藏字段
        hidden_cloum = [(stage_id, 1, get_time_format(), get_time_format())]
        hidden_df = spark.createDataFrame(hidden_cloum, hidden_colum_array)

        # 有 data_deleted.csv 文件
        if os.path.exists(data_path + "/data_deleted.csv"):

            # 加载文件
            delete_df = spark.read.load(data_path + "/data_deleted.csv", format="csv", encoding="gbk", schema=schema_df)

            # 删除的数据数量
            delete_count = delete_df.count()

            # 将id主键放入变化数据数组
            ids = delete_df.select("id").collect()
            for delete_id in ids:
                id_arry.append(delete_id.id)

            # 构建带有隐藏列的df
            delete_df = delete_df.crossJoin(hidden_df)

        # 获取没有变化的源dataframe
        clean_org_df = org_parquet_df.filter(" id not in (" + ",".join(id_arry) + ")")

        # 将修改的和删除的dataframe append到源数据dataframe上去
        end_df = clean_org_df.union(update_df).union(delete_df)

        # 写入到指定的文件位置
        end_df.createOrReplaceTempView(src_db + "_" + src_table + "_temp")
        new_schema_org_df = spark.sql("select " + schema_string + " from " + src_db + "_" + src_table + "_temp")
        new_schema_org_df.write.format("parquet").mode("overwrite").save(parquet_path + src_db + "/" + src_table + "_temp.parquet")

        # 返回统计信息
        count_info["inserted_num"] = insert_count
        count_info["updated_num"] = update_count
        count_info["deleted_num"] = delete_count
        count_info["record_num"] = insert_count + update_count + delete_count

        return count_info

package com.zktx.platform.entity;

import java.util.List;

/**
 * 
 * {"db_type":"mysql", "db_version":"5.7", "db_name":"test_db",
 * "table_name":"test_table", "schema":[ {"name":"id","type":"int","primary":1},
 * {"name":"name","type":"varchar(10)","unique":1}, {"name":"sex","type":"int"},
 * {"name":"age","type":"int"}, {"name":"info","type":"varchar(500)"} ] }
 * 
 * @param oldSchema
 * @return
 */
public class Schema {
	
	// 数据库类型
	private String db_type;
	// 数据库版本
	private String db_version;
	// 数据库名称
	private String db_name;
	// 表名称
	private String table_name;
	// schema 信息
	private List<ColumInfo> schema;

	public String getDb_type() {
		return db_type;
	}

	public void setDb_type(String db_type) {
		this.db_type = db_type;
	}

	public String getDb_version() {
		return db_version;
	}

	public void setDb_version(String db_version) {
		this.db_version = db_version;
	}

	public String getDb_name() {
		return db_name;
	}

	public void setDb_name(String db_name) {
		this.db_name = db_name;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public List<ColumInfo> getSchema() {
		return schema;
	}

	public void setSchema(List<ColumInfo> schema) {
		this.schema = schema;
	}
}

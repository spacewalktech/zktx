package com.zktx.platform.entity.tb;

import java.io.Serializable;
import java.util.Date;

public class TableSchemaPo  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3389719811361726087L;

	private Integer id;

	private Integer version;

	private String src_db;

	private String src_table;
	
	private String dbname;

	private String table_name;

	private Date create_time;
	
	private String schema;
	    
	private String spark_schema;
	
	private Integer table_type;
	    
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getSrc_db() {
		return src_db;
	}

	public void setSrc_db(String src_db) {
		this.src_db = src_db;
	}

	public String getSrc_table() {
		return src_table;
	}

	public void setSrc_table(String src_table) {
		this.src_table = src_table;
	}

	public String getDbname() {
		return dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

	public String getSpark_schema() {
		return spark_schema;
	}

	public void setSpark_schema(String spark_schema) {
		this.spark_schema = spark_schema;
	}

	public Integer getTable_type() {
		return table_type;
	}

	public void setTable_type(Integer table_type) {
		this.table_type = table_type;
	}
	
	
}

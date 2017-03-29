package com.zktx.platform.entity.tb;

import java.util.Date;

public class TableSchema {
    private Integer id;

    private Integer table_id;

    private Integer version;

    private Date create_time;

    private Date update_time;

    private String schema;
    
    private String spark_schema;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTable_id() {
        return table_id;
    }

    public void setTable_id(Integer table_id) {
        this.table_id = table_id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
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
    
    
}
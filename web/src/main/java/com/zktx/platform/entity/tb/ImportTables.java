package com.zktx.platform.entity.tb;

import java.util.Date;

public class ImportTables {
	
    private Integer id;

    private String src_db;

    private String src_table;

    private String src_keys;

    private String src_db_type;

    private String src_db_version;

    private Boolean schema_source;

    private String src_db_connection;

    private String src_db_user;

    private String src_db_password;

    private String dbname;

    private String table_name;

    private Boolean table_type;

    private Boolean active;

    private Boolean export_to_sql_warehouse;

    private Boolean export_to_es_index_warehouse;

    private Integer creator_id;

    private Boolean flag=false;

    private Date create_time;

    private Date update_time;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getSrc_keys() {
        return src_keys;
    }

    public void setSrc_keys(String src_keys) {
        this.src_keys = src_keys;
    }

    public String getSrc_db_type() {
        return src_db_type;
    }

    public void setSrc_db_type(String src_db_type) {
        this.src_db_type = src_db_type;
    }

    public String getSrc_db_version() {
        return src_db_version;
    }

    public void setSrc_db_version(String src_db_version) {
        this.src_db_version = src_db_version;
    }

    public Boolean getSchema_source() {
        return schema_source;
    }

    public void setSchema_source(Boolean schema_source) {
        this.schema_source = schema_source;
    }

    public String getSrc_db_connection() {
        return src_db_connection;
    }

    public void setSrc_db_connection(String src_db_connection) {
        this.src_db_connection = src_db_connection;
    }

    public String getSrc_db_user() {
        return src_db_user;
    }

    public void setSrc_db_user(String src_db_user) {
        this.src_db_user = src_db_user;
    }

    public String getSrc_db_password() {
        return src_db_password;
    }

    public void setSrc_db_password(String src_db_password) {
        this.src_db_password = src_db_password;
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

    public Boolean getTable_type() {
        return table_type;
    }

    public void setTable_type(Boolean table_type) {
        this.table_type = table_type;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Boolean getExport_to_sql_warehouse() {
        return export_to_sql_warehouse;
    }

    public void setExport_to_sql_warehouse(Boolean export_to_sql_warehouse) {
        this.export_to_sql_warehouse = export_to_sql_warehouse;
    }

    public Boolean getExport_to_es_index_warehouse() {
        return export_to_es_index_warehouse;
    }

    public void setExport_to_es_index_warehouse(Boolean export_to_es_index_warehouse) {
        this.export_to_es_index_warehouse = export_to_es_index_warehouse;
    }

    public Integer getCreator_id() {
        return creator_id;
    }

    public void setCreator_id(Integer creator_id) {
        this.creator_id = creator_id;
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
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
}
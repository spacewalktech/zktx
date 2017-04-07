package com.zktx.platform.entity.tb;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ImportTablesPo implements Serializable{
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String src_db;

    private String src_table;
    
    private String src_db_type;
    
    private String dbname;

    private String table_name;

    private Integer table_type;

	private Date create_time_from;
	
	private Date create_time_to;
	
	private Integer limit;
	
	private Integer offset;
	 
	
	public Date getCreate_time_from() {
		return create_time_from;
	}

	public void setCreate_time_from(String create_time_from) throws ParseException {
		this.create_time_from = (create_time_from!=null&&!"".equals(create_time_from.trim())?dateFormat.parse(create_time_from):null);
	}

	public Date getCreate_time_to() {
		return create_time_to;
	}

	public void setCreate_time_to(String create_time_to) throws ParseException {
		this.create_time_to =   (create_time_to!=null&&!"".equals(create_time_to.trim())?dateFormat.parse(create_time_to):null);
	}

	public String getSrc_db() {
		return src_db;
	}

	public void setSrc_db(String src_db) {
		this.src_db = (null!=src_db&&!"".equals(src_db.trim())?src_db:null);
	}

	public String getSrc_table() {
		return src_table;
	}

	public void setSrc_table(String src_table) {
		this.src_table = (null!=src_table&&!"".equals(src_table.trim())?src_table:null);
	}

	public String getSrc_db_type() {
		return src_db_type;
	}

	public void setSrc_db_type(String src_db_type) {
		this.src_db_type = (null!=src_db_type&&!"".equals(src_db_type.trim())?src_db_type:null);
	}

	public String getDbname() {
		return dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = (null!=dbname&&!"".equals(dbname.trim())?dbname:null);
	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = (null!=table_name&&!"".equals(table_name.trim())?table_name:null);
	}


	public Integer getTable_type() {
		return table_type;
	}

	public void setTable_type(Integer table_type) {
		this.table_type = table_type;
	}

	

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	
}

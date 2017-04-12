package com.zktx.platform.entity.tb;

import java.util.Date;

public class UploadBatRecord {

	private Integer id;
	
	private Integer user_id;
	
	private Date upload_time;
	
	private Integer fileNum;
	
	private Integer size;
	
	private Boolean upload_status;
	
	private Date comp_time;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Date getUpload_time() {
		return upload_time;
	}

	public void setUpload_time(Date upload_time) {
		this.upload_time = upload_time;
	}

	public Integer getFileNum() {
		return fileNum;
	}

	public void setFileNum(Integer fileNum) {
		this.fileNum = fileNum;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Boolean getUpload_status() {
		return upload_status;
	}

	public void setUpload_status(Boolean upload_status) {
		this.upload_status = upload_status;
	}

	public Date getComp_time() {
		return comp_time;
	}

	public void setComp_time(Date comp_time) {
		this.comp_time = comp_time;
	}
	
	
}

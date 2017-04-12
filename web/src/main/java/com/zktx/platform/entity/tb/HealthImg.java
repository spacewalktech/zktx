package com.zktx.platform.entity.tb;

import java.util.Date;

public class HealthImg {

	private Integer id;
	
	private String guid;
	
	private String uri;
	
	private String type;
	
	private Integer size;
	
	private Date upload_time;
	
	private String bus_sys;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public Date getUpload_time() {
		return upload_time;
	}

	public void setUpload_time(Date upload_time) {
		this.upload_time = upload_time;
	}

	public String getBus_sys() {
		return bus_sys;
	}

	public void setBus_sys(String bus_sys) {
		this.bus_sys = bus_sys;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}
	
	
}

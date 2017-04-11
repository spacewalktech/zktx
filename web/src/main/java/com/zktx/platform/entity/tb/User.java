package com.zktx.platform.entity.tb;

import java.util.Date;

public class User {
	private Integer id;

	private String name;

	private String pwd;

	private String emial;

	private String phone;

	private String salt;

	private Byte status;

	private String token;

	private Date token_invalid_time;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmial() {
		return emial;
	}

	public void setEmial(String emial) {
		this.emial = emial;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getToken_invalid_time() {
		return token_invalid_time;
	}

	public void setToken_invalid_time(Date token_invalid_time) {
		this.token_invalid_time = token_invalid_time;
	}

}
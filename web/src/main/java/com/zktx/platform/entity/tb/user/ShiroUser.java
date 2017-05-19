package com.zktx.platform.entity.tb.user;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.zktx.platform.entity.tb.User;

public class ShiroUser implements Serializable, Cloneable {

	private static final long serialVersionUID = -7032102857265115615L;

	private int id;

	private String name;

	private String ipAddress;

	private User user;

	private Map<String, Object> map = new HashMap<String, Object>();

	/* cons */

	public ShiroUser() {
		super();
	}

	public ShiroUser(int id) {
		super();
		this.id = id;
	}

	public ShiroUser(String name) {
		super();
		this.name = name;
	}

	public ShiroUser(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public ShiroUser(int id, String name, User user, Map<String, Object> map) {
		super();
		this.id = id;
		this.name = name;
		this.user = user;
		this.map = map;
	}

	/* set and get */

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

}

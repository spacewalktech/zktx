package com.zktx.platform.log;

/**
 * 值越大，等级越高。
 * 
 */
public enum LogLevel {

	TRACE("TRACE"),

	DEBUG("DEBUG"),

	INFO("INFO"),

	WARN("WARN"),

	ERROR("ERROR");

	private String value;

	LogLevel(String value) {
		this.value = value;
	}

	public String value() {
		return this.value;
	}
}

package com.zktx.platform.log.impl;

import java.util.HashMap;
import java.util.Map;

import com.zktx.platform.log.LogAPI;
import com.zktx.platform.log.LogLevel;

public class LogAdapter implements LogAPI {

	/**
	 * @param message
	 * @param logLevel
	 */
	@Override
	public void log(String message, LogLevel logLevel) {
		log(message, null, logLevel);
	}

	/**
	 * @param message
	 * @param objects
	 * @param logLevel
	 */
	@Override
	public void log(String message, Object[] objects, LogLevel logLevel) {

	}

	/**
	 * @return
	 */
	@Override
	public LogLevel getRootLogLevel() {
		return LogLevel.ERROR;
	}

	/**
	 * @returnÏß
	 */
	@Override
	public Map<String, LogLevel> getCustomLogLevel() {
		return new HashMap<String, LogLevel>();
	}
}

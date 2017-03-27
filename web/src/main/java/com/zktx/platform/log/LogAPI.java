package com.zktx.platform.log;

import java.util.Map;

public interface LogAPI {

	void log(String message, LogLevel logLevel);

	void log(String message, Object[] objects, LogLevel logLevel);

	/**
	 * 
	 * 得到全局日志等级
	 * 
	 * @return
	 */
	LogLevel getRootLogLevel();

	/**
	 * 
	 * 得到自定义包的日志等级
	 * 
	 * @return
	 */
	Map<String, LogLevel> getCustomLogLevel();
}

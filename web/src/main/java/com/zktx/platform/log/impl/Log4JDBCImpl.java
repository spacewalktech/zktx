package com.zktx.platform.log.impl;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.zktx.platform.log.LogLevel;

/**
 * 全局日志等级<包日志等级<类和方法日志等级
 */
public class Log4JDBCImpl extends LogAdapter {

	private LogLevel rootLogLevel = LogLevel.ERROR;

	// @Autowired
	// private LogInfoBusiness logInfoService;

	private Map<String, LogLevel> customLogLevel = new HashMap<String, LogLevel>();

	/**
	 * 
	 * @param message
	 * @param objects
	 * @param logLevel
	 */
	@Override
	public void log(String message, Object[] objects, LogLevel logLevel) {

		// 把注解的 {0}{1} 这样的参数通过控制层的util 设置进来，替换
		MessageFormat mFormat = new MessageFormat(message);
		String result = mFormat.format(objects);

		if (!StringUtils.isNotBlank(result)) {
			return;
		}

		// ShiroUser shiroUser = SecurityUtils.getShiroUser();

		// result = shiroUser.toString() + ":" + result;

		// LogInfo logInfo = new LogInfo();
		// logInfo.setCreateTime(new Date());
		//
		// logInfo.setUsername(shiroUser.getName());
		// logInfo.setMessage(result);
		// logInfo.setIpAddress(shiroUser.getIpAddress()); 
		// logInfo.setLogLevel(logLevel);

		// logInfoService.saveOrUpdate(logInfo);
	}

	public void setRootLogLevel(LogLevel rootLogLevel) {
		this.rootLogLevel = rootLogLevel;
	}

	/**
	 * 
	 * @return
	 * @see com.ketayao.ketacustom.log.LogTemplate#getRootLogLevel()
	 */
	@Override
	public LogLevel getRootLogLevel() {
		return rootLogLevel;
	}

	public void setCustomLogLevel(Map<String, LogLevel> customLogLevel) {
		this.customLogLevel = customLogLevel;
	}

	@Override
	public Map<String, LogLevel> getCustomLogLevel() {
		return customLogLevel;
	}

}

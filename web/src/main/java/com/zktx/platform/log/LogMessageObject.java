package com.zktx.platform.log;

public class LogMessageObject {

	// 是否写入log，默认为true
	private boolean isWritten = true;

	// message对象参数
	private Object[] objects;

	/**
	 * 构造函数
	 */
	public LogMessageObject() {
		
	}

	/**
	 * 构造函数
	 * 
	 * @param isWritten
	 * @param objects
	 */
	public LogMessageObject(boolean isWritten) {
		super();
		this.isWritten = isWritten;
	}

	/**
	 * 构造函数
	 * 
	 * @param isWritten
	 * @param objects
	 */
	public LogMessageObject(boolean isWritten, Object[] objects) {
		super();
		this.isWritten = isWritten;
		this.objects = objects;
	}

	public static LogMessageObject newWrite() {
		return new LogMessageObject(true);
	}

	public static LogMessageObject newIgnore() {
		return new LogMessageObject(false);
	}

	/**
	 * 返回 isWritten 的值
	 * 
	 * @return isWritten
	 */
	public boolean isWritten() {
		return isWritten;
	}

	/**
	 * 设置 isWritten 的值
	 * 
	 * @param isWritten
	 */
	public LogMessageObject setWritten(boolean isWritten) {
		this.isWritten = isWritten;
		return this;
	}

	/**
	 * 返回 objects 的值
	 * 
	 * @return objects
	 */
	public Object[] getObjects() {
		return objects;
	}

	/**
	 * 设置 objects 的值
	 * 
	 * @param objects
	 */
	public LogMessageObject setObjects(Object[] objects) {
		this.objects = objects;
		return this;
	}

}

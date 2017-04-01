package com.zktx.platform.log;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Documented
@Target({ METHOD })
@Retention(RUNTIME)
public @interface Log {
	/**
	 * 
	 * 日志信息
	 * 
	 * @return
	 */
	String message();

	/**
	 * 
	 * 日志记录等级
	 * 
	 * @return
	 */
	LogLevel level() default LogLevel.TRACE;

	/**
	 * 
	 * 是否覆盖包日志等级 1.为false不会参考level属性。 2.为true会参考level属性。
	 * 
	 * @return
	 */
	boolean override() default false;
}

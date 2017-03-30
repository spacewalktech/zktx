package com.zktx.platform.util.spring;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * 可以获取 applicationContext
 * 
 * @author LZF
 *
 */
public class BeanFactory  implements ApplicationContextAware{
	
	public static  ApplicationContext applicationContext;
	 
	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {
		applicationContext=arg0;
		
	} 
	
	public static Object getBean(String beanname){
		Object object=null;
		object=applicationContext.getBean(beanname);
		return object;
	}
	
}

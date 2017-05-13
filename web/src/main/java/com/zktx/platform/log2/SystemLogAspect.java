package com.zktx.platform.log2;

import java.lang.reflect.Method;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zktx.platform.entity.tb.logInfo;
import com.zktx.platform.service.log.LogService;

/**
 * * 首先我们为什么需要做日志管理，在现实的上线中我们经常会遇到系统出现异常或者问题。 这个时候就马上打开CRT或者SSH连上服务器拿日子来分析。
 * 受网络的各种限制。于是我们就想为什么不能直接在管理后台查看报错的信息呢。于是日志管理就出现了。
 * 其次个人觉得做日志管理最好的是Aop，有的人也喜欢用拦截器。都可以，在此我重点介绍我的实现方式。 Aop有的人说拦截不到Controller。
 * 有的人说想拦AnnotationMethodHandlerAdapter截到Controller必须得拦截org
 * .springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter。
 * 首先Aop可以拦截到Controller的
 * ，这个是毋容置疑的其次须拦截AnnotationMethodHandlerAdapter也不是必须的。最起码我没有验证成功过这个
 * 。我的Spring版本是4.0.3。
 * Aop之所以有的人说拦截不到Controller是因为Controller被jdk代理了。我们只要把它交给cglib代理就可以了
 * 
 * <!-- 启动对@AspectJ注解的支持 --> <aop:aspectj-autoproxy />
 * <!--通知spring使用cglib而不是jdk的来生成代理方法 AOP可以拦截到Controller-->
 * <aop:aspectj-autoproxy proxy-target-class="true"></aop:aspectj-autoproxy>
 * <!-- 节点中proxy-target-class="true"不为true时。 *
 * 当登录的时候会报这个异常java.lang.NoSuchMethodException: $Proxy54.login()， -->
 * <aop:config proxy-target-class="true"></aop:config>
 * 
 * 创建一个切点类
 * 
 * @author Administrator
 *
 */
@Aspect
@Component
public class SystemLogAspect {

	// 本地异常日志记录对象
	private static final Logger log = LoggerFactory.getLogger(SystemLogAspect.class);

	@Autowired
	LogService logService;

	@Autowired
	private HttpServletRequest request;

	// Controller层切点
	@Pointcut("@annotation(com.zktx.platform.log2.SystemControllerLog)")
	public void controllerAspect() {
	}

	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint) {

		new Thread(new Runnable() {

			@Override
			public void run() {
				try {
					log.info("进入日志系统————————————");
					logInfo info = new logInfo();
					String description = getControllerMethodDescription(joinPoint);
					// 1.通过RequestContextHolder获取request：
					/*
					 * HttpServletRequest request = ((ServletRequestAttributes)
					 * RequestContextHolder
					 * .getRequestAttributes()).getRequest(); if (null !=
					 * request) { log.info("request:" +
					 * request.getRemoteAddr()); } else {
					 * log.info("request,null"); }
					 */

					// 2.通过shiro的身份认证获取信息：
					Subject subject = SecurityUtils.getSubject();
					String username = subject.getPrincipal().toString();

					Session session = subject.getSession();
					info.setUser_name(username);
					info.setMessage(description);
					info.setIp_address(session.getHost());
					info.setCreate_time(new Date());
					logService.insertLogInfo(info);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}).start();
	}

	// 通过反射获取参入的参数
	public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemControllerLog.class).description();
					break;
				}
			}
		}
		return description;
	}
}

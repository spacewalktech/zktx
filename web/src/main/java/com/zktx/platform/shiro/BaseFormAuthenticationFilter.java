package com.zktx.platform.shiro;

import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zktx.platform.entity.tb.user.ShiroUser;

public class BaseFormAuthenticationFilter extends FormAuthenticationFilter {

	public final static String X_R = "X-Requested-With";
	public final static String X_R_VALUE = "XMLHttpRequest";

	private static final Logger log = LoggerFactory.getLogger(BaseFormAuthenticationFilter.class);

	/**
	 * 判断是否是ajax操作 isAjax:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author wlzj
	 * @param req
	 * @return
	 * @since JDK 1.7
	 */
	private boolean isAjax(HttpServletRequest req) {
		if (!X_R_VALUE.equalsIgnoreCase(req.getHeader(X_R))) {// 不是ajax请求
			return false;
		} else {
			return true;
		}
	}

	/* 覆盖默认实现，打印日志便于调试，查看具体登录是什么错误 */
	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {

		if (log.isDebugEnabled()) {
			Class<?> clazz = e.getClass();
			if (clazz.equals(AuthenticationException.class)) {
				log.debug(e.getLocalizedMessage());
			}
		}

		return super.onLoginFailure(token, e, request, response);

	}

	/* 覆盖默认实现，用sendRedirect直接跳出框架，以免造成js框架重复加载js出错 */
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		ShiroUser shiroUser = (ShiroUser) subject.getPrincipal();
		// 加入ipAddress
		shiroUser.setIpAddress(SecurityUtils.getRemoteAddr(httpServletRequest));

		if (!isAjax(httpServletRequest)) {// 不是ajax请求
			httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + this.getSuccessUrl());
		} else {
			httpServletResponse.setCharacterEncoding("UTF-8");
			PrintWriter out = httpServletResponse.getWriter();
			out.println("{success:true,message:'登入成功'}");
			out.flush();
			out.close();
		}
		return false;
	}

	/* 覆盖isAccessAllowed，改变shiro的验证逻辑,避免不能多次登录的错误 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
		try {
			// 先判断是否是登录操作
			if (isLoginSubmission(request, response)) {
				if (log.isTraceEnabled()) {
					log.trace("Login submission detected.  Attempting to execute login.");
				}
				return false;
			}

		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return super.isAccessAllowed(request, response, mappedValue);
	}

}

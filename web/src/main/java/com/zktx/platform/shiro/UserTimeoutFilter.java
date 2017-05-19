package com.zktx.platform.shiro;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.web.filter.authc.UserFilter;

public class UserTimeoutFilter extends UserFilter {

	public final static String X_R = "X-Requested-With";
	public final static String X_R_VALUE = "XMLHttpRequest";

	protected void redirectToLogin(ServletRequest request, ServletResponse response) throws IOException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		String xrv = httpServletRequest.getHeader(X_R);

		if (xrv != null && xrv.equalsIgnoreCase(X_R_VALUE)) {
			httpServletResponse.setHeader("sessionstatus", "timeout");
			PrintWriter out = response.getWriter();
			out.println("");
			out.flush();
			out.close();
		} else {
			super.redirectToLogin(request, response);
		}
	}

}

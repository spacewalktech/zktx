package com.zktx.platform.intercepter;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String[] IGNORE_URI = { "login", "login/login", "loginPage", "/api/" };
	
	public static Map<String, String> tokenmap = new HashMap<>();

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		boolean flag = false;
		String url = request.getRequestURL().toString();
		if (url.contains("resources")) {
			return true;
		}
		for (String s : IGNORE_URI) {
			if (url.contains(s)) {
				flag = true;
				break;
			}
		}
		if (null != request.getParameter("zktxtoken")) {
			String token = request.getParameter("zktxtoken");
			if(tokenmap.containsKey(token)){
				String userName = tokenmap.get(token);
				if(null != userName){
					flag = true;
				}
			}
		}
		if (!flag) {
			String userName = getLoginUser(request);
			if (userName != null) {
				flag = true;
			} else {
				response.sendRedirect("loginPage");
			}
		}

		return flag;
	}

	public static String getLoginUser(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("userName");
	}

}

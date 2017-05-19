package com.zktx.platform.controller.login;

import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	private static final String LOGIN_PAGE = "login";
	private static final String REDIRECT_LOGIN = "redirect:/login.html";

	@RequestMapping(value = "login.html", method = RequestMethod.GET)
	public String login() {
		return LOGIN_PAGE;
	}

	@RequestMapping(value = "/index.html", method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	@RequestMapping("/toLoginPage")
	public String toLoginPage() {
		return REDIRECT_LOGIN;
	}

	@RequestMapping(value = "login.html", method = RequestMethod.POST)
	public String fail(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username, Map<String, Object> map, ServletRequest request) {

		String msg = parseException(request);

		map.put("msg", msg);
		map.put("username", username);

		return LOGIN_PAGE;
	}

	private String parseException(ServletRequest request) {
		String errorString = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		Class<?> error = null;
		try {
			if (errorString != null) {
				error = Class.forName(errorString);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		String msg = "其他错误！";
		if (error != null) {
			if (error.equals(UnknownAccountException.class))
				msg = "未知帐号错误！";
			else if (error.equals(IncorrectCredentialsException.class))
				msg = "密码错误！";
			else if (error.equals(AuthenticationException.class))
				msg = "认证失败！";
			else if (error.equals(DisabledAccountException.class))
				msg = "账号被冻结！";
		}

		return "登录失败，" + msg;
	}

}

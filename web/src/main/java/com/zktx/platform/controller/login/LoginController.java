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
	
	@RequestMapping(value="login.html",method = RequestMethod.GET)
	public String login() {
		return LOGIN_PAGE;
	}
	
	@RequestMapping("/index.html")
	public String index() {
		return "index";
	}
	
	@RequestMapping(value="login.html",method = RequestMethod.POST)
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
	
	
	
	
	
//	@RequestMapping("login.html")
//	public String loginPage() {
//		return "/login";
//	}
//
//	@Autowired
//	protected UserService userService;
//
//	@RequestMapping("/login")
//	public String login(HttpServletRequest request, Model model) {
//
//		String msg = "";
//		String userName = request.getParameter("username");
//		String password = request.getParameter("password");
//
//		System.out.println(userName);
//		System.out.println(password);
//		UsernamePasswordToken token = new UsernamePasswordToken(userName, password);
//		token.setRememberMe(true);
//		Subject subject = SecurityUtils.getSubject();
//		if (subject.isAuthenticated()) {
//			return "/index";
//		}
//		try {
//			subject.login(token);
//			//
//			if (subject.isAuthenticated()) {
//				User user = userService.findByName(userName);
//				request.getSession().setAttribute("user", user);
//				return "/index";
//			} else {
//				return "/login";
//			}
//		} catch (IncorrectCredentialsException e) {
//			msg = "登录密码错误. Password for account " + token.getPrincipal() + " was incorrect.";
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (ExcessiveAttemptsException e) {
//			msg = "登录失败次数过多";
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (LockedAccountException e) {
//			msg = "帐号已被锁定. The account for username " + token.getPrincipal() + " was locked.";
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (DisabledAccountException e) {
//			msg = "帐号已被禁用. The account for username " + token.getPrincipal() + " was disabled.";
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (ExpiredCredentialsException e) {
//			msg = "帐号已过期. the account for username " + token.getPrincipal() + "  was expired.";
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (UnknownAccountException e) {
//			msg = "帐号不存在. There is no user with username of " + token.getPrincipal();
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (UnauthorizedException e) {
//			msg = "您没有得到相应的授权！" + e.getMessage();
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		} catch (AccountException e) {
//			msg = "您没有得到相应的授权！" + e.getMessage();
//			model.addAttribute("message", msg);
//			System.out.println(msg);
//		}
//		return "/login";
//	}
//
//	@RequestMapping("/toLoginPage")
//	public String toLoginPage() {
//		return "/login";
//	}
//	
//	@RequestMapping("/logout")
//	public String logout() {
//		Subject subject = SecurityUtils.getSubject();
//		if (subject.isAuthenticated()) {
//			subject.logout(); // session 会销毁，在SessionListener监听session销毁，清理权限缓存
//		}
//		return "redirect:/";
//	}
}

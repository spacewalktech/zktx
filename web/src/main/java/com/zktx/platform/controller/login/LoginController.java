package com.zktx.platform.controller.login;

import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.entity.tb.User;
import com.zktx.platform.service.user.UserService;

@Controller
@RequestMapping("login")
public class LoginController {

	@Autowired
	protected UserService userService;

	@RequestMapping
	public String login(String username, String password, String redirectUrl, HttpServletRequest request) {
		try {
			String msg = userService.login(username, password);
			if ("SUCCESS".equals(msg)) {
				request.getSession().setAttribute("userName", username);
				if (null == redirectUrl || "".equals(redirectUrl)) {
					return "redirect:/index.do";
				} else {
					User user = userService.findByName(username);
					String token = user.getToken();
					if (null == token) {
						token = UUID.randomUUID().toString().replace("-", "");
						// 失效时间设置为 5 个小时
						long currentTime = System.currentTimeMillis();
						long invalidTime = currentTime + 60 * 1000 * 60 * 5;
						Date date = new Date(invalidTime);
						userService.updateToken(user.getId(), token, date);
						return "redirect:" + redirectUrl + "?zktxtoken=" + token;
					} else {
						Date invalidTime = user.getToken_invalid_time();
						if (invalidTime.getTime() < new Date().getTime()) {
							token = UUID.randomUUID().toString().replace("-", "");
							// 失效时间设置为 5 个小时
							long currentTime = System.currentTimeMillis();
							long time = currentTime + 60 * 1000 * 60 * 5;
							Date date = new Date(time);
							userService.updateToken(user.getId(), token, date);
						}
						return "redirect:" + redirectUrl + "?zktxtoken=" + token;
					}
				}
			} else {
				request.setAttribute("errorMsg", msg);
				return "/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "/login";
		}
	}

}

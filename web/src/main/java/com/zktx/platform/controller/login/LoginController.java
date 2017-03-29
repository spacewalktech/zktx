package com.zktx.platform.controller.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.service.user.UserService;

@Controller
@RequestMapping("login")
public class LoginController {
	
	@Autowired
	protected UserService userService;

	@RequestMapping("login")
	@ResponseBody
	public String login(String username , String password) {
		
		String msg = userService.login(username , password);
		
		return msg;
	}
	
	
	
}

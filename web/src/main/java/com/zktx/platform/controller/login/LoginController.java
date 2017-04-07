package com.zktx.platform.controller.login;

import java.io.UnsupportedEncodingException;

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
		
		try {
			String msg = userService.login(username , password);
			String result =new String(msg.getBytes("GBK"),"UTF-8");
			return result;
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
		
	}
	
}

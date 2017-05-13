package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.User;
import com.zktx.platform.log2.SystemControllerLog;
import com.zktx.platform.service.user.UserService;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	UserService userService;

	@SystemControllerLog(description = "进入用户管理系统")
	@RequestMapping("/index")
	public String userList() {
		System.out.println("userList------");
		return "/userManager/userList";
	}

	@SystemControllerLog(description = "添加用户")
	@RequestMapping("/add")
	public @ResponseBody String addUser(User user) {

		try {
			String username = user.getName();
			String password = user.getPwd();
			String salt = "hy";
			String cryptedPwd = new Md5Hash(password, salt, 1).toString();
			user.setPwd(cryptedPwd);
			user.setName(username);
			user.setSalt(salt);
			userService.insertSelective(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	@SystemControllerLog(description = "进入用户添加页面")
	@RequestMapping("/toAdd")
	public String toAdd() {
		return "userManager/add";
	}

	@SystemControllerLog(description = "查询用户列表")
	@RequestMapping("/queryList")
	public @ResponseBody Map<String, Object> queryList(Integer offset, Integer limit) {
		try {
			int count = userService.queryCount();
			List<User> list = userService.queryList(offset, limit);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

package com.zktx.platform.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.service.user.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	RoleService service;

	@RequestMapping("/index")
	public String selectChildren() {

		return "userManager/PermissionShow";
	}

	@RequestMapping("/queryList")
	public @ResponseBody List<Role> queryList(HttpServletRequest request) {
		System.out.println("role______");
		String username = ((User) request.getSession().getAttribute("user")).getName();
		System.out.println("username:" + username);
		List<Role> roles = service.queryList();

		return roles;
	}
}

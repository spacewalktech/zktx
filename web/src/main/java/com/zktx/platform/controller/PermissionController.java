package com.zktx.platform.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Permission;
import com.zktx.platform.entity.tb.RolePermission;
import com.zktx.platform.service.user.PermissionService;

@Controller
@RequestMapping("/permission")
public class PermissionController {

	@Autowired
	PermissionService permissionService;

	@RequestMapping("/querylistByroleId")
	public @ResponseBody List<Permission> querylistByroleId(Integer roleid) {
		try {
			List<Permission> permissions = permissionService.querylistByroleId(roleid);
			return permissions;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@RequestMapping("/permissionAssign")
	public @ResponseBody String permissionAssign(String params, Integer roleId) {
		List<RolePermission> list = new ArrayList<RolePermission>();
		if (null != params && params.length() > 0) {
			String[] permissionStrs = params.split(",");
			for (String permissionId : permissionStrs) {
				RolePermission rolePermission = new RolePermission();
				rolePermission.setPermission_id(Integer.parseInt(permissionId));
				rolePermission.setRole_id(roleId);
				list.add(rolePermission);
			}
		}
		permissionService.permissionAssign(list, roleId);
		return "success";
	}
}

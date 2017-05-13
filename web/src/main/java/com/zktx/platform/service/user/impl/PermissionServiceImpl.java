package com.zktx.platform.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.PermissionMapper;
import com.zktx.platform.dao.tb.RolePermissionMapper;
import com.zktx.platform.entity.tb.Permission;
import com.zktx.platform.entity.tb.RolePermission;
import com.zktx.platform.service.user.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	PermissionMapper permissionMapper;

	@Autowired
	RolePermissionMapper rolePermissionMapper;

	@Override
	public List<Permission> querylistByroleId(Integer roleid) {
		return permissionMapper.querylistByroleId(roleid);
	}

	@Override
	public void permissionAssign(List<RolePermission> list, Integer roleid) {
		int rownum = rolePermissionMapper.deleteByRoleId(roleid);
		if (list.size() > 0 && rownum >= 0) {
			rolePermissionMapper.insertBatch(list);
		}
	}

}

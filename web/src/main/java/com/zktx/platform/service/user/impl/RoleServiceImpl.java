package com.zktx.platform.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.RoleMapper;
import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.UserRole;
import com.zktx.platform.service.user.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleMapper roleMapper;

	@Override
	public List<Role> queryList() {
		return roleMapper.queryList();
	}

	@Override
	public List<Role> findRolesByUserId(Integer userid) {
		return roleMapper.findRolesByUserId(userid);
	}

	@Override
	public List<Role> findAll() {
		return roleMapper.findAll();
	}

	@Override
	public List<UserRole> findByUserId(int id) {
		return roleMapper.findByUserId(id);
	}

}

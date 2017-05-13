package com.zktx.platform.service.user;

import java.util.List;

import com.zktx.platform.entity.tb.Role;

public interface RoleService {

	List<Role> queryList();

	public List<Role> findRolesByUserId(Integer userid);// 根据用户名查找其角色
}

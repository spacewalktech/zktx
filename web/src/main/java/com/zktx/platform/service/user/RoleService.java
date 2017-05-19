package com.zktx.platform.service.user;

import java.util.List;

import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.UserRole;

public interface RoleService {

	List<Role> queryList();

	public List<Role> findRolesByUserId(Integer userid);// 根据用户名查找其角色

	List<Role> findAll();

	List<UserRole> findByUserId(int id);
}

package com.zktx.platform.service.user;

import java.util.List;
import java.util.Set;

import com.zktx.platform.entity.tb.User;

public interface UserService {

	String login(String username, String password);

	void insertSelective(User record);

	List<User> queryList(Integer offset, Integer limit);

	int queryCount();

	User findByName(String username);

	public Set<String> findRoles(String username);// 根据用户名查找其角色

	public Set<String> findPermissions(String username); // 根据用户名查找其权限

}

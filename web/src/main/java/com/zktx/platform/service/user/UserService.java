package com.zktx.platform.service.user;

import java.util.List;
import java.util.Set;
import java.util.Date;

import com.zktx.platform.entity.tb.User;

public interface UserService {

	String login(String username, String password);

	void insertSelective(User record);

	List<User> queryList(Integer offset, Integer limit);

	int queryCount();

	User findByName(String username);

	public Set<String> findRoles(String username);// 根据用户名查找其角色

	public Set<String> findPermissions(String username); // 根据用户名查找其权限

	User findById(int id);
	void updateToken(Integer id, String token, Date date);

	User findByToken(String token);

}

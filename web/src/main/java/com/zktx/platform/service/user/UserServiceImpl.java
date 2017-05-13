package com.zktx.platform.service.user;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.UserMapper;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.util.md5.MD5Util;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;

	@Override
	public String login(String username, String password) {

		User user = userMapper.findByName(username);

		if (null == user) {
			return "用户不存在！";
		}

		String passwd = MD5Util.MD5(password + user.getSalt());

		if (user.getPwd().equals(passwd)) {
			return "SUCCESS";
		}

		return "密码错误！";
	}

	@Override
	public void insertSelective(User record) {
		userMapper.insertSelective(record);

	}

	@Override
	public List<User> queryList(Integer offset, Integer limit) {
		return userMapper.queryList(offset, limit);
	}

	@Override
	public int queryCount() {
		return userMapper.queryCount();
	}

	@Override
	public User findByName(String username) {
		return userMapper.findByName(username);
	}

	@Override
	public Set<String> findRoles(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Set<String> findPermissions(String username) {
		// TODO Auto-generated method stub
		return null;
	}

}

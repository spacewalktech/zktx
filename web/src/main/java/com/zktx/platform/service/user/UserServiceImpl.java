package com.zktx.platform.service.user;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.system.SystemMapper;
import com.zktx.platform.dao.tb.UserMapper;
import com.zktx.platform.entity.system.System;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.util.md5.MD5Util;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;

	@Autowired
	SystemMapper sysMapper;

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
	public User findByName(String username) {
		return userMapper.findByName(username);
	}

	@Override
	public void updateToken(Integer id, String token, Date date) {
		userMapper.updateToken(id, token, date);
	}

	@Override
	public User findByToken(String token) {
		return userMapper.findByToken(token);
	}

	@Override
	public int findSSOAuthorityNumByUid(Integer uid, String sysType) throws Exception {

		if (null == sysType || "".equals(sysType)) {
			throw new RuntimeException("sysType is null, please check you url!");
		}

		System system = sysMapper.findByCode(sysType);

		if (null == system) {
			throw new RuntimeException("cant find System by sysType, please check you sysType!");
		}

		Integer num = userMapper.findSSOAuthorityNumByUid(uid, system.getId());

		return num;
	}

}

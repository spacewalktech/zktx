package com.zktx.platform.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.UserMapper;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.util.md5.MD5Util;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userMapper;

	@Override
	public String login(String username, String password) {
		
		User user = userMapper.findByName(username);
		
		if(null == user){
			return "用户不存在！";
		}
		
		String passwd = MD5Util.MD5(password + user.getSalt());
		
		if(user.getPwd().equals(passwd)){
			return "SUCCESS";
		}
		
		return "密码错误！";
	}
	
	
}
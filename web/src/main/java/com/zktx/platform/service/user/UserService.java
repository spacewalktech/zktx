package com.zktx.platform.service.user;

import java.util.Date;

import com.zktx.platform.entity.tb.User;

public interface UserService {

	User findByName(String username);

	String login(String username, String password);

	void updateToken(Integer id, String token, Date date);

	User findByToken(String token);

	int findSSOAuthorityNumByUid(Integer id, String sysType) throws Exception;

}

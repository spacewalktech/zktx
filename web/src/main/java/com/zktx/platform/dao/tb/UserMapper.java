package com.zktx.platform.dao.tb;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.User;

public interface UserMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(User record);

	int insertSelective(User record);

	User selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(User record);

	int updateByPrimaryKey(User record);

	User findByName(String username);

	void updateToken(@Param("id") Integer id, @Param("token") String token, @Param("time") Date date);

	User findByToken(String token);

	Integer findSSOAuthorityNumByUid(@Param("uid") Integer uid, @Param("system_id") Integer system_id);
}
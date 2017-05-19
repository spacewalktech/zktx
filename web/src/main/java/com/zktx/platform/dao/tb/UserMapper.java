package com.zktx.platform.dao.tb;

import java.util.List;
import java.util.Set;
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

	User findByName(@Param("username") String username);

	List<User> queryList(@Param("offset") Integer offset, @Param("limit") Integer limit);

	int queryCount();

	public Set<String> findRoles(@Param("username") String username);// 根据用户名查找其角色


	void updateToken(@Param("id") Integer id,@Param("token")  String token,@Param("time")  Date date);

	User findByToken(String token);
}
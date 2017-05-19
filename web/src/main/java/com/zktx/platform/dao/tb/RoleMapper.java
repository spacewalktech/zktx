package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.UserRole;

public interface RoleMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Role record);

	int insertSelective(Role record);

	Role selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Role record);

	int updateByPrimaryKey(Role record);

	List<Role> queryList();

	public List<Role> findRolesByUserId(@Param("userid") Integer userid);// 根据用户名查找其角色

	List<Role> findAll();

	List<UserRole> findByUserId(@Param("uid") int id);
}
package com.zktx.platform.dao.system;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.system.System;

public interface SystemMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(System record);

	int insertSelective(System record);

	System selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(System record);

	int updateByPrimaryKey(System record);

	System findByCode(@Param("code") String code);
}
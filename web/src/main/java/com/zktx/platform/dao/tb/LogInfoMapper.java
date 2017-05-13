package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.logInfo;

public interface LogInfoMapper {

	public void insertLogInfo(logInfo logInfo);

	public List<logInfo> queryList(@Param("user_name") String user_name, @Param("create_time_from") String create_time_from,
			@Param("create_time_to") String create_time_to, @Param("offset") Integer offset, @Param("limit") Integer limit);

	public Integer queryCount(@Param("user_name") String user_name, @Param("create_time_from") String create_time_from,
			@Param("create_time_to") String create_time_to);

}

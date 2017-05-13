package com.zktx.platform.service.log;

import java.util.List;

import com.zktx.platform.entity.tb.logInfo;

public interface LogService {

	public void insertLogInfo(logInfo logInfo);

	public List<logInfo> queryList(String user_name, String create_time_from, String create_time_to, Integer offset, Integer limit);

	public Integer queryCount(String user_name, String create_time_from, String create_time_to);

}

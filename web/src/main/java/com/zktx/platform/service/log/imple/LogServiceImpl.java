package com.zktx.platform.service.log.imple;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.LogInfoMapper;
import com.zktx.platform.entity.tb.logInfo;
import com.zktx.platform.service.log.LogService;

@Service("logService")
public class LogServiceImpl implements LogService {

	@Autowired
	LogInfoMapper logInfoMapper;

	@Override
	public void insertLogInfo(logInfo logInfo) {
		logInfoMapper.insertLogInfo(logInfo);
	}

	@Override
	public List<logInfo> queryList(String user_name, String create_time_from, String create_time_to, Integer offset, Integer limit) {

		return logInfoMapper.queryList(user_name, create_time_from, create_time_to, offset, limit);
	}

	@Override
	public Integer queryCount(String user_name, String create_time_from, String create_time_to) {
		return logInfoMapper.queryCount(user_name, create_time_from, create_time_to);
	}

}

package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.TaskHistoryMapper;
import com.zktx.platform.entity.tb.TaskHistoryWithBLOBs;
import com.zktx.platform.service.importtable.TaskHistoryService;

@Service("taskHistoryService")
public class TaskHistoryServiceImpl implements TaskHistoryService {

	@Autowired
	TaskHistoryMapper mapper;

	@Override
	public List<TaskHistoryWithBLOBs> queryByPage(Integer offset, Integer limit, int type) {
		return mapper.queryByPage(offset, limit, type);
	}

	@Override
	public int queryCountByPage(Integer offset, Integer limit, int type) {
		return mapper.queryCountByPage(type);
	}

}

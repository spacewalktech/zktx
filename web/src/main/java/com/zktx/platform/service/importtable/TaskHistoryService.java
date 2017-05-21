package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.TaskHistoryWithBLOBs;

public interface TaskHistoryService {

	List<TaskHistoryWithBLOBs> queryByPage(Integer offset, Integer limit, int i);

	int queryCountByPage(Integer offset, Integer limit, int i);

}

package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.TaskHistory;
import com.zktx.platform.entity.tb.TaskHistoryWithBLOBs;

public interface TaskHistoryMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(TaskHistoryWithBLOBs record);

	int insertSelective(TaskHistoryWithBLOBs record);

	TaskHistoryWithBLOBs selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(TaskHistoryWithBLOBs record);

	int updateByPrimaryKeyWithBLOBs(TaskHistoryWithBLOBs record);

	int updateByPrimaryKey(TaskHistory record);

	List<TaskHistoryWithBLOBs> queryByPage(@Param("offset") Integer offset, @Param("limit") Integer limit, @Param("type") int type);

	int queryCountByPage(@Param("type") Integer type);
}
package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.TaskQueue;

public interface TaskQueueMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(TaskQueue record);

	int insertSelective(TaskQueue record);

	TaskQueue selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(TaskQueue record);

	int updateByPrimaryKeyWithBLOBs(TaskQueue record);

	int updateByPrimaryKey(TaskQueue record);

	// 任务监控
	List<TaskQueue> queryRunningTaskList(@Param("offset") Integer offset, @Param("limit") Integer limit);

	int queryCountRunnngTask();

}
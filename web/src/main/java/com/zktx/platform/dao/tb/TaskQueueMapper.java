package com.zktx.platform.dao.tb;

import com.zktx.platform.entity.tb.TaskQueue;

public interface TaskQueueMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TaskQueue record);

    int insertSelective(TaskQueue record);

    TaskQueue selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TaskQueue record);

    int updateByPrimaryKeyWithBLOBs(TaskQueue record);

    int updateByPrimaryKey(TaskQueue record);
}
package com.zktx.platform.dao.tb;

import com.zktx.platform.entity.tb.MrTask;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;

public interface MrTaskMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MrTaskWithBLOBs record);

    int insertSelective(MrTaskWithBLOBs record);

    MrTaskWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MrTaskWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(MrTaskWithBLOBs record);

    int updateByPrimaryKey(MrTask record);
}
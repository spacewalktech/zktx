package com.zktx.platform.dao.tb;

import com.zktx.platform.entity.tb.Stage;

public interface StageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Stage record);

    int insertSelective(Stage record);

    Stage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Stage record);

    int updateByPrimaryKeyWithBLOBs(Stage record);

    int updateByPrimaryKey(Stage record);
}
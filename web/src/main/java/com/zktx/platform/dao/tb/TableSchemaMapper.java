package com.zktx.platform.dao.tb;

import java.util.List;

import com.zktx.platform.entity.tb.TableSchema;

public interface TableSchemaMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TableSchema record);

    int insertSelective(TableSchema record);

    TableSchema selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TableSchema record);

    int updateByPrimaryKeyWithBLOBs(TableSchema record);

    int updateByPrimaryKey(TableSchema record);
    
    List<TableSchema> selectByImportTableId(Integer table_id);
    
}
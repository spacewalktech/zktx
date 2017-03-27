package com.zktx.platform.dao.tb;

import java.util.List;

import com.zktx.platform.entity.tb.ImportTables;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;

public interface ImportTablesMapper {
	
    int deleteByPrimaryKey(Integer id);

    int insert(ImportTablesWithBLOBs record);

    int insertSelective(ImportTablesWithBLOBs record);

    ImportTablesWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ImportTablesWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(ImportTablesWithBLOBs record);

    int updateByPrimaryKey(ImportTables record);

	List<ImportTablesWithBLOBs> findBySource(int source);
}
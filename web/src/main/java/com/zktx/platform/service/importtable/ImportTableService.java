package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;

public interface ImportTableService {

	public List<ImportTablesWithBLOBs> findBySource(int source);
	
}

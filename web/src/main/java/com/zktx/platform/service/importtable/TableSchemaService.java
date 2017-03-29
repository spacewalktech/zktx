package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.TableSchema;

public interface TableSchemaService {

	List<TableSchema> selectByImportTableId(Integer tableId);
}

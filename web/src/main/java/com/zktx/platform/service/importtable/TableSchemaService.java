package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.TableSchema;
import com.zktx.platform.entity.tb.TableSchemaPo;

public interface TableSchemaService {

	List<TableSchemaPo> selectByImportTableId(Integer tableId,Integer fromRowId,Integer num);
	
	Integer selectCountBytId(Integer tableId);
}

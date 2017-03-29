package com.zktx.platform.service.importtable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.TableSchemaMapper;
import com.zktx.platform.entity.tb.TableSchema;
@Service("tableSchemaService")
public class TableSchemaServiceImpl implements TableSchemaService {

	@Autowired
	private TableSchemaMapper mapper;
	
	@Override
	public List<TableSchema> selectByImportTableId(Integer tableId) {
		
		return mapper.selectByImportTableId(tableId);
	}

}

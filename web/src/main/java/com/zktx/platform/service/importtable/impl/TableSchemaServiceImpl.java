package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.TableSchemaMapper;
import com.zktx.platform.entity.tb.TableSchema;
import com.zktx.platform.service.importtable.TableSchemaService;
@Service("tableSchemaService")
public class TableSchemaServiceImpl implements TableSchemaService {

	@Autowired
	private TableSchemaMapper mapper;
	
	@Override
	public List<TableSchema> selectByImportTableId(Integer tableId,Integer fromRowId,Integer num) {
		
		return mapper.selectByImportTableId(tableId,fromRowId,num);
	}

}

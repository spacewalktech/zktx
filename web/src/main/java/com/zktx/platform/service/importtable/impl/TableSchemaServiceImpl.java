package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.TableSchemaMapper;
import com.zktx.platform.entity.tb.TableSchemaPo;
import com.zktx.platform.service.importtable.TableSchemaService;
@Service("tableSchemaService")
public class TableSchemaServiceImpl implements TableSchemaService {

	@Autowired
	private TableSchemaMapper mapper;
	
	@Override
	public List<TableSchemaPo> selectByImportTableId(Integer tableId,Integer fromRowId,Integer num) {
		
		return mapper.selectByImportTableId(tableId,fromRowId,num);
	}

	@Override
	public Integer selectCountBytId(Integer tableId) {
		
		return mapper.selectCountBytId(tableId);
	}

}

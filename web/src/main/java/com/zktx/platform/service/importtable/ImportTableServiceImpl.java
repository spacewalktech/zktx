package com.zktx.platform.service.importtable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.ImportTablesMapper;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;

@Service("importTableService")
public class ImportTableServiceImpl implements ImportTableService{
	
	@Autowired
	ImportTablesMapper mapper;
	
	@Override
	public List<ImportTablesWithBLOBs> findBySource(int source) {
		List<ImportTablesWithBLOBs> list = mapper.findBySource(source);
		return list;
	}

}

package com.zktx.platform.service.importtable.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.zktx.platform.dao.tb.ImportTablesMapper;
import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;

@Service("importTableService")
public class ImportTableServiceImpl implements ImportTableService{
	
	
	@Autowired
	ImportTablesMapper mapper;
	
	@Override
	public List<ImportTablesWithBLOBs> findBySource(int source) {
		List<ImportTablesWithBLOBs> list = mapper.findBySource(source);
		return list;
	}
	//分页查询
	@Override
	public List<ImportTablesWithBLOBs> findByPagination(ImportTablesPo record, Integer fromRowId, Integer num) {
		// TODO Auto-generated method stub
		
		Map<String, Object> params = new HashMap<String,Object >();
		if(null!=record){
			params.put("src_db", record.getSrc_db());
			params.put("src_table", record.getSrc_table());
			params.put("dbname", record.getDbname());
			params.put("table_name", record.getTable_name());
			params.put("src_db_type", record.getSrc_db_type());
		}
		
		params.put("fromRowId", fromRowId);
		params.put("num", num);
		List<ImportTablesWithBLOBs> lists =mapper.findByPagination(params);
		return lists;
	}

	@Override
	public int insertSelective(ImportTablesWithBLOBs record) {
		
		return mapper.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(ImportTablesWithBLOBs record) {
		return mapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		
		return mapper.deleteByPrimaryKey(id);
	}

}

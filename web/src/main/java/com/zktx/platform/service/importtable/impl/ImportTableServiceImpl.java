package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.ImportTablesMapper;
import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;

@Service("importTableService")
public class ImportTableServiceImpl implements ImportTableService {

	@Autowired
	ImportTablesMapper mapper;

	@Override
	public List<ImportTablesWithBLOBs> findBySource(int source) {
		List<ImportTablesWithBLOBs> list = mapper.findBySource(source);
		return list;
	}

	// 分页查询
	@Override
	public List<ImportTablesWithBLOBs> findByPagination(ImportTablesPo record) {
		List<ImportTablesWithBLOBs> lists = mapper.findByPagination(record);
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

	@Override
	public Integer findCountByParms(ImportTablesPo tablesPo) {
		return mapper.findCountByParms(tablesPo);
	}

	@Override
	public ImportTablesWithBLOBs selectByPrimaryKey(Integer id) {

		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<String> findDistintSRCDBType() {

		return mapper.findDistintSRCDBType();
	}

	@Override
	public List<String> findDistintDBType() {
		return mapper.findDistintDBType();
	}

	@Override
	public Integer queryCountTable(Integer id, String table_name, String dbname) {
		return mapper.queryCountTable(id, table_name, dbname);
	}

}

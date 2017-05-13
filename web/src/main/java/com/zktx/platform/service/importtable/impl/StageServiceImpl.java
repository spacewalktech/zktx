package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.StageMapper;
import com.zktx.platform.entity.tb.Stage;
import com.zktx.platform.service.importtable.StageService;

@Service("stageService")
public class StageServiceImpl implements StageService {

	@Autowired
	private StageMapper mapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return 0;
	}

	@Override
	public int insertSelective(Stage record) {
		return 0;
	}

	@Override
	public int updateByPrimaryKeySelective(Stage record) {
		return 0;
	}

	// 表预警
	@Override
	public List<Stage> queryStageByTableType(Integer tableType, Integer offset, Integer limit) {
		List<Stage> lists = mapper.queryStageByTableType(tableType, offset, limit);
		return lists;
	}

	@Override
	public List<Stage> queryStageByTableId(Integer import_table_id, Integer offset, Integer limit) {
		return mapper.queryStageByTableId(import_table_id, offset, limit);
	}

	@Override
	public Integer queryCountByTableId(Integer import_table_id) {

		return mapper.queryCountByTableId(import_table_id);
	}

	@Override
	public Integer queryCountByTableType(Integer tableType) {
		return mapper.queryCountByTableType(tableType);
	}

	@Override
	public List<Stage> queryStageList(Integer offset, Integer limit) {
		return mapper.queryStageList(offset, limit);
	}

	@Override
	public int queryCount() {
		return mapper.queryCount();
	}

}

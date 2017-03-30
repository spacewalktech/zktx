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


//导入表预警
	@Override
	public List<Stage> queryStageOriByTableType(Integer tableType,Integer fromRowId,Integer num) {
		List<Stage> lists =mapper.queryStageByTableType(0, 0,fromRowId,num);
		return lists;
	}

//派生表预警
	@Override
	public List<Stage> queryStageDerByTableType(Integer tableType,Integer fromRowId,Integer num) {
		List<Stage> lists =mapper.queryStageByTableType(0 , 1,fromRowId,num);
		return lists;
	}
	
	

}

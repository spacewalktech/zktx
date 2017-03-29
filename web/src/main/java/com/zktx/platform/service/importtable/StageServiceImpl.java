package com.zktx.platform.service.importtable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.StageMapper;
import com.zktx.platform.entity.tb.Stage;
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
	public List<Stage> queryStageOriByTableType(Integer tableType) {
		List<Stage> lists =mapper.queryStageByTableType(tableType, 0);
		return null;
	}

//派生表预警
	@Override
	public List<Stage> queryStageDerByTableType(Integer tableType) {
		List<Stage> lists =mapper.queryStageByTableType(tableType, 1);
		return null;
	}
	
	

}

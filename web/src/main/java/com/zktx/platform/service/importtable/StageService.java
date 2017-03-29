package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.Stage;

public interface StageService {

	 	int deleteByPrimaryKey(Integer id);

	    int insertSelective(Stage record);

	    int updateByPrimaryKeySelective(Stage record);

	    public List<Stage> queryStageOriByTableType(Integer tableType,Integer fromRowId,Integer num);
	    
	    public List<Stage> queryStageDerByTableType(Integer tableType,Integer fromRowId,Integer num);
}

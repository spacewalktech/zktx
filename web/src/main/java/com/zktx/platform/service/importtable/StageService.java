package com.zktx.platform.service.importtable;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.Stage;

public interface StageService {

	 	int deleteByPrimaryKey(Integer id);

	    int insertSelective(Stage record);

	    int updateByPrimaryKeySelective(Stage record);

	    public List<Stage> queryStageByTableType(Integer tableType,Integer fromRowId,Integer num);
	    
	    public List<Stage> queryStageByTableId(Integer import_table_id ,Integer fromRowId,Integer num);
}

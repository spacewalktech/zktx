package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.Stage;

public interface StageService {

	int deleteByPrimaryKey(Integer id);

	int insertSelective(Stage record);

	int updateByPrimaryKeySelective(Stage record);

	public List<Stage> queryStageByTableType(Integer tableType, Integer offset, Integer limit);

	public Integer queryCountByTableType(Integer tableType);

	public List<Stage> queryStageByTableId(Integer import_table_id, Integer offset, Integer limit);

	public Integer queryCountByTableId(Integer import_table_id);

	public List<Stage> queryStageList(Integer offset, Integer limit, Integer tbid);

	public int queryCount();

}

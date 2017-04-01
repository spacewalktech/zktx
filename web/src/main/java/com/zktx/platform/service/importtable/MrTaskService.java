package com.zktx.platform.service.importtable;

import java.util.List;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;

public interface MrTaskService {

	List<MrTaskWithBLOBs> findByPagination(Integer latest_running_status, Integer offset, Integer limit, String search_name, String search_type, String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end);
	
	List<MrTaskWithBLOBs> findByToRun(Integer offset , Integer limit);
	
	List<MrTaskWithBLOBs> findByProper(Integer fromRowId , Integer num);
	
	 int insertSelective(MrTaskWithBLOBs record);
	 
	 void deleteByPrimaryKey(Integer id);
	 
	 void updateByPrimaryKeySelective(MrTaskWithBLOBs record);
	 
	 public void taskAction(Integer id);

	int findCount();

	MrTaskWithBLOBs findById(Integer id);

	int findCountByPagination(Integer last_running_status, String search_name, String search_type, String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end);

	int findCountByToRun(Integer offset, Integer limit);

	void deleteQueueByid(Integer id);

	int findCountByProper();
}

package com.zktx.platform.service.importtable;

import java.util.List;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;

public interface MrTaskService {

	List<MrTaskWithBLOBs> findByPagination(Integer fromRowId , Integer num);
	
	List<MrTaskWithBLOBs> findByToRun(Integer fromRowId , Integer num);
	
	 int insertSelective(MrTaskWithBLOBs record);
	 
}

package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.UploadBatRecord;

public interface UploadBatRecordService {

public List<UploadBatRecord> queryList(Integer offset ,Integer limit);
	
	public Integer queryCount();
}

package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.UploadBatRecord;

public interface UploadBatRecordMapper {
	
public List<UploadBatRecord> queryList(@Param("offset") Integer offset ,@Param("limit") Integer limit);
	
	public Integer queryCount();
}

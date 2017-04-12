package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.UploadBatRecordMapper;
import com.zktx.platform.entity.tb.UploadBatRecord;
import com.zktx.platform.service.importtable.UploadBatRecordService;

@Service("uploadBatRecordService")
public class UploadBatRecordServiceImpl implements UploadBatRecordService {

	@Autowired
	UploadBatRecordMapper recordMapper;
	@Override
	public List<UploadBatRecord> queryList(Integer offset, Integer limit) {
		return recordMapper.queryList(offset, limit);
	}

	@Override
	public Integer queryCount() {
		return recordMapper.queryCount();
	}

}

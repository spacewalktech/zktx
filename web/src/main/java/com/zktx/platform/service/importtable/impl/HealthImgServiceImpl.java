package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.HealthImgMapper;
import com.zktx.platform.entity.tb.HealthImg;
import com.zktx.platform.service.importtable.HealthImgService;
@Service("healthImgService")
public class HealthImgServiceImpl implements HealthImgService {

	@Autowired
	HealthImgMapper healthImgMapper;
	@Override
	public List<HealthImg> queryList(Integer offset, Integer limit) {
		return healthImgMapper.queryList(offset, limit);
	}

	@Override
	public Integer queryCount() {
		return healthImgMapper.queryCount();
	}

}

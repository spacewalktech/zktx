package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.HealthImg;
public interface HealthImgService {
	
	public List<HealthImg> queryList(Integer offset ,Integer limit);
	
	public Integer queryCount();
	
}

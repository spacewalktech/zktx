package com.zktx.platform.service.importtable;

import java.util.List;

import com.zktx.platform.entity.tb.Annotation;

public interface AnnotationService {

	public List<Annotation> queryList(Integer offset ,Integer limit);
	
	public Integer queryCount();
}

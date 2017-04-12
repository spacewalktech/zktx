package com.zktx.platform.service.importtable.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.AnnotationMapper;
import com.zktx.platform.entity.tb.Annotation;
import com.zktx.platform.service.importtable.AnnotationService;

@Service("annotationService")
public class AnnotationServiceImpl implements AnnotationService {

	@Autowired
	AnnotationMapper annotationMapper;
	@Override
	public List<Annotation> queryList(Integer offset, Integer limit) {
		return annotationMapper.queryList(offset, limit);
	}

	@Override
	public Integer queryCount() {
		return annotationMapper.queryCount();
	}

}

package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.Annotation;

public interface AnnotationMapper {
	
public List<Annotation> queryList(@Param("offset") Integer offset ,@Param("limit") Integer limit);
	
	public Integer queryCount();
}

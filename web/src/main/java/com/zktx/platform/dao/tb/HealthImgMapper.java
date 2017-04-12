package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.HealthImg;

public interface HealthImgMapper {

	public List<HealthImg> queryList(@Param("offset") Integer offset ,@Param("limit") Integer limit);
	
	public Integer queryCount();
	
	public int insert(HealthImg healthImg);
}

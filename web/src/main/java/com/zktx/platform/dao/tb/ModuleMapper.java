package com.zktx.platform.dao.tb;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zktx.platform.entity.tb.Module;

public interface ModuleMapper {

	List<Module> queryList();

	List<Module> queryListByPId(@Param("pid") Integer pid);

	int insertSelective(Module module);

	Integer queryCountbySn(@Param("sn") String sn, @Param("id") Integer id);

	Module queryModuleById(@Param("id") Integer id);

	int updateByPrimaryKeySelective(Module module);

	void deleteByIds(List<Integer> ids);

}
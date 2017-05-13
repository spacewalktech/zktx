package com.zktx.platform.service.user;

import java.util.List;

import com.zktx.platform.entity.tb.Module;

public interface ModuleService {

	List<Module> getTree();

	List<Module> queryListByPId(Integer pid);

	void insertSelective(Module module);

	Integer queryCountbySn(String sn, Integer id);

	Module queryModuleById(Integer id);

	int updateByPrimaryKeySelective(Module module);

	void deleteByIds(List<Integer> ids);

	String queryMaxGradeByPid(Integer pid);
}

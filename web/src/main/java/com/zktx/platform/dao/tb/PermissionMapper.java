package com.zktx.platform.dao.tb;

import java.util.List;

import com.zktx.platform.entity.tb.Permission;

public interface PermissionMapper {

	List<Permission> querylistByroleId(Integer roleid);

	List<Permission> queryListByModuleId(Integer moduleId);

	List<Permission> queryPermissionDISTINCT();

	void insertBatch(List<Permission> permissions);
}

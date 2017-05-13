package com.zktx.platform.dao.tb;

import java.util.List;

import com.zktx.platform.entity.tb.RolePermission;

public interface RolePermissionMapper {

	int deleteByRoleId(Integer roleid);

	void insertBatch(List<RolePermission> rolePermissions);

}

package com.zktx.platform.service.user;

import java.util.List;

import com.zktx.platform.entity.tb.Permission;
import com.zktx.platform.entity.tb.RolePermission;

public interface PermissionService {

	List<Permission> querylistByroleId(Integer roleid);

	void permissionAssign(List<RolePermission> list, Integer roleid);

}

package com.zktx.platform.shiro;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.zktx.platform.entity.tb.Permission;
import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.service.user.PermissionService;
import com.zktx.platform.service.user.RoleService;
import com.zktx.platform.service.user.UserService;

public class ShiroRealm extends AuthorizingRealm {

	protected boolean activeRoot = false;

	@Autowired
	protected UserService userService;

	@Autowired
	protected RoleService roleService;

	@Autowired
	protected PermissionService permissionService;

	public ShiroRealm() {
		super();
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher("MD5");
		setCredentialsMatcher(matcher);
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Collection<String> hasPermissions = null;
		Collection<String> hasRoles = null;
		String username = (String) principals.getPrimaryPrincipal();
		User user = userService.findByName(username);
		if (activeRoot && user.getId() == 1) {
			hasRoles = new HashSet<String>();
			List<Role> roles = roleService.queryList();
			for (Role role : roles) {
				hasRoles.add(role.getName());
			}
			hasPermissions = new HashSet<String>();
			hasPermissions.add("*");
		} else {
			List<Role> roles = roleService.findRolesByUserId(user.getId());
			hasRoles = makeRoles(roles);
			hasPermissions = makePermissions(roles);
		}
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.addRoles(hasRoles);
		info.addStringPermissions(hasPermissions);
		return info;
	}

	private Collection<String> makeRoles(List<Role> roles) {
		Collection<String> hasRoles = new HashSet<String>();
		for (Role role : roles) {
			hasRoles.add(role.getName());
		}
		return hasRoles;
	}

	private Collection<String> makePermissions(List<Role> roles) {
		Collection<String> hasPermissions = new HashSet<String>();
		for (Role role : roles) {
			List<Permission> permissions = permissionService.querylistByroleId(role.getId());
			if (null != permissions && permissions.size() > 0) {
				for (Permission permission : permissions) {
					String resource = permission.getModule().getSn();
					String operate = permission.getSn();
					StringBuilder builder = new StringBuilder();
					builder.append(resource + ":" + operate);
					hasPermissions.add(builder.toString());
				}
			}
		}
		return hasPermissions;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken usernamepasswordToken = (UsernamePasswordToken) token;
		String username = (String) usernamepasswordToken.getPrincipal();
		User user = userService.findByName(username);
		if (null != user) {
			if (user.getStatus() == 0) {
				throw new DisabledAccountException();
			}
			return new SimpleAuthenticationInfo(user.getName(), user.getPwd(), ByteSource.Util.bytes(user.getSalt()), getName());
		}
		return null;
	}

	public void setActiveRoot(boolean activeRoot) {
		this.activeRoot = activeRoot;
	}

}

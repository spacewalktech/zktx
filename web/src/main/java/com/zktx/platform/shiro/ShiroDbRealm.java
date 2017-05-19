package com.zktx.platform.shiro;

import java.util.ArrayList;
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
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.zktx.platform.entity.tb.Role;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.entity.tb.UserRole;
import com.zktx.platform.entity.tb.user.ShiroUser;
import com.zktx.platform.service.user.RoleService;
import com.zktx.platform.service.user.UserService;

public class ShiroDbRealm extends AuthorizingRealm {

	private static final int INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;
	private static final String ALGORITHM = "SHA-1";

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	// @Autowired
	// private PartnerUserRoleService userRoleService;

	public ShiroDbRealm() {
		super();
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(ALGORITHM);
		matcher.setHashIterations(INTERATIONS);
		setCredentialsMatcher(matcher);
	}

	/* 登录验证 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {

		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		User user = userService.findByName(token.getUsername());

		if (user == null)
			return null;

		if (user.getStatus().intValue() == User.STATUS_0) {
			throw new DisabledAccountException();
		}

		byte[] salt = Encodes.decodeHex(user.getSalt());

		ShiroUser shiroUser = new ShiroUser(user.getId(), user.getName());
		shiroUser.setUser(user);

		// 这里可以缓存认证
		return new SimpleAuthenticationInfo(shiroUser, user.getPwd(), ByteSource.Util.bytes(salt), getName());
	}

	/* 权限验证, 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

		Collection<?> collection = principals.fromRealm(getName());

		if (collection == null || collection.isEmpty()) {
			return null;
		}

		ShiroUser shiroUser = (ShiroUser) collection.iterator().next();
		// 设置、更新User
		shiroUser.setUser(userService.findById(shiroUser.getId()));
		return newAuthorizationInfo(shiroUser);
	}

	private SimpleAuthorizationInfo newAuthorizationInfo(ShiroUser shiroUser) {

		Collection<String> hasRoles = null;
		Collection<String> hasPermissions = null;

		// 是否启用超级管理员 && id==1为超级管理员，构造所有权限
		if (shiroUser.getId() == 1) {
			hasRoles = new HashSet<String>();

			// 超级管理员给全部角色
			List<Role> userRoles = roleService.findAll();
			for (Role partnerRole : userRoles) {
				hasRoles.add(partnerRole.getName());
			}

			hasPermissions = new HashSet<String>();
			hasPermissions.add("*");
		} else {
			// 用户角色 TODO
			List<UserRole> userRoles = roleService.findByUserId(shiroUser.getId());
			List<UserRole> roles = new ArrayList<UserRole>();
			// 组织的角色目前还没有，等待写接口
			if (userRoles != null && userRoles.size() > 0) {
				for (UserRole userRole : userRoles) {
					roles.add(userRole);
				}
			}

			hasRoles = makeRoles(roles);
			hasPermissions = makePermissions(roles);
		}

		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.addRoles(hasRoles);
		info.addStringPermissions(hasPermissions);
		return info;
	}

	private Collection<String> makeRoles(List<UserRole> userRoles) {
		Collection<String> hasRoles = new HashSet<String>();
		for (UserRole role : userRoles) {
			// hasRoles.add(role.getName()); TODO
		}
		return hasRoles;
	}

	private Collection<String> makePermissions(List<UserRole> userRoles) {
		Collection<String> stringPermissions = new ArrayList<String>();
		for (UserRole role : userRoles) {

			// // 查询角色拥有权限
			// List<PartnerRolePermission> lits =
			// role.getPartnerRolePermission();
			// for (PartnerRolePermission mission : lits) {
			//
			// StringBuffer sb = new StringBuffer();
			//
			// sb.append(mission.getPermission().getModel().getSn() + ":" +
			// mission.getPermission().getSn());
			//
			// stringPermissions.add(sb.toString());
			// }

		}
		return stringPermissions;
	}

	public static class HashPassword {
		public String salt;
		public String password;
	}

	public static HashPassword encryptPassword(String plainPassword) {
		HashPassword result = new HashPassword();
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		result.salt = Encodes.encodeHex(salt);

		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, INTERATIONS);
		result.password = Encodes.encodeHex(hashPassword);
		return result;
	}

	/**
	 *
	 * 验证密码
	 *
	 * @param plainPassword
	 *            明文密码
	 * @param password
	 *            密文密码
	 * @param salt
	 *            盐值
	 * @return
	 */
	public static boolean validatePassword(String plainPassword, String password, String salt) {
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), Encodes.decodeHex(salt), INTERATIONS);
		String oldPassword = Encodes.encodeHex(hashPassword);
		return password.equals(oldPassword);
	}

	@Override
	protected Object getAuthorizationCacheKey(PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		return shiroUser.getName();
	}

	/**
	 * 更新用户授权信息缓存.
	 */
	public void clearCachedAuthorizationInfo(String loginName) {

		ShiroUser shiroUser = new ShiroUser(loginName);

		SimplePrincipalCollection principals = new SimplePrincipalCollection(shiroUser, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清除所有用户授权信息缓存.
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}

}

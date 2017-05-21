package com.zktx.platform.shiro;

public class Test {

	public static void main(String[] args) {

		byte[] salt = Digests.generateSalt(8);
		String salt1 = Encodes.encodeHex(salt);

		System.out.println(salt1);

		byte[] hashPassword = Digests.sha1("sky".getBytes(), salt, 1024);
		String password = Encodes.encodeHex(hashPassword);

		System.out.println(password);

	}

}

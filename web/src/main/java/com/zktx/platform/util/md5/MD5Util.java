package com.zktx.platform.util.md5;

import java.security.MessageDigest;

public class MD5Util {

	public final static String MD5(String s) {
		try {
			byte[] btInput = s.getBytes();
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			mdInst.update(btInput);
			byte[] md = mdInst.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < md.length; i++) {
				int val = ((int) md[i]) & 0xff;
				if (val < 16)
					sb.append("0");
				sb.append(Integer.toHexString(val));
			}
			return sb.toString();
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public static void main(String[] args) {
		
		// 624ed106045be462c564dd063a8ac240
		// 15ec1b74b22c06d24f3013cc85289d2f
		System.out.println(MD5("123456sKp6w2"));
		
	}

}

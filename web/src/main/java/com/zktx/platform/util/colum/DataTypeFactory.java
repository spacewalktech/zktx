package com.zktx.platform.util.colum;

import java.util.Map;

import com.zktx.platform.enm.MysqlTypeEnum;

public class DataTypeFactory {
	
	public static Map<String, String> getEnum(String type) {
		
		if ("mysql".equals(type)){
			return MysqlTypeEnum.getMap();
		}
		return null;
	}

}

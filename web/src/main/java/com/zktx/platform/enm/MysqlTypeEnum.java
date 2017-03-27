package com.zktx.platform.enm;

import java.util.HashMap;
import java.util.Map;

public enum MysqlTypeEnum {

	A("tinyint","tinyint"),
	B("smallint", "smallint"),
	C("dediumint", "int"),
	D("int", "int"),
	E("bigint", "bigint"),
	F("float", "float"),
	G("double", "double"),
	H("doubleprecision", "decimal"),
	I("real", "decimal"),
	J("decimal", "decimal"),
	K("bit", "int"),
	L("serial", "bigint"),
	M("bool", "boolean"),
	N("boolean", "boolean"),
	O("dec", "decimal"),
	P("fixed", "decimal"),
	Q("numeric", "decimal"),
	R("char", "char"),
	S("varchar", "varchar"),
	T("tinytext", "string"),
	U("text", "string"),
	V("mediumtext", "string"),
	W("longtext", "string"),
	X("tinyblob", "binary"),
	Y("mediumblob", "binary"),
	Z("blob", "binary"),
	AA("longblob", "binary"),
	AB("binary", "binary"),
	AC("varbinary", "binary"),
	AD("enum", "string"),
	AE("set", "string"),
	AF("date", "date"),
	AG("datetime", "timestamp"),
	AH("timestamp", "string"),
	AI("time", "string"),
	AJ("year", "string"),
	AK("geometry", "string"),
	AL("point", "string"),
	AM("linestring", "string"),
	AN("polygon", "string"),
	AO("multpoint", "string"),
	AP("multilnesstring", "string"),
	AQ("multipolygon", "string"),
	AU("geometrycollection", "string");
	
	
	private String mysqlType;

	private String sparkType;
	
	private static Map<String, String> map = new HashMap<>();
	
	private MysqlTypeEnum(String mysqlType, String sparkType) {
		this.mysqlType = mysqlType;
		this.sparkType = sparkType;
	}

	static {
		
		for (MysqlTypeEnum mysqlTypeEnum : MysqlTypeEnum.values()) {
			map.put(mysqlTypeEnum.getMysqlType(), mysqlTypeEnum.getSparkType());
		}
		
	}

	public String getMysqlType() {
		return mysqlType;
	}

	public void setMysqlType(String mysqlType) {
		this.mysqlType = mysqlType;
	}

	public String getSparkType() {
		return sparkType;
	}

	public void setSparkType(String sparkType) {
		this.sparkType = sparkType;
	}

	public static Map<String, String> getMap() {
		return map;
	}

}
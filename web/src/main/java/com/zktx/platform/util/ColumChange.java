package com.zktx.platform.util;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.ColumInfo;
import com.zktx.platform.entity.Schema;
import com.zktx.platform.util.colum.DataTypeFactory;

public class ColumChange {
	
	public static void main(String[] args) {
		
		String sql = "{\"db_type\":\"mysql\",\"db_version\":\"5.7\",\"db_name\":\"test_db\",\"table_name\":\"test_table\",\"schema\":[{\"name\":\"id\",\"type\":\"int\",\"primary\":1},{\"name\":\"name\",\"type\":\"varchar(10)\",\"unique\":1},{\"name\":\"sex\",\"type\":\"int\"},{\"name\":\"age\",\"type\":\"int\"},{\"name\":\"info\",\"type\":\"varchar(500)\"}]}";
		
		System.out.println(getSparkSchema(sql));
		
	}
	
	private static final String baseType = "string";
	
	/**
	 * 
	 * {"db_type":"mysql", "db_version":"5.7", "db_name":"test_db",
	 * "table_name":"test_table", "schema":[
	 * {"name":"id","type":"int","primary":1},
	 * {"name":"name","type":"varchar(10)","unique":1},
	 * {"name":"sex","type":"int"}, {"name":"age","type":"int"},
	 * {"name":"info","type":"varchar(500)"} ] }
	 * 
	 * @param oldSchema
	 * @return
	 */

	public static String getSparkSchema(String oldSchema) {

		Schema schema = JSON.parseObject(oldSchema, Schema.class);

		String dbType = schema.getDb_type();

		String dbVersion = schema.getDb_version();

		String db_name = schema.getDb_name();

		String table_name = schema.getTable_name();

		List<ColumInfo> lst = schema.getSchema();

		String sparkCreateaSql = getSparkSql(dbType, dbVersion, db_name, table_name, lst);

		return sparkCreateaSql;
	}

	public static String getSparkSql(String dbType, String dbVersion, String db_name, String table_name, List<ColumInfo> list) {

		Map<String, String> map = DataTypeFactory.getEnum(dbType);
		
		StringBuffer create_sql = new StringBuffer(" create table " + db_name + "_" + table_name + " (");

		for (ColumInfo columInfo : list) {

			create_sql.append(columInfo.getName() + " " + getSparkSqlType(columInfo.getType(), map) + ",");
			
		}
		
		String sql =  create_sql.toString();
		
		sql = sql.substring(0, sql.lastIndexOf(","));
		
		return sql + ")";

	}

	public static String getSparkSqlType(String type , Map<String, String> map) {
		
		if(!type.contains("(")){
			return map.get(type.toLowerCase()) == null ? type : type.toLowerCase();
		}
		
		String temp = type.substring(0 , type.indexOf("("));
		String sparkSqlType = map.get(temp.toLowerCase());
		
		if(null == sparkSqlType){
			return baseType;
		}
		
		temp = type.substring(type.indexOf("(") , type.length());
		
		return sparkSqlType+temp;
	}
	
	
}

package com.zktx.platform.util.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zktx.platform.enm.DataBaseEnum;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;
import com.zktx.platform.util.spring.BeanFactory;

public class JdbcUtil {
	
	@SuppressWarnings("resource")
	public static void main(String[] args) throws SQLException {

		new ClassPathXmlApplicationContext(new String[] { "classpath:springmvc.xml" });
		
		ImportTableService importTableService = (ImportTableService) BeanFactory.getBean("importTableService");
		
		List<ImportTablesWithBLOBs> list =importTableService.findBySource(0);
		
		for (ImportTablesWithBLOBs importTables : list) {
			
			// 获取连接的信息
			String conc_str = importTables.getSrc_db_connection();
			
			// 用户名
			String user = importTables.getSrc_db_user();
			
			// 密码
			String pwd = importTables.getSrc_db_password();
			
			// 数据库类型
			String db_tye = importTables.getSrc_db_type();
			
			// 用工具包连接，注意不同的数据库需要不同的工具包
			
			// conc_str = "jdbc:mysql://192.168.1.50:3306/xjrb?useUnicode=true&characterEncoding=UTF-8";
			
			Connection connection = getConnection(db_tye, conc_str, user, pwd);
			
			String sql = "describe ACT_EVT_LOG";
			
			PreparedStatement p = connection.prepareStatement(sql);
			
			ResultSet rs = p.executeQuery();
			
			while (rs.next()) {
				
				System.out.println(rs.getString("Field") + "-->" + rs.getString("Type") + "-->" + rs.getString("Null")  + "-->" + rs.getString("Key") + "-->" + rs.getString("Default") + "-->" + rs.getString("Extra"));
				
			}
		}
		
	}
	
	
	// show databases
	
	// show tables
	
	// 获取某张表的schema
	
	
	public static Connection getConnection(String db_tye , String conc_str , String user , String pwd){
		
		String driverClass = "";
		
		if(DataBaseEnum.mysql.name().equals(db_tye.toLowerCase())){
			driverClass = "com.mysql.jdbc.Driver";
		}
		
		Connection connection = null;
		
		try {
			Class.forName(driverClass);
			connection = DriverManager.getConnection(conc_str, user, pwd);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return connection;
	}

}

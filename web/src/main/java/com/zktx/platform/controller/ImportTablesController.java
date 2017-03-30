package com.zktx.platform.controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;

@Controller
@RequestMapping("/importTables")
public class ImportTablesController {

	@Autowired
	ImportTableService tableService;
	//条件查询
	@RequestMapping("/query.do")
	public String findByPagination(HttpServletRequest request,HttpServletResponse response ,ImportTablesPo bloBs){
		try {
			String fromRowIdstr =request.getParameter("fromRowId");
			String numstr =request.getParameter("num");
			System.out.println("fromRowIdstr:"+fromRowIdstr+",num:"+numstr+"，bloBs.table_type:"+bloBs.getTable_type());
			List<ImportTablesWithBLOBs> list =tableService.findByPagination(bloBs, 0, 5);
			String jsonString =JSON.toJSONString(list, true);
			System.out.println(jsonString);
			PrintWriter out =response.getWriter();
			out.write(jsonString);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "dataManage/orgTableList";
	}
	//插入
	@RequestMapping("/insert.do")
	public String insertSelective(ImportTablesWithBLOBs record){
		try {
			record.setSrc_db("test_db");
			record.setSrc_db_type("00");
			record.setSrc_table("table1");
			record.setDbname("fdd");
			Date date = new Date(System.currentTimeMillis());
			record.setCreate_time(date);
			tableService.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "result";
	}
	//更新
	@RequestMapping("/update.do")
	public String updateByPrimaryKeySelective(ImportTablesWithBLOBs record){
		try {
			tableService.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	//删除
	@RequestMapping("/delete.do")
	public String deleteByPrimaryKey(Integer id){
		try {
			tableService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
	return "result";	
	}
}

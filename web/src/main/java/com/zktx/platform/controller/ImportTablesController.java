package com.zktx.platform.controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public @ResponseBody String findByPagination(HttpServletResponse response, ImportTablesPo tablesPo,  ModelMap map){
		try {
			System.out.println("dddd:"+tablesPo.getTable_type()+","+tablesPo.getFromRowId()+","+tablesPo.getPerNum());
			int count =tableService.findCountByParms(tablesPo);
			List<ImportTablesWithBLOBs> list =tableService.findByPagination(tablesPo);
			map.put("countRows", count);
			map.put("list", list);
			String jsonString =JSON.toJSONString(map);
			PrintWriter out =response.getWriter();
			System.out.println(jsonString);
			out.write(jsonString);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return null;
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

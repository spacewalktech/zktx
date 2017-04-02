package com.zktx.platform.controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
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
	public @ResponseBody Map<String, Object> findByPagination(ImportTablesPo tablesPo){
		try {
			System.out.println("dddd:"+tablesPo.getTable_type()+","+tablesPo.getFromRowId()+","+tablesPo.getPerNum());
			int count =tableService.findCountByParms(tablesPo);
			List<ImportTablesWithBLOBs> list =tableService.findByPagination(tablesPo);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("countRows", count);
			map.put("list", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	@RequestMapping("toAddPage")
	public String toAddPage(){
		return "dataManage/add";
	}
	//插入
	@RequestMapping("/insert.do")
	public @ResponseBody String insertSelective(ImportTablesWithBLOBs record){
		try {
			Date date = new Date(System.currentTimeMillis());
			record.setCreate_time(date);
			int row = tableService.insertSelective(record);
			System.out.println("row:"+row);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}
	@RequestMapping("toUpdatePage")
	public String toUpdatePage(Integer id,ModelMap map){
		System.out.println("id:"+id);
		ImportTablesWithBLOBs bloBs = tableService.selectByPrimaryKey(id);
		map.put("bloBs", bloBs);
		return "dataManage/update";
	}
	//更新
	@RequestMapping("/update.do")
	public @ResponseBody String updateByPrimaryKeySelective(ImportTablesWithBLOBs record){
		try {
			Date date = new Date(System.currentTimeMillis());
			record.setUpdate_time(date);
			tableService.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "success";
	}
	//删除
	@RequestMapping("/delete.do")
	public @ResponseBody String deleteByPrimaryKey(Integer id){
		try {
			tableService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
	return "success";	
	}
	
	
}

package com.zktx.platform.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;

@Controller
public class ImportTablesController {

	@Autowired
	ImportTableService tableService;
	//条件查询
	@RequestMapping("/queryImportTable.do")
	public String findByPagination(HttpServletRequest request,ImportTablesPo bloBs){
		bloBs.setSrc_db("test_db");
		List<ImportTablesWithBLOBs> list =tableService.findByPagination(bloBs, 0, 1);
		System.out.println(list.size()+":"+list.get(0).getDbname());
		return "";
	}
	//插入
	@RequestMapping("/insertImportTable.do")
	public String insertSelective(ImportTablesWithBLOBs record){
		record.setSrc_db("test1");
		record.setSrc_db_type("00");
		record.setSrc_table("table1");
		record.setDbname("fdd");
		Date date = new Date(System.currentTimeMillis());
		record.setCreate_time(date);
		tableService.insertSelective(record);
		return "";
	}
	//更新
	@RequestMapping("/updateImportTable.do")
	public String updateByPrimaryKeySelective(ImportTablesWithBLOBs record){
		tableService.updateByPrimaryKeySelective(record);
		return "";
	}
	//删除
	@RequestMapping("/deleteImportTable.do")
	public String deleteByPrimaryKey(Integer id){
		tableService.deleteByPrimaryKey(id);
	return "";	
	}
}

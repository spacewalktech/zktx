package com.zktx.platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.TableSchema;
import com.zktx.platform.service.importtable.TableSchemaService;

@Controller
@RequestMapping("/tableSchema")
public class TableSchemaController {

	@Autowired
	private TableSchemaService service;
	//查询schema信息
	@RequestMapping("/query.do")
	public String queryTableSchemaByTableId(Integer tableId,Integer fromRowId,Integer num){
		List<TableSchema> list =service.selectByImportTableId(1,0,5);
		String jsonString =JSON.toJSONString(list, true);
		System.out.println(jsonString);
		return "result";
	} 
}

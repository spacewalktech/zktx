package com.zktx.platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.zktx.platform.service.importtable.TableSchemaService;

@Controller
public class TableSchemaController {

	@Autowired
	private TableSchemaService service;
	//查询schema信息
	@RequestMapping("/queryTableSchemaByTableId.do")
	public String queryTableSchemaByTableId(Integer tableId){
		service.selectByImportTableId(tableId);
		return null;
	} 
}

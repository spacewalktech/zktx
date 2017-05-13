package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.TableSchemaPo;
import com.zktx.platform.log2.SystemControllerLog;
import com.zktx.platform.service.importtable.TableSchemaService;

@Controller
@RequestMapping("/tableSchema")
public class TableSchemaController {

	@Autowired
	private TableSchemaService service;

	// 查询schema信息
	@SystemControllerLog(description = "查看schema信息")
	@RequestMapping("/query")
	public @ResponseBody Map<String, Object> queryTableSchemaByTableId(Integer table_id, Integer limit, Integer offset) {
		try {
			int count = service.selectCountBytId(table_id);
			List<TableSchemaPo> list = service.selectByImportTableId(table_id, offset, limit);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/tableDdf")
	public String toTableDefine(Integer id, ModelMap map) {
		map.put("table_id", id);
		return "dataManage/tableDdfine";
	}
}

package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.TableSchema;
import com.zktx.platform.entity.tb.TableSchemaPo;
import com.zktx.platform.service.importtable.TableSchemaService;

@Controller
@RequestMapping("/tableSchema")
public class TableSchemaController {

	@Autowired
	private TableSchemaService service;
	//查询schema信息
	@RequestMapping("/query.do")
	public @ResponseBody Map<String, Object> queryTableSchemaByTableId(Integer table_id,Integer pageNum,Integer perNum){
		try {
			System.out.println("table_id:"+table_id+",perNum:"+perNum+",pageNum:"+pageNum+"------");
			int count =service.selectCountBytId(table_id);
			List<TableSchemaPo> list =service.selectByImportTableId(table_id,(pageNum-1)*perNum,perNum);
			System.out.println(count);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("countRows", count);
			map.put("list", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	} 
	
	@RequestMapping("/tableDdf.do")
	public String toTableDefine(Integer id , ModelMap map){
		System.out.println("table_id:"+id);
		map.put("table_id", id);
		return "dataManage/tableDdfine";
	}
}

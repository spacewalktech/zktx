package com.zktx.platform.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("index")
	public String index() {
		return "/index";
	}

	@RequestMapping("mrTaskList")
	public String mrTaskList() {
		return "/task/task_list";
	}

	@RequestMapping("orgTableList")
	public String orgTableList(ModelMap map) {
		map.put("table_type", 0);
		return "/dataManage/orgTableList";

	}

	@RequestMapping("perTableList")
	public String perTableList(ModelMap map) {
		map.put("table_type", 1);
		return "/dataManage/orgTableList";
	}

	@RequestMapping("orgWarnTable")
	public String orgWarnTable(ModelMap map) {
		System.out.println("orgWarnTable^");
		map.put("table_type", 0);
		return "/dataManage/table_error";
	}

	@RequestMapping("perWarnTable")
	public String perWarnTable(ModelMap map) {
		System.out.println("perWarnTable^");
		map.put("table_type", 1);
		return "/dataManage/table_error";
	}

	@RequestMapping("toQueryTable")
	public String toTueryTable(Integer table_id, ModelMap map) {
		System.out.println("table_id:" + table_id);
		map.put("table_id", table_id);
		return "/dataManage/tableQuery";
	}

}
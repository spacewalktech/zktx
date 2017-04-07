package com.zktx.platform.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/index.do")
	public String index() {
		return "/index";
	}
	@RequestMapping("/logout.do")
	public String logout() {
		return "/login";
	}
	@RequestMapping("/mrTaskList.do")
	public String mrTaskList() {
		return "/task/task_list_";
	}
	@RequestMapping("/mrTaskWait.do")
	public String waitTask(){
		return "/task/task_wait_";
	}

	@RequestMapping("/mrTaskError.do")
	public String mrTaskError(){
		return "/task/task_error_";
	}
	@RequestMapping("/orgTableList.do")
	public String orgTableList(ModelMap map) {
		map.put("table_type", 0);
		return "/dataManage/list";

	}

	@RequestMapping("perTableList")
	public String perTableList(ModelMap map) {
		map.put("table_type", 1);
		return "/dataManage/list";
	}

	@RequestMapping("orgWarnTable")
	public String orgWarnTable(ModelMap map) {
		map.put("table_type", 0);
		return "/dataManage/table_error_";
	}

	@RequestMapping("perWarnTable")
	public String perWarnTable(ModelMap map) {
		map.put("table_type", 1);
		return "/dataManage/table_error_";
	}

	@RequestMapping("toQueryTable")
	public String toTueryTable(Integer table_id, ModelMap map) {
		map.put("table_id", table_id);
		return "/dataManage/tableQuery";
	}
	
}
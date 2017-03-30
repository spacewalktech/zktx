package com.zktx.platform.controller.index;

import org.springframework.stereotype.Controller;
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
	public String orgTableList(){
		return "/dataManage/orgTableList";
				
	}
	
}

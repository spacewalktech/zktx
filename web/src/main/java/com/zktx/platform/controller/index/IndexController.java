package com.zktx.platform.controller.index;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/action")
public class IndexController {

	@RequestMapping("/loginPage")
	public String loginPage(String redirectUrl, HttpServletRequest request) {
		request.setAttribute("redirectUrl", redirectUrl);
		return "login";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().setAttribute("userName", null);
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

	@RequestMapping("/initList")
	//@RequiresPermissions("kuaidi100:view")
	public String initList() {
		System.out.println("initList------");
		return "/initList";
	}
	
	@RequestMapping("/orgTableList.do")
	public String orgTableList(ModelMap map) {
		map.put("table_type", 0);
		return "/dataManage/list";
	}

	@RequestMapping("/noRoleOr")
	public String noRoleOr() {
		return "noRoleOr";
	}

	@RequestMapping("/test")
	public String testpage() {

		return "test";
	}

}
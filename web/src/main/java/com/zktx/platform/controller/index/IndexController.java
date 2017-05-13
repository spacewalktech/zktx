package com.zktx.platform.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/action")
public class IndexController {

	@RequestMapping("/index")
	public String index() {
		return "index";
	}

	@RequestMapping("/initList")
	public String initList() {
		System.out.println("initList------");
		return "/initList";
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
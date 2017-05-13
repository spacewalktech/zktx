package com.zktx.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.log2.SystemControllerLog;

@Controller
@RequestMapping("/sysSet")
public class SystemManagerController {

	@SystemControllerLog(description = "进入系统设置页面")
	@RequestMapping("/index")
	public String sysSet() {
		System.out.println("sysSet------");
		return "/sysSet";
	}
}

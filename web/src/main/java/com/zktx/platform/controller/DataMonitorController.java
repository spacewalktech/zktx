package com.zktx.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dataMonitor")
public class DataMonitorController {

	@RequestMapping("/getData")
	public String getData() {

		return "dataMonitor/showDate";
	}

}

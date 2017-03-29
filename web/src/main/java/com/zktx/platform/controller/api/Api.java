package com.zktx.platform.controller.api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("api")
public class Api {
	
	@RequestMapping("getDatabases")
	public String getDatabases() {
		return "";
	}

}


package com.zktx.platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zktx.platform.service.importtable.StageService;

@Controller
@RequestMapping("test")
public class TestController {
	
	@Autowired
	private StageService stageService;

	@ResponseBody
	public String test() {
		return "this is test !";
	}
}

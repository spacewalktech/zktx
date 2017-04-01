package com.zktx.platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Stage;
import com.zktx.platform.service.importtable.StageService;

@Controller
@RequestMapping("test")
public class TestController {
	
	@Autowired
	private StageService stageService;

	@ResponseBody
	public String test() {
		
		List<Stage> list =stageService.queryStageDerByTableType(0,0,3);
		System.out.println(list+":");
		return "this is test !";
		
	}

}

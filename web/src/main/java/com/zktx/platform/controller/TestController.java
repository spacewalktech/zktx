package com.zktx.platform.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Service;
import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.entity.tb.Stage;
import com.zktx.platform.service.importtable.ImportTableService;
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

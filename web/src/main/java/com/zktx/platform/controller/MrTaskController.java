package com.zktx.platform.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.service.importtable.MrTaskService;

@Controller
@RequestMapping("/mrTask")
public class MrTaskController {

	@Autowired
	MrTaskService mrTaskService;
	//分页查询
	@RequestMapping("/query.do")
	public String findByPagination(Integer fromRowId, Integer num){
		
		List<MrTaskWithBLOBs> list =mrTaskService.findByPagination(0, 1);
		String jsonString =JSON.toJSONString(list, true);
		System.out.println(jsonString);
		return "result";
	}
	//待运行任务列表
	@RequestMapping("/findTaskToRun.do")
	public String findToRun(Integer fromRowId, Integer num){
		List<MrTaskWithBLOBs> list = mrTaskService.findByToRun(0, 2);
		String jsonString =JSON.toJSONString(list, true);
		System.out.println(jsonString);
		return "result";
	}
	
}

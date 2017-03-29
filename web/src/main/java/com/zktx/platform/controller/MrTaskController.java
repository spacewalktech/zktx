package com.zktx.platform.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.service.importtable.MrTaskService;

@Controller
public class MrTaskController {

	@Autowired
	MrTaskService mrTaskService;
	//分页查询
	@RequestMapping("/queryMrTask.do")
	public String findByPagination(Integer fromRowId, Integer num){
		List<MrTaskWithBLOBs> lists =mrTaskService.findByPagination(fromRowId, num);
		System.out.println(lists.size());
		return null;
	}
	//待运行任务列表
	@RequestMapping("/findTaskToRun.do")
	public String findToRun(Integer fromRowId, Integer num){
		List<MrTaskWithBLOBs> lists = mrTaskService.findByToRun(fromRowId, num);
		return null;
	}
	
}

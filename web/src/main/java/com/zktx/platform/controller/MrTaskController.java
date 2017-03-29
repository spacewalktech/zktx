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
		try {
			List<MrTaskWithBLOBs> list =mrTaskService.findByPagination(0, 5);
			String jsonString =JSON.toJSONString(list, true);
			System.out.println(jsonString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "result";
	}
	//待运行任务列表
	@RequestMapping("/findTaskToRun.do")
	public String findToRun(Integer fromRowId, Integer num){
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByToRun(0, 2);
			String jsonString =JSON.toJSONString(list, true);
			System.out.println(jsonString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	@RequestMapping("/deleteByid")
	public	String deleteByPrimaryKey(Integer id){
		try {
			System.out.println("id:"+id);
			mrTaskService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	@RequestMapping("/insertSelective.do")
	public String insertSelective(MrTaskWithBLOBs record){
		try {
			record.setName("12");
			record.setInformation("dsfdsfdsfsdfds");
			record.setType(true);
			mrTaskService.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	@RequestMapping("/update.do")
	public String updateByPrimaryKeySelective(MrTaskWithBLOBs record){
		try {
			record.setId(1);
			record.setName("hy");
			mrTaskService.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	//任务预警
	@RequestMapping("/findByProper.do")
	public String findByProper(){
		try {
			List<MrTaskWithBLOBs> list  = mrTaskService.findByProper(0, 5);
			String jString =JSON.toJSONString(list, true);
			System.out.println(jString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	@RequestMapping("/taskAction.do")
	public String taskAction(Integer id){
		try {
			mrTaskService.taskAction(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
}

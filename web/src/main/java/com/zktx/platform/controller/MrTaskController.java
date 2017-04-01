package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.service.importtable.MrTaskService;

/**
 * 任务管理
 * 
 * 
 * @author LZF
 *
 */
@Controller
@RequestMapping("/mrTask")
public class MrTaskController {

	@Autowired
	MrTaskService mrTaskService;

	@RequestMapping("addPage")
	public String addPage() {
		return "task/add";
	}

	@RequestMapping("updatePage")
	public String updatePage(Integer id, HttpServletRequest request) {
		MrTaskWithBLOBs task = mrTaskService.findById(id);
		request.setAttribute("task", task);
		return "task/update";
	}

	// 分页查询
	@RequestMapping("/query.do")
	@ResponseBody
	public Map<String, Object> findByPagination(String search_name, String search_type, String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end, Integer offset, Integer limit) {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByPagination(null, offset, limit, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin, search_create_time_end);
			int count = mrTaskService.findCountByPagination(null, offset, limit, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin, search_create_time_end);
			Map<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 待运行任务列表
	@RequestMapping("/findTaskToRun.do")
	@ResponseBody
	public Map<String, Object> findToRun(Integer offset, Integer limit) {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByToRun(offset, limit);
			Map<String, Object> map = new HashMap<>();
			map.put("total", 11);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteByid")
	@ResponseBody
	public boolean deleteByPrimaryKey(Integer id) {
		try {
			mrTaskService.deleteByPrimaryKey(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@RequestMapping("/insertSelective.do")
	public String insertSelective(MrTaskWithBLOBs record) {
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
	public String updateByPrimaryKeySelective(MrTaskWithBLOBs record) {
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

	// 任务预警
	@RequestMapping("/findByProper.do")
	public String findByProper() {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByProper(0, 5);
			String jString = JSON.toJSONString(list, true);
			System.out.println(jString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "result";
	}

	@RequestMapping("/taskAction.do")
	public String taskAction(Integer id) {
		try {
			mrTaskService.taskAction(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "result";
	}
}

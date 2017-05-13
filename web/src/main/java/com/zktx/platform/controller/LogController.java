package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.logInfo;
import com.zktx.platform.log2.SystemControllerLog;
import com.zktx.platform.service.log.LogService;

@Controller
@RequestMapping("/log")
public class LogController {

	@Autowired
	LogService logService;

	@SystemControllerLog(description = "进入日志系统")
	@RequestMapping("/index")
	public String logList() {
		System.out.println("logList------");
		return "/logList";
	}

	@RequestMapping("/queryList")
	@SystemControllerLog(description = "查询日志表")
	public @ResponseBody Map<String, Object> queryList(String user_name, String create_time_from, String create_time_to, Integer offset, Integer limit) {
		try {
			System.out.println(user_name + "," + create_time_from + "," + offset + "," + limit);
			int count = logService.queryCount(user_name, create_time_from, create_time_to);
			List<logInfo> list = logService.queryList(user_name, create_time_from, create_time_to, offset, limit);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}

package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Stage;
import com.zktx.platform.log2.SystemControllerLog;
import com.zktx.platform.service.importtable.StageService;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/stage")
public class StageController {

	@Autowired
	private StageService stageService;

	// 查看预警表
	@SystemControllerLog(description = "进入预警列表")
	@RequestMapping("index")
	public String orgWarnTable(ModelMap map) {
		map.put("table_type", 0);
		return "/dataManage/table_error_";
	}

	// 表预警
	@SystemControllerLog(description = "查看预警列表信息")
	@RequestMapping("/queryStageOri")
	public @ResponseBody Map<String, Object> queryByTableType(Integer table_type, Integer offset, Integer limit) {
		try {
			int count = stageService.queryCountByTableType(table_type);
			List<Stage> list = stageService.queryStageByTableType(table_type, offset, limit);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 查看历史表
	// @SystemControllerLog(description = "查看历史表")
	@RequestMapping("/toHistoryInfo")
	public String toHistoryInfo() {
		return "/dataManage/querHistoryInfo";
	}

	@SystemControllerLog(description = "导入轨迹表")
	@RequestMapping("/querHistoryInfo")
	public @ResponseBody Map<String, Object> querHistoryInfo(Integer limit, Integer offset) {
		try {
			int count = stageService.queryCount();
			List<Stage> list = stageService.queryStageList(offset, limit);
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

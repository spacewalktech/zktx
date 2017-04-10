package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zktx.platform.entity.tb.Stage;
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
	//表预警
	@RequestMapping("/queryStageOri.do")
	public @ResponseBody Map<String, Object>  queryByTableType(Integer table_type,Integer offset,Integer limit){
		try {
			int count =stageService.queryCountByTableType(table_type);
			List<Stage> list =stageService.queryStageByTableType(table_type,offset,limit);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@RequestMapping("/queryTable.do")
	public @ResponseBody Map<String, Object> queryByTableId(Integer table_id,Integer limit,Integer offset){
		try {
			int count = stageService.queryCountByTableId(table_id);
			List<Stage> list = stageService.queryStageByTableId(table_id, offset, limit);
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}

package com.zktx.platform.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
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
			System.out.println("tableType:"+table_type+','+offset+","+limit);
			int count =stageService.queryCountByTableType(table_type);
			System.out.println(count);
			List<Stage> list =stageService.queryStageByTableType(table_type,offset,limit);
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println(list.toArray().toString()+":"+list.size());
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
			System.out.println("table_id:"+table_id+",limit:"+limit+",offset:"+offset);
			int count = stageService.queryCountByTableId(table_id);
			List<Stage> list = stageService.queryStageByTableId(table_id, offset, limit);
			Map<String, Object> map =new HashMap<String, Object>();
			System.out.println(count);
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}

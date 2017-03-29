package com.zktx.platform.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	//导入表预警
	@RequestMapping("/queryStageOri.do")
	public String queryByTableType(Integer tableType,Integer fromRowId,Integer num){
		try {
			List<Stage> list =stageService.queryStageOriByTableType(0,0,5);
			String jsString =JSON.toJSONString(list, true);
			System.out.println(jsString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	//派生表预警
	@RequestMapping("/queryStageDer.do")
	public String queryInfoByParams(Integer tableType,Integer fromRowId,Integer num){
		try {
			List<Stage> list  =stageService.queryStageDerByTableType(1,0,5);
			String jsString =JSON.toJSONString(list, true);
			System.out.println(jsString);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return "result";
	}
	
	
}

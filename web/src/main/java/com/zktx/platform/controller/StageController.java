package com.zktx.platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.service.importtable.StageService;

/**
 * @author Administrator
 *
 */
@Controller
public class StageController {

	@Autowired
	private StageService stageService;
	//导入表预警
	@RequestMapping("/queryStageOri.do")
	public String queryByTableType(int tableType){
		stageService.queryStageOriByTableType(tableType);
		return "";
	}
	//派生表预警
	@RequestMapping("/queryStageDer.do")
	public String queryInfoByParams(Integer tableType){
		stageService.queryStageDerByTableType(tableType);
		return "";
	}
	
}

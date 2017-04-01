package com.zktx.platform.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
	//表预警
	@RequestMapping("/queryStageOri.do")
	public String queryByTableType(HttpServletResponse response, Integer table_type,Integer fromRowId,Integer num){
		try {
			System.out.println("tableType:"+table_type);
			List<Stage> list =stageService.queryStageByTableType(table_type,0,10);
			String jsString =JSON.toJSONString(list, true);
			System.out.println(jsString);
			PrintWriter out =response.getWriter();
			System.out.println(jsString);
			out.write(jsString);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
		return null;
	}
	@RequestMapping("/queryTable.do")
	public String queryByTableId(HttpServletResponse response, Integer table_id,Integer pageNum,Integer perNum){
		try {
			System.out.println("table_id:"+table_id+",perNum:"+perNum+",pageNum:"+pageNum);
			List<Stage> list = stageService.queryStageByTableId(table_id, 0, 10);
			String jsString =JSON.toJSONString(list, true);
			System.out.println(jsString);
			PrintWriter out =response.getWriter();
			System.out.println(jsString);
			out.write(jsString);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
}

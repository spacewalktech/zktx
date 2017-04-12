package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.HealthImg;
import com.zktx.platform.service.importtable.HealthImgService;

@Controller
@RequestMapping("/healthImg")
public class HealthImgController {

	@Autowired
	HealthImgService service;
	
	@RequestMapping("/queryList.do")
	public @ResponseBody Map<String, Object> queryList(Integer offset,Integer limit){
		try {
			int count =service.queryCount();
			List<HealthImg> list = service.queryList(offset, limit);
			System.out.println(list.size());
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

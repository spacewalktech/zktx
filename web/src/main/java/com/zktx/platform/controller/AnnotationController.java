package com.zktx.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Annotation;
import com.zktx.platform.service.importtable.AnnotationService;

@Controller
@RequestMapping("/annotation")
public class AnnotationController {

	@Autowired
	AnnotationService service;
	
	@RequestMapping("/queryList.do")
	public @ResponseBody Map<String, Object> queryList(Integer offset,Integer limit){
		try {
			int count =service.queryCount();
			List<Annotation> list =service.queryList(offset, limit);
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

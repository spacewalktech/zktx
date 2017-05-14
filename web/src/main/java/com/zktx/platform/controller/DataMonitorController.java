package com.zktx.platform.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.zktx.platform.util.url.UrlUtil;

@Controller
@RequestMapping("/dataMonitor")
public class DataMonitorController {

	@RequestMapping("/getData")
	public String getData(HttpServletRequest request) {
		try {
			String result = UrlUtil.doPost("http://hadoop01:9200/_cluster/state/nodes,master_node", null);
			JSONObject jsonObject = JSONObject.parseObject(result);
			jsonObject = (JSONObject)jsonObject.get("nodes");
			Set<String> set = jsonObject.keySet();
			request.setAttribute("size", set.size());
			request.setAttribute("keys", StringUtils.join(set, ","));
			List<JSONObject> list = new ArrayList<>();
			for (String str : set) {
				JSONObject obj = (JSONObject) jsonObject.get(str);
				obj.put("id", str);
				list.add(obj);
			}
			request.setAttribute("nodesInfo", list);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return "dataMonitor/showDate";
	}

}

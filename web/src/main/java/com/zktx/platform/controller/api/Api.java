package com.zktx.platform.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mysql.fabric.xmlrpc.base.Array;
import com.zktx.platform.entity.tb.User;
import com.zktx.platform.service.user.UserService;

@Controller
@RequestMapping("api")
public class Api {

	@Autowired
	private UserService userService;

	@RequestMapping("getDatabases")
	public String getDatabases() {
		return "";
	}

	@RequestMapping("validateToken")
	@ResponseBody
	public String validateToken(String token, String sysType) {
		User user = userService.findByToken(token);
		if (null == user) {
			return getJosn(1000, null, 15, "token not exist", new int[] { 50, 30 }).toJSONString();
		}
		return getJosn(200, user, 15, "success", new int[] { 50, 30 }).toJSONString();
	}

	public static JSONObject getJosn(Integer code, User user, Integer authority, String msg, int[] confidence_weights) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("code", code);
		jsonObject.put("msg", msg);
		jsonObject.put("user_info", user == null ? "" : user);
		jsonObject.put("authority", authority);
		jsonObject.put("confidence_weights", confidence_weights);
		return jsonObject;
	}

}

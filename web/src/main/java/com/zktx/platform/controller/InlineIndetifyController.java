package com.zktx.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zktx.platform.log2.SystemControllerLog;

@Controller
@RequestMapping("/inlineIdentify")
public class InlineIndetifyController {

	@SystemControllerLog(description = "进入非结构化在线识别页面")
	@RequestMapping("/index")
	public String inlineIdentify() {
		System.out.println("inlineIdentify------");
		return "/unDataManage/inlineIdentify";
	}
}

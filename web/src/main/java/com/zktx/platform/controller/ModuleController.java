package com.zktx.platform.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.Module;
import com.zktx.platform.service.user.ModuleService;
import com.zktx.platform.service.user.PermissionService;

@Controller
@RequestMapping("/module")
public class ModuleController {

	@Autowired
	ModuleService moduleService;
	@Autowired
	PermissionService permissionService;

	@RequestMapping("/index")
	public String toModule() {

		return "userManager/module";
	}

	@RequestMapping("/getTree")
	public @ResponseBody List<Module> getTree() {
		System.out.println("=============getTree");
		List<Module> modules = moduleService.getTree();
		return modules;
	}

	@RequestMapping("/queryListBypId")
	public @ResponseBody List<Module> queryListBypId(Integer pid) {
		List<Module> modules = moduleService.queryListByPId(pid);
		return modules;
	}

	@RequestMapping("/treeModule")
	public String treeModule() {
		return "userManager/treeModule";
	}

	@RequestMapping("/toAddModule")
	public String toAddPage(Integer parent_id, ModelMap map) {
		String grade = moduleService.queryMaxGradeByPid(parent_id);
		map.put("parent_id", parent_id);
		map.put("grade", grade);
		return "userManager/addModule";
	}

	// 添加菜单
	@RequestMapping("/addModule")
	public @ResponseBody String insertSelective(Module module) {
		try {
			moduleService.insertSelective(module);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 查看模块标识的数量，确保sn的唯一性
	@RequestMapping("/queryCountbySn")
	public @ResponseBody Integer queryCountbySn(String sn, Integer id) {
		try {
			int count = moduleService.queryCountbySn(sn, id);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	// 转向修改页面
	@RequestMapping("/toUpdateModule")
	public String queryModuleById(Integer id, ModelMap map) {
		try {
			Module module = moduleService.queryModuleById(id);
			map.put("module", module);
			return "userManager/updateModule";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 更新数据
	@RequestMapping("/updateModule")
	public @ResponseBody String updateModule(Module module) {
		try {
			moduleService.updateByPrimaryKeySelective(module);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	@RequestMapping("/deleteModuleByIds")
	public @ResponseBody String deleteModuleByIds(String ids) {
		try {
			List<Integer> list = new ArrayList<Integer>();
			if (null != ids && ids.length() > 0) {
				String[] idsStr = ids.split(",");
				for (String id : idsStr) {
					list.add(Integer.parseInt(id));
				}
			}
			if (list.size() > 0) {
				moduleService.deleteByIds(list);
			}
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}
}

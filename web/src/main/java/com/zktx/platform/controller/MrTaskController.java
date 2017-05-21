package com.zktx.platform.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.entity.tb.ImportTables;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.entity.tb.TaskHistoryWithBLOBs;
import com.zktx.platform.entity.tb.TaskQueue;
import com.zktx.platform.service.importtable.MrTaskService;
import com.zktx.platform.service.importtable.TaskHistoryService;

/**
 * 任务管理
 * 
 * 
 * @author LZF
 *
 */
@Controller
@RequestMapping("/mrTask")
public class MrTaskController {

	@Autowired
	MrTaskService mrTaskService;

	@Autowired
	TaskHistoryService taskHistory;

	@RequestMapping("/index")
	public String toTaskPage() {
		return "task/task_list";
	}

	@RequestMapping("/addPage")
	public String addPage(HttpServletRequest request) {
		// 查询出数据库与表
		List<String> list = mrTaskService.findDistintDBType();
		request.setAttribute("srcdbs", list);
		return "task/add";
	}

	@RequestMapping("/updatePage")
	public String updatePage(Integer id, HttpServletRequest request) {
		MrTaskWithBLOBs task = mrTaskService.findById(id);
		List<String> list = mrTaskService.findDistintDBType();
		List<ImportTables> tables = mrTaskService.findAllTables();
		request.setAttribute("task", task);
		String StrList = JSON.toJSONString(list, true);
		String tableList = JSON.toJSONString(tables, true);
		request.setAttribute("srcdbs", StrList);
		request.setAttribute("tableList", tableList);
		return "task/update";
	}

	@RequestMapping("/getTableByDB")
	@ResponseBody
	public List<ImportTablesWithBLOBs> getTableByDB(String dbname) {
		List<ImportTablesWithBLOBs> list = mrTaskService.findTableByDBName(dbname);
		return list;
	}

	// 分页查询
	@RequestMapping("/query")
	@ResponseBody
	public Map<String, Object> findByPagination(String search_name, String search_type, String search_triggle_tables, String search_active,
			String search_create_time_begin, String search_create_time_end, Integer offset, Integer limit) {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByPagination(null, offset, limit, search_name, search_type, search_triggle_tables, search_active,
					search_create_time_begin, search_create_time_end);
			int count = mrTaskService.findCountByPagination(null, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin,
					search_create_time_end);
			Map<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 待运行任务列表
	@RequestMapping("/findTaskToRun")
	@ResponseBody
	public Map<String, Object> findToRun(Integer offset, Integer limit) {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByToRun(offset, limit);
			int count = mrTaskService.findCountByToRun(offset, limit);
			Map<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteByid")
	@ResponseBody
	public boolean deleteByPrimaryKey(Integer id) {
		try {
			mrTaskService.deleteByPrimaryKey(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@RequestMapping("/deleteQueueByid")
	@ResponseBody
	public boolean deleteQueueByid(Integer id) {
		try {
			mrTaskService.deleteQueueByid(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 文件上传
	@RequestMapping("/upload")
	@ResponseBody
	public String upload(MultipartFile file, HttpServletRequest request) {
		try {
			String org_name = file.getOriginalFilename();
			// String upload_name = UUID.randomUUID().toString().replace("-",
			// "");
			// String suffix = org_name.substring(org_name.lastIndexOf("."),
			// org_name.length());
			// String uploadFileName = org_name + suffix;
			String path = request.getSession().getServletContext().getRealPath("upload");
			String file_name = org_name + "_" + new Date().getTime();
			File targetFile = new File(path, file_name);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			file.transferTo(targetFile);
			return path + "/" + file_name;
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 转向代码展示页面
	@RequestMapping("/dowloadfile")
	public String dowLoadFile(String uri, ModelMap map) {
		System.out.println("uri:" + uri);
		String context = mrTaskService.dowLoadFile(uri);
		map.put("context", context);
		map.put("uri", uri);
		return "task/showfileCode";
	}

	@RequestMapping("/updateFileContext")
	public @ResponseBody String updateFileContext(String fileContext, String uri) {
		try {
			System.out.println("uri:" + uri + ",,,fileContext:" + fileContext);
			mrTaskService.updateFile(uri, fileContext);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	@RequestMapping("/getFileContent")
	public @ResponseBody String getFileContent() {
		String content = "我是一只小强";
		return content;
	}

	@RequestMapping("/insertSelective")
	@ResponseBody
	public String insertSelective(MrTaskWithBLOBs record) {
		// long starttime = System.currentTimeMillis();
		try {
			record.setCreate_time(new Date());
			record.setUpdate_time(new Date());
			mrTaskService.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		// System.out.println("插入时间：" + (System.currentTimeMillis() -
		// starttime));
		return "success";
	}

	@RequestMapping("/update")
	@ResponseBody
	public String updateByPrimaryKeySelective(MrTaskWithBLOBs record) {
		try {
			record.setUpdate_time(new Date());
			mrTaskService.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "result";
	}

	// 任务预警
	@RequestMapping("/findByProper")
	@ResponseBody
	public Map<String, Object> findByProper(Integer offset, Integer limit) {
		try {
			List<MrTaskWithBLOBs> list = mrTaskService.findByProper(offset, limit);
			int count = mrTaskService.findCountByPagination(0, null, null, null, null, null, null);
			Map<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/taskAction")
	public String taskAction(Integer id) {
		try {
			mrTaskService.taskAction(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "result";
	}

	// 转向任务监控
	@RequestMapping("/taskMonitor")
	public String taskMonitor() {
		return "task/taskMonitor";
	}

	// 任务监控列表
	@RequestMapping("/queryTask")
	public @ResponseBody Map<String, Object> queryTask(Integer offset, Integer limit, Integer type) {
		try {
			if (type == 4) { // 未运行
				List<TaskQueue> list = mrTaskService.queryTask(offset, limit);
				int count = mrTaskService.queryCountRunnngTask();
				Map<String, Object> map = new HashMap<>();
				map.put("total", count);
				map.put("rows", list);
				return map;
			} else if (type == 0) { // 成功
				List<TaskHistoryWithBLOBs> list = taskHistory.queryByPage(offset, limit, 1);
				int count = taskHistory.queryCountByPage(offset, limit, 1);
				Map<String, Object> map = new HashMap<>();
				map.put("total", count);
				map.put("rows", list);
				return map;
			} else if (type == 1) { // 运行中
				List<TaskHistoryWithBLOBs> list = taskHistory.queryByPage(offset, limit, 0);
				int count = taskHistory.queryCountByPage(offset, limit, 0);
				Map<String, Object> map = new HashMap<>();
				map.put("total", count);
				map.put("rows", list);
				return map;
			} else if (type == 2) { // 运行失败
				List<TaskHistoryWithBLOBs> list = taskHistory.queryByPage(offset, limit, 2);
				int count = taskHistory.queryCountByPage(offset, limit, 2);
				Map<String, Object> map = new HashMap<>();
				map.put("total", count);
				map.put("rows", list);
				return map;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	@RequestMapping("/taskViewViz")
	public @ResponseBody List<MrTaskWithBLOBs> querytaskViewViz() {
		List<MrTaskWithBLOBs> bloBs = mrTaskService.taskViewViz();
		return bloBs;

	}

}
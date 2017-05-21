package com.zktx.platform.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.log2.SystemControllerLog;
import com.zktx.platform.service.importtable.ImportTableService;

@Controller
@RequestMapping("/dataManage")
public class ImportTablesController {
	@Autowired
	ImportTableService tableService;

	// @Autowired
	// private StageService stageService;

	private static Log log = LogFactory.getLog(ImportTablesController.class);

	@RequestMapping("/list")
	public String orgTableList() {
		return "/dataManage/list";

	}

	// 条件查询
	@SystemControllerLog(description = "查询导入表")
	@RequestMapping("/query")
	public @ResponseBody Map<String, Object> findByPagination(ImportTablesPo tablesPo) {
		log.info("导入表查询————————");
		try {
			int count = tableService.findCountByParms(tablesPo);
			List<ImportTablesWithBLOBs> list = tableService.findByPagination(tablesPo);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", count);
			map.put("rows", list);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@SystemControllerLog(description = "进入新建表页面")
	@RequestMapping("/toAddPage")
	public String toAddPage(ModelMap map) {
		List<String> src_dbList = tableService.findDistintSRCDBType();
		List<String> dbList = tableService.findDistintDBType();
		map.put("src_dbList", src_dbList);
		map.put("dbList", dbList);
		return "dataManage/add";
	}

	// 插入
	@SystemControllerLog(description = "新建表")
	@RequestMapping("/insert")
	public @ResponseBody String insertSelective(ImportTablesWithBLOBs record) {
		try {
			record.setCreate_time(new Date());
			record.setUpdate_time(new Date());
			tableService.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	@SystemControllerLog(description = "进入修改页面")
	@RequestMapping("/toUpdatePage")
	public String toUpdatePage(Integer id, ModelMap map) {
		ImportTablesWithBLOBs bloBs = tableService.selectByPrimaryKey(id);
		List<String> src_dbList = tableService.findDistintSRCDBType();
		List<String> dbList = tableService.findDistintDBType();
		map.put("dbList", dbList);
		map.put("src_dbList", src_dbList);
		map.put("bloBs", bloBs);
		return "dataManage/update";
	}

	// 更新
	@SystemControllerLog(description = "修改表")
	@RequestMapping("/update")
	public @ResponseBody String updateByPrimaryKeySelective(ImportTablesWithBLOBs record) {
		try {

			record.setUpdate_time(new Date());
			tableService.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "success";
	}

	// 删除
	@SystemControllerLog(description = "删除表")
	@RequestMapping("/delete")
	public @ResponseBody String deleteByPrimaryKey(Integer id) {
		try {
			tableService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "success";
	}

	@RequestMapping("/queryCountTable")
	public @ResponseBody Integer queryCountTable(Integer id, String table_name, String dbname) {
		try {
			if (null == table_name || "".equals(table_name.trim()) || null == dbname || "".equals(dbname.trim())) {
				return -1;
			} else {
				int count = tableService.queryCountTable(id, table_name, dbname);
				return count;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

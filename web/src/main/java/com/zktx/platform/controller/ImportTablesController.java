package com.zktx.platform.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zktx.platform.entity.tb.ImportTablesPo;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.service.importtable.ImportTableService;

@Controller
@RequestMapping("/importTables")
public class ImportTablesController {

	@Autowired
	ImportTableService tableService;

	// 条件查询
	@RequestMapping("/query.do")
	public @ResponseBody Map<String, Object> findByPagination(ImportTablesPo tablesPo) {
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

	@RequestMapping("/toAddPage.do")
	public String toAddPage(Integer table_type, ModelMap map) {
		List<String> src_dbList = tableService.findDistintSRCDBType();
		List<String> dbList = tableService.findDistintDBType();
		map.put("table_type", table_type);
		map.put("src_dbList", src_dbList);
		map.put("dbList", dbList);
		return "dataManage/add";
	}

	// 插入
	@RequestMapping("/insert.do")
	public @ResponseBody String insertSelective(ImportTablesWithBLOBs record) {
		try {
			record.setCreate_time(new Date());
			tableService.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	@RequestMapping("/toUpdatePage.do")
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
	@RequestMapping("/update.do")
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
	@RequestMapping("/delete.do")
	public @ResponseBody String deleteByPrimaryKey(Integer id) {
		try {
			tableService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "success";
	}

	@RequestMapping("/queryCountTable.do")
	public @ResponseBody Integer queryCountTable(Integer id, String src_table, String src_db, String table_name, String dbname) {
		try {
			if (null == table_name || "".equals(table_name.trim()) || null == dbname || "".equals(dbname.trim()) || null == src_table
					|| "".equals(src_table.trim()) || null == src_db || "".equals(src_db.trim())) {
				return -1;
			} else {
				int count = tableService.queryCountTable(id, src_table, src_db, table_name, dbname);
				return count;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}

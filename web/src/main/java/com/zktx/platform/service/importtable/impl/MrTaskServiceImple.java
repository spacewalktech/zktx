package com.zktx.platform.service.importtable.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import com.zktx.platform.dao.tb.MrTaskMapper;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.service.importtable.MrTaskService;

@Service("mrTaskService")
public class MrTaskServiceImple implements MrTaskService {

	@Autowired
	private MrTaskMapper mapper;

	@Override
	public List<MrTaskWithBLOBs> findByPagination(Integer latest_running_status, Integer offset, Integer limit, String search_name, String search_type, String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end) {
		if (null != search_name) {
			search_name = "%" + search_name + "%";
		}
		return mapper.findByPagination(null, offset, limit, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin, search_create_time_end);
	}

	@Override
	public int findCountByPagination(Integer latest_running_status, String search_name, String search_type, String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end) {
		if (null != search_name) {
			search_name = "%" + search_name + "%";
		}
		return mapper.findCountByPagination(latest_running_status, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin, search_create_time_end);
	}

	@Override
	public int insertSelective(MrTaskWithBLOBs record) {
		mapper.insertSelective(record);
		return 0;
	}

	// 查询未被执行的任务
	@Override
	public List<MrTaskWithBLOBs> findByToRun(Integer offset, Integer limit) {
		return mapper.findByHasProcessed(0, offset, limit);
	}

	@Override
	public void deleteByPrimaryKey(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}

	@Override
	public void updateByPrimaryKeySelective(MrTaskWithBLOBs record) {
		mapper.updateByPrimaryKeySelective(record);

	}

	// 任务预警
	@Override
	public List<MrTaskWithBLOBs> findByProper(Integer fromRowId, Integer num) {
		return mapper.findByPagination(0, fromRowId, num, null, null, null, null, null, null);
	}

	@Override
	public void taskAction(Integer id) {
		mapper.taskAction(id);
	}

	@Override
	public int findCount() {
		return mapper.findCount();
	}

	@Override
	public MrTaskWithBLOBs findById(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public int findCountByToRun(Integer offset, Integer limit) {
		return mapper.findCountByToRun(0, offset, limit);
	}

	@Override
	public void deleteQueueByid(Integer id) {
		mapper.deleteQueueByid(id);
	}

	@Override
	public int findCountByProper() {
		return mapper.findCountByProper();
	}

	@Override
	public List<String> findDistintDBType() {
		return mapper.findDistintDBType();
	}

	@Override
	public List<ImportTablesWithBLOBs> findTableByDBName(String dbname) {
		return mapper.findTableByDBName(dbname);
	}

}

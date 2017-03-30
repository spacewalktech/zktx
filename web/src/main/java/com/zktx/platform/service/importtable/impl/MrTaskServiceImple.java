package com.zktx.platform.service.importtable.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import com.zktx.platform.dao.tb.MrTaskMapper;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.service.importtable.MrTaskService;
@Service("mrTaskService")
public class MrTaskServiceImple implements MrTaskService {

	@Autowired
	private	MrTaskMapper mapper;
	@Override
	public List<MrTaskWithBLOBs> findByPagination(Integer fromRowId, Integer num) {
		return mapper.findByPagination(null,fromRowId, num);
	}
	@Override
	public int insertSelective(MrTaskWithBLOBs record) {
		mapper.insertSelective(record);
		return 0;
	}
	//查询未被执行的任务
	@Override
	public List<MrTaskWithBLOBs> findByToRun(Integer fromRowId, Integer num) {
		return mapper.findByHasProcessed(0, fromRowId, num);
	}
	
	@Override
	public void deleteByPrimaryKey(Integer id) {
		mapper.deleteByPrimaryKey(id);
	}
	@Override
	public void updateByPrimaryKeySelective(MrTaskWithBLOBs record) {
		mapper.updateByPrimaryKeySelective(record);
		
	}
	//任务预警
	@Override
	public List<MrTaskWithBLOBs> findByProper(Integer fromRowId, Integer num) {
		
		return mapper.findByPagination(0, fromRowId, num);
	}
	@Override
	public void taskAction(Integer id) {
		mapper.taskAction(id);
		
	}
	
	

	
}

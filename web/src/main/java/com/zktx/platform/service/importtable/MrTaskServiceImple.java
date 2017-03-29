package com.zktx.platform.service.importtable;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import com.zktx.platform.dao.tb.MrTaskMapper;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
@Service("mrTaskService")
public class MrTaskServiceImple implements MrTaskService {

	@Autowired
	private	MrTaskMapper mapper;
	@Override
	public List<MrTaskWithBLOBs> findByPagination(Integer fromRowId, Integer num) {
		return mapper.findByPagination(fromRowId, num);
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

}

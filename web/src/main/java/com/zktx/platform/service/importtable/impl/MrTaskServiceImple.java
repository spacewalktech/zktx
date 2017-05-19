package com.zktx.platform.service.importtable.impl;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.zktx.platform.dao.tb.ImportTablesMapper;
import com.zktx.platform.dao.tb.MrTaskMapper;
import com.zktx.platform.dao.tb.TaskQueueMapper;
import com.zktx.platform.entity.tb.ImportTables;
import com.zktx.platform.entity.tb.ImportTablesWithBLOBs;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;
import com.zktx.platform.entity.tb.TaskQueue;
import com.zktx.platform.service.importtable.MrTaskService;

@Service("mrTaskService")
public class MrTaskServiceImple implements MrTaskService {

	@Autowired
	private MrTaskMapper mapper;

	@Autowired
	private ImportTablesMapper importTableMapper;

	@Autowired
	TaskQueueMapper taskQueueMapper;

	@Override
	public List<MrTaskWithBLOBs> findByPagination(Integer latest_running_status, Integer offset, Integer limit, String search_name, String search_type,
			String search_triggle_tables, String search_active, String search_create_time_begin, String search_create_time_end) {
		if (null != search_name) {
			search_name = "%" + search_name + "%";
		}
		return mapper.findByPagination(null, offset, limit, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin,
				search_create_time_end);
	}

	@Override
	public int findCountByPagination(Integer latest_running_status, String search_name, String search_type, String search_triggle_tables, String search_active,
			String search_create_time_begin, String search_create_time_end) {
		if (null != search_name) {
			search_name = "%" + search_name + "%";
		}
		return mapper.findCountByPagination(latest_running_status, search_name, search_type, search_triggle_tables, search_active, search_create_time_begin,
				search_create_time_end);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int insertSelective(MrTaskWithBLOBs record) {
		try {
			String triggle_tables = record.getTriggle_tables();
			if (null != triggle_tables && triggle_tables.length() > 0) {
				List<Integer> list = new ArrayList<Integer>();
				List<Object> maps = JSON.parseArray(triggle_tables);
				for (Object obj : maps) {
					Map<String, Integer> map = (Map<String, Integer>) obj;
					Set<String> set = map.keySet();
					for (String str : set) {
						list.add(Integer.parseInt(str));
					}
				}
				List<Map<String, Object>> input_tablesList = importTableMapper.queryByIds(list);
				String input_tables = JSON.toJSONString(input_tablesList);
				record.setInput_tables(input_tables);
			}
			int rowid = mapper.insertSelective(record);
			if (rowid > 0) {
				String srcfile = record.getBin_file_uri();
				int id = record.getId();
				String dstfile = "";
				dstfile = fileToHdfs(srcfile, id);
				MrTaskWithBLOBs bloBs = new MrTaskWithBLOBs();
				bloBs.setId(id);
				bloBs.setBin_file_uri(dstfile);
				mapper.updateByPrimaryKeySelective(bloBs);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	private String fileToHdfs(String srcfile, Integer id) throws Exception {
		long starttime = System.currentTimeMillis();
		String suffix = srcfile.substring(srcfile.lastIndexOf("."), srcfile.length());

		String targetdir = "hdfs://hadoop01:9000/spacewalk/hdfs/task_file";
		String filename = "/" + id + "/" + System.currentTimeMillis() + suffix;
		String target = targetdir + filename;
		InputStream in = new BufferedInputStream(new FileInputStream(new File(srcfile)));
		Configuration conf = new Configuration();
		FileSystem fs = FileSystem.get(URI.create(targetdir), conf);
		if (!fs.exists(new Path(targetdir + "/" + id))) {
			fs.mkdirs(new Path(targetdir + "/" + id));
		}
		FSDataOutputStream out = fs.create(new Path(target));
		IOUtils.copyBytes(in, out, 4096, true);
		// fs.copyFromLocalFile(new Path(srcfile), new Path(target));
		System.out.println("文件上传：" + (System.currentTimeMillis() - starttime));
		return target;
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
		String triggle_tables = record.getTriggle_tables();
		if (null != triggle_tables && triggle_tables.length() > 0) {
			List<Integer> list = new ArrayList<Integer>();
			List<Object> maps = JSON.parseArray(triggle_tables);
			for (Object obj : maps) {
				Map<String, Integer> map = (Map<String, Integer>) obj;
				Set<String> set = map.keySet();
				for (String str : set) {
					list.add(Integer.parseInt(str));
				}
			}
			List<Map<String, Object>> input_tablesList = importTableMapper.queryByIds(list);
			String input_tables = JSON.toJSONString(input_tablesList);
			record.setInput_tables(input_tables);
		}
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

	@Override
	public List<ImportTables> findAllTables() {
		return mapper.findAllTables();
	}

	@Override
	public List<TaskQueue> queryRunningTaskList(Integer offset, Integer limit) {

		return taskQueueMapper.queryRunningTaskList(offset, limit);
	}

	@Override
	public int queryCountRunnngTask() {
		return taskQueueMapper.queryCountRunnngTask();
	}

	@Override
	public List<MrTaskWithBLOBs> taskViewViz() {

		return mapper.findAllMrTaskWithBLOBs();
	}

	@Override
	public String dowLoadFile(String uri) {
		StringBuffer sb = new StringBuffer();
		InputStream inStream = null;
		Configuration conf = new Configuration();
		try {
			FileSystem fs = FileSystem.get(URI.create(uri), conf);
			Path path = new Path(URI.create(uri));
			if (fs.exists(path)) {
				inStream = fs.open(path);
				BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
				String context = null;
				while ((context = reader.readLine()) != null) {
					sb.append(context);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sb.toString();
	}
}

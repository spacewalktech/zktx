package com.zktx.platform.service.user.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zktx.platform.dao.tb.ModuleMapper;
import com.zktx.platform.dao.tb.PermissionMapper;
import com.zktx.platform.entity.tb.Module;
import com.zktx.platform.entity.tb.Permission;
import com.zktx.platform.service.user.ModuleService;

@Service("moduleService")
public class ModuleServiceImpl implements ModuleService {

	@Autowired
	ModuleMapper moduleMapper;

	@Autowired
	PermissionMapper permissionMapper;

	@Override
	public List<Module> getTree() {
		List<Module> list = moduleMapper.queryList();
		setPermissions(list);
		List<Module> modules = makeTree(list);
		return modules;
	}

	private void setPermissions(List<Module> list) {
		if (null != list && list.size() > 0) {
			for (Module e : list) {
				List<Permission> permissions = permissionMapper.queryListByModuleId(e.getId());
				e.setPermissions(permissions);
			}
		}
	}

	private List<Module> makeTree(List<Module> list) {
		List<Module> parent = new ArrayList<Module>();
		// get parentId = null;
		for (Module e : list) {
			if (e.getParent_Module() == null) {
				e.setChildren(new ArrayList<Module>(0));
				parent.add(e);
			}
		}
		// 删除parentId = null;
		list.removeAll(parent);

		makeChildren(parent, list);

		return parent;
	}

	private void makeChildren(List<Module> parent, List<Module> children) {
		if (children.isEmpty()) {
			return;
		}

		List<Module> tmp = new ArrayList<Module>();
		for (Module c1 : parent) {
			for (Module c2 : children) {
				c2.setChildren(new ArrayList<Module>(0));
				if (c1.getId().equals(c2.getParent_Module().getId())) {
					c1.getChildren().add(c2);
					tmp.add(c2);
				}
			}
		}

		children.removeAll(tmp);

		makeChildren(tmp, children);
	}

	@Override
	public List<Module> queryListByPId(Integer pid) {

		return moduleMapper.queryListByPId(pid);
	}

	@Override
	public void insertSelective(Module module) {
		int id = moduleMapper.insertSelective(module);
		if (id > 0) {
			List<Permission> permissions = module.getPermissions();
			if (null != permissions && permissions.size() > 0) {
				for (Permission permission : permissions) {
					permission.setModule_id(module.getId());
				}
				permissionMapper.insertBatch(permissions);
			}
		}
	}

	@Override
	public Integer queryCountbySn(String sn, Integer id) {

		return moduleMapper.queryCountbySn(sn, id);
	}

	@Override
	public Module queryModuleById(Integer id) {
		return moduleMapper.queryModuleById(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Module module) {
		return moduleMapper.updateByPrimaryKeySelective(module);
	}

	@Override
	public void deleteByIds(List<Integer> ids) {

		moduleMapper.deleteByIds(ids);

	}

	@Override
	public String queryMaxGradeByPid(Integer pid) {
		String grade = "01";
		int num = 0;
		List<Module> modules = moduleMapper.queryListByPId(pid);
		if (null != modules && modules.size() > 0) {
			for (Module module : modules) {
				String gradeval = module.getGrade();
				grade = gradeval.substring(0, gradeval.length() - 2);
				int numval = Integer.parseInt(gradeval.substring(gradeval.length() - 2));
				num = Math.max(num, numval);
			}
			String gradeAfte = String.valueOf(num + 1);
			grade += gradeAfte.length() > 1 ? gradeAfte : ("0" + gradeAfte);
		} else {
			Module module = moduleMapper.queryModuleById(pid);
			grade = module.getGrade() + "01";
		}
		return grade;
	}

}

package com.zktx.platform.entity.tb;

public class TaskHistoryWithBLOBs extends TaskHistory {

	private String table_stage_info;

	private String result;

	private String name;

	private String type;

	public String getTable_stage_info() {
		return table_stage_info;
	}

	public void setTable_stage_info(String table_stage_info) {
		this.table_stage_info = table_stage_info;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		if (this.type == null && type.equals("0")) {
			this.type = "Spark 任务";
		} else if (this.type == null && type.equals("1")) {
			this.type = "Hive 任务";
		} else if (this.type == null && type.equals("2")) {
			this.type = "时间触发Spark";
		} else if (this.type == null && type.equals("2")) {
			this.type = "时间触发Hive";
		} else {
			this.type = type;
		}
	}

}
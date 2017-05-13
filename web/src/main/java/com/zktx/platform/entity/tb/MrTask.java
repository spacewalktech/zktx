package com.zktx.platform.entity.tb;

import java.util.Date;

public class MrTask {

	private Integer id;

	private Integer queue_id;

	private String name;

	private String information;

	private String bin_file_uri;

	private Boolean type;

	private String export_dir_uri;

	private Integer priority;

	private Boolean active;

	private String task_schedule;

	private Date latest_running_time;

	private Boolean latest_running_status;

	private Boolean flag = false;

	private Date create_time;

	private Date update_time;

	private String task_type;

	private Integer option_mode;

	private Integer has_derivative_table;

	private Integer create_userid;

	private User create_user;

	public Integer getQueue_id() {
		return queue_id;
	}

	public void setQueue_id(Integer queue_id) {
		this.queue_id = queue_id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information;
	}

	public String getBin_file_uri() {
		return bin_file_uri;
	}

	public void setBin_file_uri(String bin_file_uri) {
		this.bin_file_uri = bin_file_uri;
	}

	public Boolean getType() {
		return type;
	}

	public void setType(Boolean type) {
		this.type = type;
	}

	public String getExport_dir_uri() {
		return export_dir_uri;
	}

	public void setExport_dir_uri(String export_dir_uri) {
		this.export_dir_uri = export_dir_uri;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getTask_schedule() {
		return task_schedule;
	}

	public void setTask_schedule(String task_schedule) {
		this.task_schedule = task_schedule;
	}

	public Date getLatest_running_time() {
		return latest_running_time;
	}

	public void setLatest_running_time(Date latest_running_time) {
		this.latest_running_time = latest_running_time;
	}

	public Boolean getLatest_running_status() {
		return latest_running_status;
	}

	public void setLatest_running_status(Boolean latest_running_status) {
		this.latest_running_status = latest_running_status;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getTask_type() {
		return task_type;
	}

	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}

	public Integer getOption_mode() {
		return option_mode;
	}

	public void setOption_mode(Integer option_mode) {
		this.option_mode = option_mode;
	}

	public Integer getCreate_userid() {
		return create_userid;
	}

	public void setCreate_userid(Integer create_userid) {
		this.create_userid = create_userid;
	}

	public Integer getHas_derivative_table() {
		return has_derivative_table;
	}

	public void setHas_derivative_table(Integer has_derivative_table) {
		this.has_derivative_table = has_derivative_table;
	}

	public User getCreate_user() {
		return create_user;
	}

	public void setCreate_user(User create_user) {
		this.create_user = create_user;
	}

}
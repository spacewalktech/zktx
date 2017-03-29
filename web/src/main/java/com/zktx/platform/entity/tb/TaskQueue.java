package com.zktx.platform.entity.tb;

import java.util.Date;

public class TaskQueue {
    private Integer id;

    private Integer mr_task_id;

    private Date create_time;

    private Date update_time;

    private Date begin_time;

    private Date end_time;

    private String table_stage_info;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMr_task_id() {
        return mr_task_id;
    }

    public void setMr_task_id(Integer mr_task_id) {
        this.mr_task_id = mr_task_id;
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

    public Date getBegin_time() {
        return begin_time;
    }

    public void setBegin_time(Date begin_time) {
        this.begin_time = begin_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public String getTable_stage_info() {
        return table_stage_info;
    }

    public void setTable_stage_info(String table_stage_info) {
        this.table_stage_info = table_stage_info;
    }
}
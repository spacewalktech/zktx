package com.zktx.platform.entity.tb;

import java.util.Date;

public class Stage {
    private Integer id;

    private Integer import_table_id;

    private Integer stage_id;

    private Boolean import_type;

    private Integer inserted_num;

    private Integer updated_num;

    private Integer deleted_num;

    private Integer record_num;

    private Boolean status;

    private Integer process_status;

    private Date create_time;

    private Date update_time;

    private Date begin_time;

    private Date end_time;

    private String fail_info;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getImport_table_id() {
        return import_table_id;
    }

    public void setImport_table_id(Integer import_table_id) {
        this.import_table_id = import_table_id;
    }

    public Integer getStage_id() {
        return stage_id;
    }

    public void setStage_id(Integer stage_id) {
        this.stage_id = stage_id;
    }

    public Boolean getImport_type() {
        return import_type;
    }

    public void setImport_type(Boolean import_type) {
        this.import_type = import_type;
    }

    public Integer getInserted_num() {
        return inserted_num;
    }

    public void setInserted_num(Integer inserted_num) {
        this.inserted_num = inserted_num;
    }

    public Integer getUpdated_num() {
        return updated_num;
    }

    public void setUpdated_num(Integer updated_num) {
        this.updated_num = updated_num;
    }

    public Integer getDeleted_num() {
        return deleted_num;
    }

    public void setDeleted_num(Integer deleted_num) {
        this.deleted_num = deleted_num;
    }

    public Integer getRecord_num() {
        return record_num;
    }

    public void setRecord_num(Integer record_num) {
        this.record_num = record_num;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Integer getProcess_status() {
        return process_status;
    }

    public void setProcess_status(Integer process_status) {
        this.process_status = process_status;
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

    public String getFail_info() {
        return fail_info;
    }

    public void setFail_info(String fail_info) {
        this.fail_info = fail_info;
    }
}
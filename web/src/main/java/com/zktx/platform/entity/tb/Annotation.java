package com.zktx.platform.entity.tb;

import java.util.Date;

public class Annotation {
	
	private Integer id;
	
	private String guid;
	
	private String res_json;
	
	private String image_uri;
	
	private Integer upload_id;
	
	private Integer editor_id;
	
	private Integer auditor_id;
	
	private Date create_time;
	
	private Date edited_time;
	
	private Date audit_time;
	
	private Integer status;
	
	private Boolean edit_lock;
	
	private Boolean type;
	
	private Boolean flag;
	
	private String rotate;
	
	private String edit_note;
	
	private String audit_note;
	
	private String source;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public String getRes_json() {
		return res_json;
	}

	public void setRes_json(String res_json) {
		this.res_json = res_json;
	}

	public String getImage_uri() {
		return image_uri;
	}

	public void setImage_uri(String image_uri) {
		this.image_uri = image_uri;
	}

	public Integer getUpload_id() {
		return upload_id;
	}

	public void setUpload_id(Integer upload_id) {
		this.upload_id = upload_id;
	}

	public Integer getEditor_id() {
		return editor_id;
	}

	public void setEditor_id(Integer editor_id) {
		this.editor_id = editor_id;
	}

	public Integer getAuditor_id() {
		return auditor_id;
	}

	public void setAuditor_id(Integer auditor_id) {
		this.auditor_id = auditor_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Date getEdited_time() {
		return edited_time;
	}

	public void setEdited_time(Date edited_time) {
		this.edited_time = edited_time;
	}

	public Date getAudit_time() {
		return audit_time;
	}

	public void setAudit_time(Date audit_time) {
		this.audit_time = audit_time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Boolean getEdit_lock() {
		return edit_lock;
	}

	public void setEdit_lock(Boolean edit_lock) {
		this.edit_lock = edit_lock;
	}

	public Boolean getType() {
		return type;
	}

	public void setType(Boolean type) {
		this.type = type;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public String getRotate() {
		return rotate;
	}

	public void setRotate(String rotate) {
		this.rotate = rotate;
	}

	public String getEdit_note() {
		return edit_note;
	}

	public void setEdit_note(String edit_note) {
		this.edit_note = edit_note;
	}

	public String getAudit_note() {
		return audit_note;
	}

	public void setAudit_note(String audit_note) {
		this.audit_note = audit_note;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}
	
}

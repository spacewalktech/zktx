package com.zktx.platform.entity.tb;

import java.util.Date;

public class ImportTablesPo extends ImportTablesWithBLOBs {
	private Date create_time_from;
	
	private Date create_time_to;

	public Date getCreate_time_from() {
		return create_time_from;
	}

	public void setCreate_time_from(Date create_time_from) {
		this.create_time_from = create_time_from;
	}

	public Date getCreate_time_to() {
		return create_time_to;
	}

	public void setCreate_time_to(Date create_time_to) {
		this.create_time_to = create_time_to;
	}
	
}

package com.zktx.platform.entity.tb;

public class ImportTablesWithBLOBs extends ImportTables{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String es_index_schema;

    private String process_info;

    public String getEs_index_schema() {
        return es_index_schema;
    }

    public void setEs_index_schema(String es_index_schema) {
        this.es_index_schema = es_index_schema;
    }

    public String getProcess_info() {
        return process_info;
    }

    public void setProcess_info(String process_info) {
        this.process_info = process_info;
    }
}
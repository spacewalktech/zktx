package com.zktx.platform.entity;

/**
 * 
 * name type primary unique
 * 
 * 
 * @author LZF
 *
 */
public class ColumInfo {

	// 列名
	private String name;
	// 列类型
	private String type;
	// 是否是主键 1 是 0 不是
	private Integer primary;
	// 是否是唯一约束键 1 是 0 不是
	private Integer unique;

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
		this.type = type;
	}

	public Integer getPrimary() {
		return primary;
	}

	public void setPrimary(Integer primary) {
		this.primary = primary;
	}

	public Integer getUnique() {
		return unique;
	}

	public void setUnique(Integer unique) {
		this.unique = unique;
	}

}

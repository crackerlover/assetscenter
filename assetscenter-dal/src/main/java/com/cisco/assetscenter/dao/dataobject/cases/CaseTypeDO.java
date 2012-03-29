package com.cisco.assetscenter.dao.dataobject.cases;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class CaseTypeDO extends BaseDO {

	private static final long serialVersionUID = 8234026256540741592L;

	private String name;
	private String description;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}

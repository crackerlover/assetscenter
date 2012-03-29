package com.cisco.assetscenter.dao.dataobject.asset;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class AssetTypeDO extends BaseDO {

	private static final long serialVersionUID = -1353405406715593254L;

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

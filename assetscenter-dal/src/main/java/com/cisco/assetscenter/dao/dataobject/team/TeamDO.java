package com.cisco.assetscenter.dao.dataobject.team;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class TeamDO extends BaseDO {

	private static final long serialVersionUID = -5105643229454493156L;
	private String name;
	private String[] managers;
	private String description;
	private String gmtCreate;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description == null ? "" : description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getGmtCreate() {
		return gmtCreate == null ? "" : gmtCreate;
	}
	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public String[] getManagers() {
		return managers;
	}
	public void setManagers(String[] managers) {
		this.managers = managers;
	}

}

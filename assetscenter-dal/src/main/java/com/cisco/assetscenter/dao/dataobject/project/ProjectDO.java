package com.cisco.assetscenter.dao.dataobject.project;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class ProjectDO extends BaseDO {

	private static final long serialVersionUID = -5702486766718395385L;

	private String name;
	private String[] managers;
	private String description;
	private String startTime;
	private String endTime;
	private String gmtCreate;
	public String getName() {
		return name == null ? "" : name;
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
	public String getStartTime() {
		return startTime == null ? "" : startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime == null ? "" : endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
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

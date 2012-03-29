package com.cisco.assetscenter.dao.dataobject.project;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class ProjectApplyRecordDO extends BaseDO {

	private static final long serialVersionUID = -3314623336515881257L;
	
	private String applicant;
	private String project;
	private int role;
	private int status;
	private String applyTime;
	public String getApplicant() {
		return applicant == null ? "" : applicant;
	}
	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}
	public String getProject() {
		return project == null ? "" : project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getApplyTime() {
		return applyTime == null ? "" : applyTime;
	}
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

}

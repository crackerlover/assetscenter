package com.cisco.assetscenter.dao.dataobject.team;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class TeamApplyRecordDO extends BaseDO {

	private static final long serialVersionUID = -3020697239296744564L;
	
	private String applicant;
	private String team;
	private int role;
	private int status;
	private String applyTime;
	public String getApplicant() {
		return applicant == null ? "" : applicant;
	}
	public void setApplicant(String applicant) {
		this.applicant = applicant;
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
	public String getTeam() {
		return team == null ? "" : team;
	}
	public void setTeam(String team) {
		this.team = team;
	}

}

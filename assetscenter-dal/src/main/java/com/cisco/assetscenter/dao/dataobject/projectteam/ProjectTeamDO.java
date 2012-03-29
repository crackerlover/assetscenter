package com.cisco.assetscenter.dao.dataobject.projectteam;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class ProjectTeamDO extends BaseDO {

	private static final long serialVersionUID = -5827925726629650743L;
	
	private int projectId;
	private int teamId;
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}


}

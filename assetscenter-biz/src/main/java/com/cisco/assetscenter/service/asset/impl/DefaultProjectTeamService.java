package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.ProjectTeamDAO;
import com.cisco.assetscenter.dao.dataobject.projectteam.ProjectTeamDO;
import com.cisco.assetscenter.service.asset.ProjectTeamService;

public class DefaultProjectTeamService implements ProjectTeamService {

	private ProjectTeamDAO projectTeamDAO;
	@Override
	public boolean createProjectTeam(ProjectTeamDO projectTeam) {
		if(null == projectTeam) {
			return false;
		}
		return projectTeamDAO.insert(projectTeam) > 0;
	}

	@Override
	public List<ProjectTeamDO> findProjectTeamByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		return projectTeamDAO.findProjectTeamByProjectId(projectId);
	}

	@Override
	public List<ProjectTeamDO> findProjectTeamByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		return projectTeamDAO.findProjectTeamByTeamId(teamId);
	}

	public void setProjectTeamDAO(ProjectTeamDAO projectTeamDAO) {
		this.projectTeamDAO = projectTeamDAO;
	}

}

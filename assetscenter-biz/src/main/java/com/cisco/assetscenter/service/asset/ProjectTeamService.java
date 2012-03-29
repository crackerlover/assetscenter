package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.projectteam.ProjectTeamDO;

public interface ProjectTeamService {

	
	public boolean createProjectTeam(ProjectTeamDO projectTeam);
	public List<ProjectTeamDO> findProjectTeamByProjectId(int projectId);
	public List<ProjectTeamDO> findProjectTeamByTeamId(int teamId);
}

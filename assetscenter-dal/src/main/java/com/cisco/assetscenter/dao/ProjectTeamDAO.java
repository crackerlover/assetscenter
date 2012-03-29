package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.projectteam.ProjectTeamDO;

/**
 * project team database access.
 * @author shuaizha
 *
 */
public interface ProjectTeamDAO {

	/**
	 * insert a new project team.
	 * @param projectTeam
	 * @return
	 */
	public int insert(ProjectTeamDO projectTeam);
	
	/**
	 * find project team by project id.
	 * @param projectId
	 * @return
	 */
	public List<ProjectTeamDO> findProjectTeamByProjectId(int projectId);
	
	/**
	 * find project team by team id.
	 * @param teamId
	 * @return
	 */
	public List<ProjectTeamDO> findProjectTeamByTeamId(int teamId);
}

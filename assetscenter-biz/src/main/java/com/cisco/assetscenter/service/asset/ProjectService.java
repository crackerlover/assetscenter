package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;


public interface ProjectService {

	public List<ProjectDO> viewAllProjects();
	
	public int createProject(final ProjectDO project);
	
	public ProjectDO findProjectById(int id);
	
	public ProjectDO findProjectByName(String name);
	
	public List<ProjectDO> findProjectByUsername(String username);
	
	public List<ProjectDO> findProjectByTeamId(int teamId);
	
	public List<ProjectDO> loadAllProjectsByQuery(ProjectQuery query);
	
	public int getTotalNumsByQuery(ProjectQuery query);
	
	public int update(ProjectDO project);
	public int delProjectById(int id);
}

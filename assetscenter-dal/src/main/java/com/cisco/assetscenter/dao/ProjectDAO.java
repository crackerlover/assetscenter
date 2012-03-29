package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;

/**
 * project database access class.
 * @author shuaizha
 *
 */
public interface ProjectDAO {

	/**
	 * load all projects.
	 * @return
	 */
	public List<ProjectDO> loadAllProjects();
	
	/**
	 * load projects by query.
	 * @param query
	 * @return
	 */
	public List<ProjectDO> loadAllProjectsByQuery(ProjectQuery query);
	
	/**
	 * get total num by query.
	 * @param query
	 * @return
	 */
	public int getTotalNumsByQuery(ProjectQuery query);
	
	/**
	 * insert a new project.
	 * @param project
	 * @return
	 */
	public int insert(final ProjectDO project);
	
	/**
	 * update the protect.
	 * @param project
	 * @return
	 */
	public int update(final ProjectDO project);
	
	/**
	 * delete project by id.
	 * @param id
	 * @return
	 */
	public int delProjectById(int id);
	
	/**
	 * find project by id.
	 * @param id
	 * @return
	 */
	public ProjectDO findProjectById(int id);
	
	/**
	 * find project by name.
	 * @param name
	 * @return
	 */
	public ProjectDO findProjectByName(String name);

	/**
	 * find proejct by username.
	 * @param username
	 * @return
	 */
	public List<ProjectDO> findProjectByUsername(String username);
	
	/**
	 * find project by team id.
	 * @param teamId
	 * @return
	 */
	public List<ProjectDO> findProjectByTeamId(int teamId);
}

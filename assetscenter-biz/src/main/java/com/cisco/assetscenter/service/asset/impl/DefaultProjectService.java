package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.ProjectDAO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;
import com.cisco.assetscenter.service.asset.ProjectService;

public class DefaultProjectService implements ProjectService {

	private ProjectDAO cacheProjectDAO;
	@Override
	public List<ProjectDO> viewAllProjects() {
		return cacheProjectDAO.loadAllProjects();
	}

	@Override
	public int createProject(ProjectDO project) {
		if(null == project) {
			return 0;
		}
		return cacheProjectDAO.insert(project);
	}

	@Override
	public ProjectDO findProjectById(int id) {
		if(0 == id) {
			return null;
		}
		return cacheProjectDAO.findProjectById(id);
	}

	@Override
	public ProjectDO findProjectByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		return cacheProjectDAO.findProjectByName(name);
	}

	public void setCacheProjectDAO(ProjectDAO cacheProjectDAO) {
		this.cacheProjectDAO = cacheProjectDAO;
	}

	@Override
	public List<ProjectDO> findProjectByUsername(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		return cacheProjectDAO.findProjectByUsername(username);
	}

	@Override
	public List<ProjectDO> findProjectByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		return cacheProjectDAO.findProjectByTeamId(teamId);
	}

	@Override
	public List<ProjectDO> loadAllProjectsByQuery(ProjectQuery query) {
		if(null == query) {
			return null;
		}
		return cacheProjectDAO.loadAllProjectsByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(ProjectQuery query) {
		if(null == query) {
			return 0;
		}
		return cacheProjectDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int update(ProjectDO project) {
		if(null == project) {
			return 0;
		}
		return cacheProjectDAO.update(project);
	}

	@Override
	public int delProjectById(int id) {
		if(0 == id) {
			return 0;
		}
		return cacheProjectDAO.delProjectById(id);
	}


}

package com.cisco.assetscenter.dao.impl.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;

import com.cisco.assetscenter.dao.ProjectDAO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;

public class CacheProjectDAO extends SimpleJdbcDaoSupport implements ProjectDAO {

	private Map<Integer, ProjectDO> cacheProjectIdMap;
	private Map<String, ProjectDO> cacheProjectNameMap;
	private ProjectDAO projectDAO;
	
	public CacheProjectDAO(ProjectDAO projectDAO) {
		this.projectDAO = projectDAO;
		initCache();
	}
	
	private synchronized void initCache() {
		if(null == cacheProjectIdMap) {
			cacheProjectIdMap = new HashMap<Integer, ProjectDO>();
		}
		if(null == cacheProjectNameMap) {
			cacheProjectNameMap = new HashMap<String, ProjectDO>();
		}
		List<ProjectDO> list = projectDAO.loadAllProjects();
		if(null != list && list.size() > 0) {
			for(ProjectDO project : list) {
				cacheProjectIdMap.put(project.getId(), project);
				cacheProjectNameMap.put(project.getName(), project);
			}
		}
	}
	
	public synchronized void cleanCache() {
		if(null != cacheProjectIdMap) {
			cacheProjectIdMap.clear();
			cacheProjectIdMap = null;
		}
		if(null != cacheProjectNameMap) {
			cacheProjectNameMap.clear();
			cacheProjectNameMap = null;
		}
		initCache();
	}
	@Override
	public List<ProjectDO> loadAllProjects() {
		if(null == cacheProjectIdMap) {
			initCache();
		}
		List<ProjectDO> list = new ArrayList<ProjectDO>();
		for(Integer index : cacheProjectIdMap.keySet()) {
			list.add(cacheProjectIdMap.get(index));
		}
		return list;
	}

	@Override
	public int insert(ProjectDO project) {
		if(null == project) {
			return 0;
		}
		ProjectDO projectDO = cacheProjectNameMap.get(project.getName());
		if(null == projectDO) {
			int id = projectDAO.insert(project);
			project.setId(id);
			cacheProjectIdMap.put(id, project);
			cacheProjectNameMap.put(project.getName(), project);
			return id;
		}
		return projectDO.getId();
	}

	@Override
	public ProjectDO findProjectById(int id) {
		if(0 == id) {
			return null;
		}
		ProjectDO project = cacheProjectIdMap.get(id);
		if(null == project) {
			project = projectDAO.findProjectById(id);
		}
		return project;
	}

	@Override
	public ProjectDO findProjectByName(String name) {
		if(StringUtils.isEmpty(name)){
			return null;
		}
		ProjectDO project = cacheProjectNameMap.get(name);
		if(null == project) {
			project = projectDAO.findProjectByName(name);
		}
		return project;
	}

	@Override
	public List<ProjectDO> findProjectByUsername(String username) {
		return projectDAO.findProjectByUsername(username);
	}

	@Override
	public List<ProjectDO> findProjectByTeamId(int teamId) {
		return projectDAO.findProjectByTeamId(teamId);
	}

	@Override
	public List<ProjectDO> loadAllProjectsByQuery(ProjectQuery query) {
		return projectDAO.loadAllProjectsByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(ProjectQuery query) {
		return projectDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int update(ProjectDO project) {
		cacheProjectIdMap.put(project.getId(), project);
		cacheProjectNameMap.put(project.getName(), project);
		return projectDAO.update(project);
	}

	@Override
	public int delProjectById(int id) {
		ProjectDO project = cacheProjectIdMap.get(id);
		cacheProjectIdMap.remove(id);
		cacheProjectNameMap.remove(project.getName());
		return projectDAO.delProjectById(id);
	}

}

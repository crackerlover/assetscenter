package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.ProjectApplyRecordDAO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectApplyRecordQuery;
import com.cisco.assetscenter.service.asset.ProjectApplyRecordService;

public class DefaultProjectApplyRecordService implements
		ProjectApplyRecordService {

	private ProjectApplyRecordDAO projectApplyRecordDAO;
	@Override
	public int insert(ProjectApplyRecordDO projectApplyRecord) {
		if(null == projectApplyRecord) {
			return 0;
		}
		return projectApplyRecordDAO.insert(projectApplyRecord);
	}

	@Override
	public boolean updateStatus(int status, int id) {
		if(0 == id) {
			return false;
		}
		return projectApplyRecordDAO.updateStatus(status, id) > 0;
	}

	@Override
	public List<ProjectApplyRecordDO> loadProjectApplyRecordByQuery(
			ProjectApplyRecordQuery query) {
		if(null == query) {
			return null;
		}
		return projectApplyRecordDAO.loadProjectApplyRecordByQuery(query);
	}

	@Override
	public int getProjectApplyRecordTotalNums(ProjectApplyRecordQuery query) {
		if(null == query) {
			return 0;
		}
		return projectApplyRecordDAO.getProjectApplyRecordTotalNums(query);
	}

	public void setProjectApplyRecordDAO(ProjectApplyRecordDAO projectApplyRecordDAO) {
		this.projectApplyRecordDAO = projectApplyRecordDAO;
	}

	@Override
	public ProjectApplyRecordDO findProjectApplyRecordById(int id) {
		if(0 == id) {
			return null;
		}
		return projectApplyRecordDAO.findProjectApplyRecordById(id);
	}

	@Override
	public List<ProjectApplyRecordDO> findProjectApplyRecordByIdRole(int id, int role) {
		if(0 == id || 0 == role) {
			return null;
		}
		return projectApplyRecordDAO.findProjectApplyRecordByIdRole(id, role);
	}

	@Override
	public ProjectApplyRecordDO findProjectApplyRecordByIdUserRole(String project,
			String username, int role) {
		if(StringUtils.isEmpty(project) || StringUtils.isEmpty(username)) {
			return null;
		}
		return projectApplyRecordDAO.findProjectApplyRecordByIdUserRole(project, username, role);
	}

}

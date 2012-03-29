package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.ProjectAssetDAO;
import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectAssetQuery;
import com.cisco.assetscenter.service.asset.ProjectAssetService;

public class DefaultProjectAssetService implements ProjectAssetService {

	private ProjectAssetDAO projectAssetDAO;
	@Override
	public int insert(ProjectAssetDO projectAsset) {
		if(null == projectAsset) {
			return 0;
		}
		return projectAssetDAO.insert(projectAsset);
	}

	@Override
	public List<ProjectAssetDO> loadProjectAssetByQuery(ProjectAssetQuery query) {
		if(null == query) {
			return null;
		}
		return projectAssetDAO.loadProjectAssetByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(ProjectAssetQuery query) {
		if(null == query) {
			return 0;
		}
		return projectAssetDAO.getTotalNumsByQuery(query);
	}

	@Override
	public boolean updateProjectByIds(int id, int projectId) {
		if(0 == id || 0 == projectId) {
			return false;
		}
		return projectAssetDAO.updateProjectByIds(id, projectId) > 0;
	}

	@Override
	public boolean deleteProjectAssetById(int id) {
		if(id == 0) {
			return false;
		}
		return projectAssetDAO.deleteProjectAssetById(id) > 0;
	}

	public ProjectAssetDAO getProjectAssetDAO() {
		return projectAssetDAO;
	}

	public void setProjectAssetDAO(ProjectAssetDAO projectAssetDAO) {
		this.projectAssetDAO = projectAssetDAO;
	}

	@Override
	public ProjectAssetDO findProjectAssetByIds(int assetId) {
		if(0 == assetId) {
			return null;
		}
		return projectAssetDAO.findProjectAssetByIds(assetId);
	}

}

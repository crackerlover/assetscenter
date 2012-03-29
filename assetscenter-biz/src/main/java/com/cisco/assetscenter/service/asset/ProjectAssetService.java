package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectAssetQuery;

public interface ProjectAssetService {

	public int insert(ProjectAssetDO projectAsset);
	
	public List<ProjectAssetDO> loadProjectAssetByQuery(ProjectAssetQuery query);
	
	public int getTotalNumsByQuery(ProjectAssetQuery query);
	
	public boolean updateProjectByIds(int id, int projectId);
	
	public boolean deleteProjectAssetById(int id);
	
	public ProjectAssetDO findProjectAssetByIds(int assetId);
}

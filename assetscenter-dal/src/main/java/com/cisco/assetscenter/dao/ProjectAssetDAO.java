package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectAssetQuery;

/**
 * project asset database access class.
 * @author shuaizha
 *
 */
public interface ProjectAssetDAO {

	/**
	 * insert a new project asset.
	 * @param projectAsset
	 * @return
	 */
	public int insert(ProjectAssetDO projectAsset);
	
	/**
	 * load project asset by query.
	 * @param query
	 * @return
	 */
	public List<ProjectAssetDO> loadProjectAssetByQuery(ProjectAssetQuery query);
	
	/**
	 * get total nums by query.
	 * @param query
	 * @return
	 */
	public int getTotalNumsByQuery(ProjectAssetQuery query);
	
	/**
	 * update project asset by id.
	 * @param id
	 * @param projectId
	 * @return
	 */
	public int updateProjectByIds(int id, int projectId);
	
	/**
	 * delete project asset by id.
	 * @param id
	 * @return
	 */
	public int deleteProjectAssetById(int id);
	
	/**
	 * find project asset by id.
	 * @param assetId
	 * @return
	 */
	public ProjectAssetDO findProjectAssetByIds(int assetId);
}

package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamAssetQuery;
import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;

/**
 * team asset database access class.
 * @author shuaizha
 *
 */
public interface TeamAssetDAO {

	/**
	 * insert a new team asset.
	 * @param teamAsset
	 * @return
	 */
	public int insert(TeamAssetDO teamAsset);
	
	/**
	 * load team asset by query.
	 * @param query
	 * @return
	 */
	public List<TeamAssetDO> loadTeamAssetByQuery(TeamAssetQuery query);
	
	/**
	 * get total num by query.
	 * @param query
	 * @return
	 */
	public int getTotalNumsByQuery(TeamAssetQuery query);
	
	/**
	 * update team by id.
	 * @param id
	 * @param teamId
	 * @return
	 */
	public int updateTeamByIds(int id, int teamId);
	
	/**
	 * delete team asset by id.
	 * @param id
	 * @return
	 */
	public int deleteTeamAssetById(int id);
	
	/**
	 * find team asset by id.
	 * @param assetId
	 * @return
	 */
	public TeamAssetDO findTeamAssetByIds(int assetId);
}

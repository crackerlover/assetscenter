package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;

/**
 * Asset database access dao.
 * @author shuaizha
 * @date
 */
public interface AssetDAO {

	/**
	 * retrieve all the assets information.
	 * @return
	 */
	public List<AssetDO> loadAllAssets();
	
	/**
	 * get the num of total assets.
	 * @return
	 */
	public int getAssetTotalNums();
	
	/**
	 * get total num by query.
	 * @param query
	 * @return
	 */
	public int getAssetTotalNumsByQuery(AssetQuery query);
	
	/**
	 * create a new asset.
	 * @param assetDO
	 * @return
	 */
	public int insert(final AssetDO assetDO);
	
	/**
	 * query the assets.
	 * @param query
	 * @return
	 */
	public List<AssetDO> loadAssetByQuery(AssetQuery query);
	
	public List<AssetDO> loadAssetByProjectQuery(AssetQuery query);
	
	/**
	 * delete the special asset.
	 * @param id
	 * @return
	 */
	public int deleteAssetById(int id);
	
	/**
	 * update the asset
	 * @param asset
	 * @return
	 */
	public int update(AssetDO asset);
	
	public int updateStatusById(int id, int status);
	/**
	 * 
	 * @param id
	 * @return
	 */
	public AssetDO loadAssetById(int id);
	public AssetDO loadAssetBySN(String sn);
	
	public AssetDO loadAssetBySnEltms(String sn, String eltms);
	
	public int[] batchInsert(List<AssetDO> list);
	
	
	public List<AssetDO> findAssetByUserName(String username);
	public List<AssetDO> findAssetByTeamId(int teamId);
	public List<AssetDO> findAssetByProjectId(int projectId);
	
}

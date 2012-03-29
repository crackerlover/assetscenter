package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;

public interface AssetService {
	
	/**
	 * create a new asset information.
	 * @param asset
	 * @return
	 */
	public boolean createAsset(AssetDO asset);
	
	/**
	 * query the asset informations.
	 * @param query
	 * @return
	 */
	public List<AssetDO> viewAssetsByQuery(AssetQuery query);
	
	/**
	 * view the total quantity of asset.
	 * @return
	 */
	public int viewAssetTotalQuantity();
	public int viewAssetTotalQuantity(AssetQuery query);
	
	/**
	 * delete the special asset.
	 * @param id
	 * @return
	 */
	public boolean deleteAssetById(int id);
	
	public int updateStatusById(int id, int status);
	/**
	 * update the asset.
	 * @param asset
	 * @return
	 */
	public boolean updateAsset(AssetDO asset);
	
	/**
	 * view the special asset.
	 * @param id
	 * @return
	 */
	public AssetDO viewAssetById(int id);
	
	public List<AssetDO> findAssetByUserName(String username);
	public List<AssetDO> findAssetByTeamId(int teamId);
	public List<AssetDO> findAssetByProjectId(int projectId);
	
	/**
	 * return the asset to previous user.
	 * @param assetId
	 * @param userName
	 * @return
	 */
	public boolean returnAsset(int assetId, String userName);
	
	/**
	 * find the asset by sn and eltms.
	 * @param sn
	 * @param eltms
	 * @return
	 */
	public AssetDO loadAssetBySnEltms(String sn, String eltms);
	
	/**
	 * retrieve all the assets information.
	 * @return
	 */
	public List<AssetDO> loadAllAssets();
}

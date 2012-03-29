package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetTypeQuery;

public interface AssetTypeService {

	/**
	 * load all asset types.
	 * @return
	 */
	public List<AssetTypeDO> viewAllAssetTypes();
	
	public AssetTypeDO findAssetTypeById(int id);
	
	public AssetTypeDO findAssetTypeByName(String name);
	
	public  List<AssetTypeDO> loadAssetTypeByQuery(AssetTypeQuery query);
	
	public int createAssetType(AssetTypeDO assetType);

	public int getTotalNumsByQuery(AssetTypeQuery query);

	public int update(AssetTypeDO assetType);

	public int delAssetTypeById(int id);
}

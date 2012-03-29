package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetTypeQuery;

/**
 * asset type database access dao.
 * @author shuaizha
 *
 */
public interface AssetTypeDAO {

	/**
	 * load all asset types.
	 * @return
	 */
	public List<AssetTypeDO> loadAssetTypes();
	
	/**
	 * create a new asset type.
	 * @param assetTypeDO
	 * @return
	 */
	public int insert(final AssetTypeDO assetTypeDO);
	
	/**
	 * find asset type by id.
	 * @param id asset id
	 * @return
	 */
	public AssetTypeDO findAssetTypeById(int id);
	
	/**
	 * find asset type by name.
	 * @param name asset name
	 * @return
	 */
	public AssetTypeDO findAssetTypeByName(String name);

	/**
	 * find asset type by query.
	 * @param query
	 * @return
	 */
	public List<AssetTypeDO> loadAssetTypeByQuery(AssetTypeQuery query);

	/**
	 * get number of asset type by query.
	 * @param query
	 * @return
	 */
	public int getTotalNumsByQuery(AssetTypeQuery query);

	/**
	 * update asset type.
	 * @param assetType
	 * @return
	 */
	public int update(AssetTypeDO assetType);

	/**
	 * delete asset type.
	 * @param id
	 * @return
	 */
	public int delAssetTypeById(int id);
}

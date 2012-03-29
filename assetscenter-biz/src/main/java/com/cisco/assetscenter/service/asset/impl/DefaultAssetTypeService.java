/**
 * 
 */
package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetTypeQuery;
import com.cisco.assetscenter.dao.impl.cache.CacheAssetTypeDAO;
import com.cisco.assetscenter.service.asset.AssetTypeService;

/**
 * @author shuaizha
 *
 */
public class DefaultAssetTypeService implements AssetTypeService {

	private CacheAssetTypeDAO cacheAssetTypeDAO;
	@Override
	public List<AssetTypeDO> viewAllAssetTypes() {
		return cacheAssetTypeDAO.loadAssetTypes();
	}
	public void setCacheAssetTypeDAO(CacheAssetTypeDAO cacheAssetTypeDAO) {
		this.cacheAssetTypeDAO = cacheAssetTypeDAO;
	}
	@Override
	public AssetTypeDO findAssetTypeById(int id) {
		if(0 == id){
			return null;
		}
		return cacheAssetTypeDAO.findAssetTypeById(id);
	}
	@Override
	public AssetTypeDO findAssetTypeByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		return cacheAssetTypeDAO.findAssetTypeByName(name);
	}
	@Override
	public int createAssetType(AssetTypeDO assetType) {
		if(null == assetType) {
			return 0;
		}
		return cacheAssetTypeDAO.insert(assetType);
	}
	@Override
	public  List<AssetTypeDO> loadAssetTypeByQuery(AssetTypeQuery query) {
		
		if (null == query) {
			return null;
		}
		return cacheAssetTypeDAO.loadAssetTypeByQuery(query);
	}
	@Override
	public int getTotalNumsByQuery(AssetTypeQuery query) {
		if (null == query) {
			return 0;
		}
		return cacheAssetTypeDAO.getTotalNumsByQuery(query);
	}
	@Override
	public int update(AssetTypeDO assetType) {
		if(null == assetType) {
			return 0;
		}
		return cacheAssetTypeDAO.update(assetType);
		
	}
	@Override
	public int delAssetTypeById(int id) {
		if (0 == id) {
			return 0;
		}
	    return cacheAssetTypeDAO.delAssetTypeById(id);
	}

}

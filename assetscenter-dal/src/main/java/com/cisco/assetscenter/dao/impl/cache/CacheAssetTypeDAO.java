package com.cisco.assetscenter.dao.impl.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;

import com.cisco.assetscenter.dao.AssetTypeDAO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetTypeQuery;

public class CacheAssetTypeDAO extends SimpleJdbcDaoSupport implements AssetTypeDAO {

	
	private Map<Integer, AssetTypeDO> cacheAssetTypeIdMap;
	private Map<String, AssetTypeDO> cacheAssetTypeNameMap;
	private AssetTypeDAO assetTypeDAO;
	
	public CacheAssetTypeDAO(AssetTypeDAO assetTypeDAO) {
		this.assetTypeDAO = assetTypeDAO;
		initCache();
	}
	
	private synchronized void initCache() {
		if(null == cacheAssetTypeIdMap) {
			cacheAssetTypeIdMap = new HashMap<Integer, AssetTypeDO>();
		}
		if(null == cacheAssetTypeNameMap) {
			cacheAssetTypeNameMap = new HashMap<String, AssetTypeDO>();
		}
		List<AssetTypeDO> list = assetTypeDAO.loadAssetTypes();
		if(null != list && list.size() > 0) {
			for(AssetTypeDO assetTypeDO : list) {
				cacheAssetTypeIdMap.put(assetTypeDO.getId(), assetTypeDO);
				cacheAssetTypeNameMap.put(assetTypeDO.getName(), assetTypeDO);
			}
		}
	}
	
	public synchronized void cleanCache() {
		if(null != cacheAssetTypeIdMap) {
			cacheAssetTypeIdMap.clear();
			cacheAssetTypeIdMap = null;
		}
		if(null != cacheAssetTypeNameMap) {
			cacheAssetTypeNameMap.clear();
			cacheAssetTypeNameMap = null;
		}
		initCache();
	}
	@Override
	public synchronized List<AssetTypeDO> loadAssetTypes() {
		if(null == cacheAssetTypeIdMap) {
			initCache();
		}
		List<AssetTypeDO> list = new ArrayList<AssetTypeDO>();
		for(Integer index : cacheAssetTypeIdMap.keySet()) {
			list.add(cacheAssetTypeIdMap.get(index));
		}
		return list;
	}

	@Override
	public synchronized int insert(AssetTypeDO assetTypeDO) {
		if(null == assetTypeDO) {
			return 0;
		}
		AssetTypeDO assetType = cacheAssetTypeNameMap.get(assetTypeDO.getName());
		if(null == assetType) {
			int id = assetTypeDAO.insert(assetTypeDO);
			assetTypeDO.setId(id);
			cacheAssetTypeIdMap.put(id, assetTypeDO);
			cacheAssetTypeNameMap.put(assetTypeDO.getName(), assetTypeDO);
			return id;
		}
		return assetType.getId();
	}

	@Override
	public synchronized AssetTypeDO findAssetTypeById(int id) {
		if(0 == id) {
			return null;
		}
		AssetTypeDO assetTypeDO = cacheAssetTypeIdMap.get(id);
		if(null == assetTypeDO) {
			assetTypeDO = assetTypeDAO.findAssetTypeById(id);
		}
		return assetTypeDO;
	}

	@Override
	public synchronized AssetTypeDO findAssetTypeByName(String name) {
		if(StringUtils.isEmpty(name)){
			return null;
		}
		AssetTypeDO assetTypeDO = cacheAssetTypeNameMap.get(name);
		if(null == assetTypeDO) {
			assetTypeDO = assetTypeDAO.findAssetTypeByName(name);
		}
		return assetTypeDO;
	}

	public List<AssetTypeDO> loadAssetTypeByQuery(AssetTypeQuery query) {
		if (null == query) {
			return null;
		}
		return assetTypeDAO.loadAssetTypeByQuery(query);
		
	}

	public int getTotalNumsByQuery(AssetTypeQuery query) {
		if (null == query) {
			return 0;
		}
		return assetTypeDAO.getTotalNumsByQuery(query);
	}

	public int update(AssetTypeDO assetType) {
		cacheAssetTypeIdMap.put(assetType.getId(), assetType);
		cacheAssetTypeNameMap.put(assetType.getName(), assetType);
		return assetTypeDAO.update(assetType);
	}

	public int delAssetTypeById(int id) {
		AssetTypeDO caseType = cacheAssetTypeIdMap.get(id);
		cacheAssetTypeIdMap.remove(id);
		cacheAssetTypeNameMap.remove(caseType.getName());
		
		return assetTypeDAO.delAssetTypeById(id);
	}

}

package com.cisco.assetscenter.dao.impl.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;

import com.cisco.assetscenter.dao.CaseTypeDAO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;


public class CacheCaseTypeDAO extends SimpleJdbcDaoSupport implements CaseTypeDAO {

	private Map<Integer, CaseTypeDO> cacheCaseTypeIdMap;
	private Map<String, CaseTypeDO> cacheCaseTypeNameMap;
	private CaseTypeDAO caseTypeDAO;
	
	public CacheCaseTypeDAO(CaseTypeDAO caseTypeDAO) {
		this.caseTypeDAO = caseTypeDAO;
		initCache();
	}
	
	private synchronized void initCache() {
		if(null == cacheCaseTypeIdMap) {
			cacheCaseTypeIdMap = new HashMap<Integer, CaseTypeDO>();
		}
		if(null == cacheCaseTypeNameMap) {
			cacheCaseTypeNameMap = new HashMap<String, CaseTypeDO>();
		}
		List<CaseTypeDO> list = caseTypeDAO.loadCaseTypes();
		if(null != list && list.size() > 0) {
			for(CaseTypeDO caseType : list) {
				cacheCaseTypeIdMap.put(caseType.getId(), caseType);
				cacheCaseTypeNameMap.put(caseType.getName(), caseType);
			}
		}
	}
	
	public synchronized void cleanCache() {
		if(null != cacheCaseTypeIdMap) {
			cacheCaseTypeIdMap.clear();
			cacheCaseTypeIdMap = null;
		}
		if(null != cacheCaseTypeNameMap) {
			cacheCaseTypeNameMap.clear();
			cacheCaseTypeNameMap = null;
		}
		initCache();
	}
	@Override
	public List<CaseTypeDO> loadCaseTypes() {
		if(null == cacheCaseTypeIdMap) {
			initCache();
		}
		List<CaseTypeDO> list = new ArrayList<CaseTypeDO>();
		for(Integer index : cacheCaseTypeIdMap.keySet()) {
			list.add(cacheCaseTypeIdMap.get(index));
		}
		return list;
	}

	@Override
	public int insert(CaseTypeDO caseType) {
		if(null == caseType) {
			return 0;
		}
		CaseTypeDO caseTypeDO = cacheCaseTypeNameMap.get(caseType.getName());
		if(null == caseTypeDO) {
			int id = caseTypeDAO.insert(caseType);
			caseType.setId(id);
			cacheCaseTypeIdMap.put(id, caseType);
			cacheCaseTypeNameMap.put(caseType.getName(), caseType);
			return id;
		}
		return caseTypeDO.getId();
	}

	@Override
	public CaseTypeDO findCaseTypeById(int id) {
		if(0 == id) {
			return null;
		}
		CaseTypeDO caseType = cacheCaseTypeIdMap.get(id);
		if(null == caseType) {
			caseType = caseTypeDAO.findCaseTypeById(id);
		}
		return caseType;
	}

	@Override
	public CaseTypeDO findCaseTypeByName(String name) {
		if(StringUtils.isEmpty(name)){
			return null;
		}
		CaseTypeDO caseType = cacheCaseTypeNameMap.get(name);
		if(null == caseType) {
			caseType = caseTypeDAO.findCaseTypeByName(name);
		}
		return caseType;
	}

	@Override
	public List<CaseTypeDO> loadCaseTypesByQuery(CaseTypeQuery query) {
		return caseTypeDAO.loadCaseTypesByQuery(query);
	}
	
	public int getTotalNumsByQuery(CaseTypeQuery query) {
		return caseTypeDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int update(CaseTypeDO caseType) {
		cacheCaseTypeIdMap.put(caseType.getId(), caseType);
		cacheCaseTypeNameMap.put(caseType.getName(), caseType);
		return caseTypeDAO.update(caseType);
	}

	@Override
	public int delCaseTypeById(int id) {
		CaseTypeDO caseType = cacheCaseTypeIdMap.get(id);
		cacheCaseTypeIdMap.remove(id);
		cacheCaseTypeNameMap.remove(caseType.getName());
		
		return caseTypeDAO.delCaseTypeById(id);
	}

}

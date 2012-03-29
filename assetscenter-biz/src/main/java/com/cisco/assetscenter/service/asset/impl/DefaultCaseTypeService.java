package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.CaseTypeDAO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;
import com.cisco.assetscenter.service.asset.CaseTypeService;

public class DefaultCaseTypeService implements CaseTypeService {

	private CaseTypeDAO cacheCaseTypeDAO;
	@Override
	public List<CaseTypeDO> viewAllAssetTypes() {
		return cacheCaseTypeDAO.loadCaseTypes();
	}

	@Override
	public List<CaseTypeDO> loadCaseTypesByQuery(CaseTypeQuery query) 
	{
		// TODO Auto-generated method stub
			if(null == query) {
				return null;
			}
			return cacheCaseTypeDAO.loadCaseTypesByQuery(query);
		}
	
	@Override
	public CaseTypeDO findCaseTypeById(int id) {
		if(0 == id) {
			return null;
		}
		return cacheCaseTypeDAO.findCaseTypeById(id);
	}

	@Override
	public CaseTypeDO findCaseTypeByName(String name) {
		if(StringUtils.isBlank(name)) {
			return null;
		}
		return cacheCaseTypeDAO.findCaseTypeByName(name);
	}

	@Override
	public int createAssetType(CaseTypeDO caseType) {
		if(null == caseType) {
			return 0;
		}
		return cacheCaseTypeDAO.insert(caseType);
	}

	public void setCacheCaseTypeDAO(CaseTypeDAO cacheCaseTypeDAO) {
		this.cacheCaseTypeDAO = cacheCaseTypeDAO;
	}

	@Override
	public int getTotalNumsByQuery(CaseTypeQuery query) {
		// TODO Auto-generated method stub
		if(null == query) {
			return 0;
		}
		return cacheCaseTypeDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int update(CaseTypeDO caseType) {
		// TODO Auto-generated method stub
		if(null == caseType){
		    return 0;
		}
		return cacheCaseTypeDAO.update(caseType);
	}

	@Override
	public int delCaseTypeById(int id) {
		// TODO Auto-generated method stub
		if(0 == id) {
			return 0;
		}
		return cacheCaseTypeDAO.delCaseTypeById(id);
		
	}



}

package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;

public interface CaseTypeService {

	public List<CaseTypeDO> viewAllAssetTypes();
	
	public List<CaseTypeDO> loadCaseTypesByQuery(CaseTypeQuery query);
	
	public int getTotalNumsByQuery(CaseTypeQuery query);
	
	public CaseTypeDO findCaseTypeById(int id);
	
	public CaseTypeDO findCaseTypeByName(String name);
	
	public int createAssetType(CaseTypeDO caseType);
	
	public int update(final CaseTypeDO caseType); 
	public int delCaseTypeById(int id);
}

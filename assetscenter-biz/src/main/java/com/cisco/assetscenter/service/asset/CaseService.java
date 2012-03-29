package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseQuery;

public interface CaseService {

	public boolean createCase(CaseDO caseDO);
	
	public List<CaseDO> viewCaseByQuery(CaseQuery query);
	
	public int viewTotalCaseQuantity();
	public int viewTotalCaseQuantity(CaseQuery query);
	
	public boolean deleteCaseById(int id);
	
	public CaseDO viewCaseById(int id);
	
	public boolean updateStatus(int id, int status);
	
	public boolean update(CaseDO caseDO);
}

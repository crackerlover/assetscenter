package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.CaseDAO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseQuery;
import com.cisco.assetscenter.service.asset.CaseService;

public class DefaultCaseService implements CaseService {

	private CaseDAO caseDAO;
	@Override
	public boolean createCase(CaseDO caseDO) {
		if(null == caseDO) {
			return false;
		}
		return caseDAO.insert(caseDO) > 0;
	}

	@Override
	public List<CaseDO> viewCaseByQuery(CaseQuery query) {
		if(null == query) {
			return null;
		}
		return caseDAO.loadCasesByQuery(query);
	}

	@Override
	public int viewTotalCaseQuantity() {
		return caseDAO.getCaseTotalNums();
	}

	@Override
	public boolean deleteCaseById(int id) {
		if(0 == id) {
			return false;
		}
		return caseDAO.deleteCaseById(id) > 0;
	}

	@Override
	public CaseDO viewCaseById(int id) {
		if(0 == id) {
			return null;
		}
		return caseDAO.loadCaseById(id);
	}

	public void setCaseDAO(CaseDAO caseDAO) {
		this.caseDAO = caseDAO;
	}

	@Override
	public int viewTotalCaseQuantity(CaseQuery query) {
		if(null == query) {
			return 0;
		}
		return caseDAO.getCaseTotalNumsByQuery(query);
	}

	@Override
	public boolean updateStatus(int id, int status) {
		if(0 == id) {
			return false;
		}
		return caseDAO.updateStatus(id, status) > 0;
	}

	@Override
	public boolean update(CaseDO caseDO) {
		if(null == caseDO) {
			return false;
		}
		return caseDAO.update(caseDO) > 0;
	}

}

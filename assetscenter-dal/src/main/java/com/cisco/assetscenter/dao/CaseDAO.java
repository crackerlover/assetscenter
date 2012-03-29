package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseQuery;

/**
 * case database access dao.
 * @author shuaizha
 *
 */
public interface CaseDAO {

	/**
	 * insert a new case.
	 * @param caseDO
	 * @return
	 */
	public int insert(final CaseDO caseDO);
	
	/**
	 * load all cases in database.
	 * @return
	 */
	public List<CaseDO> loadAllCases();
	
	/**
	 * get total nums of case.
	 * @return
	 */
	public int getCaseTotalNums();
	
	/**
	 * get total nums of case by query.
	 * @param query
	 * @return
	 */
	public int getCaseTotalNumsByQuery(CaseQuery query);
	
	/**
	 * get case by query.
	 * @param query
	 * @return
	 */
	public List<CaseDO> loadCasesByQuery(CaseQuery query);
	
	/**
	 * delete case by id.
	 * @param id
	 * @return
	 */
	public int deleteCaseById(int id);
	
	/**
	 * load case by id.
	 * @param id
	 * @return
	 */
	public CaseDO loadCaseById(int id);
	
	/**
	 * update case status.
	 * @param id
	 * @param status
	 * @return
	 */
	public int updateStatus(int id, int status);
	
	public int update(CaseDO caseDO);
}

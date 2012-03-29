package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;

/**
 * case type database access class.
 * @author shuaizha
 *
 */
public interface CaseTypeDAO {

	/**
	 * load all case types.
	 * @return
	 */
	public List<CaseTypeDO> loadCaseTypes();
	public List<CaseTypeDO> loadCaseTypesByQuery(CaseTypeQuery query);
	public int getTotalNumsByQuery(CaseTypeQuery query);
	
	/**
	 * insert a new case tyep.
	 * @param caseType
	 * @return
	 */
	public int insert(final CaseTypeDO caseType);
	
	/**
	 * find case type by id.
	 * @param id
	 * @return
	 */
	public CaseTypeDO findCaseTypeById(int id);
	
	/**
	 * find case type by name.
	 * @param name
	 * @return
	 */
	public CaseTypeDO findCaseTypeByName(String name);
	
	/**
	 * edit case type.
	 * @param CaseType
	 * @return
	 */

	public int update(CaseTypeDO caseType);
	
	/**
	 * delete case type.
	 * @param id
	 * @return
	 */

	public int delCaseTypeById(int id);
	
}

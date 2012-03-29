package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectApplyRecordQuery;

/**
 * project apply record database access class.
 * @author shuaizha
 *
 */
public interface ProjectApplyRecordDAO {

	/**
	 * insert a new record.
	 * @param projectApplyRecord
	 * @return
	 */
	public int insert(ProjectApplyRecordDO projectApplyRecord);
	
	/**
	 * update record status.
	 * @param status
	 * @param id
	 * @return
	 */
	public int updateStatus(int status, int id);
	
	/**
	 * load record by query.
	 * @param query
	 * @return
	 */
	public List<ProjectApplyRecordDO> loadProjectApplyRecordByQuery(ProjectApplyRecordQuery query);
	
	/**
	 * get total num by query.
	 * @param query
	 * @return
	 */
	public int getProjectApplyRecordTotalNums(ProjectApplyRecordQuery query);
	
	/**
	 * find record by id.
	 * @param id
	 * @return
	 */
	public ProjectApplyRecordDO findProjectApplyRecordById(int id);
	
	/**
	 * find record by role.
	 * @param id
	 * @param role
	 * @return
	 */
	public List<ProjectApplyRecordDO> findProjectApplyRecordByIdRole(int id, int role);
	
	/**
	 * find record by username, role.
	 * @param project
	 * @param username
	 * @param role
	 * @return
	 */
	public ProjectApplyRecordDO findProjectApplyRecordByIdUserRole(String project, String username, int role);
}

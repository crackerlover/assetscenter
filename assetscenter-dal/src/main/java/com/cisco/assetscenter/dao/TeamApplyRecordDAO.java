package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamApplyRecordQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;

/**
 * team apply record database access class.
 * @author shuaizha
 *
 */
public interface TeamApplyRecordDAO {

	/**
	 * insert a new team apply record.
	 * @param teamApplyRecord
	 * @return
	 */
	public int insert(TeamApplyRecordDO teamApplyRecord);
	
	/**
	 * update record status.
	 * @param status
	 * @param id
	 * @return
	 */
	public int updateStatus(int status, int id);
	
	/**
	 * load the records by query.
	 * @param query
	 * @return
	 */
	public List<TeamApplyRecordDO> loadTeamApplyRecordByQuery(TeamApplyRecordQuery query);
	
	/**
	 * get record num by query.
	 * @param query
	 * @return
	 */
	public int getTeamApplyRecordTotalNums(TeamApplyRecordQuery query);
	
	/**
	 * find team apply record by id.
	 * @param id
	 * @return
	 */
	public TeamApplyRecordDO findTeamApplyRecordById(int id);
	
	/**
	 * find record by role.
	 * @param id
	 * @param role
	 * @return
	 */
	public List<TeamApplyRecordDO> findTeamApplyRecordByIdRole(int id, int role);
	
	/**
	 * find record by user, role.
	 * @param team
	 * @param username
	 * @param role
	 * @return
	 */
	public TeamApplyRecordDO findTeamApplyRecordByIdUserRole(String team, String username, int role);
}

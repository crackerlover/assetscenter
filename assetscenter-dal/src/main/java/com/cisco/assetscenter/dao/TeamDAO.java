package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;

/**
 * team database access class.
 * @author shuaizha
 *
 */
public interface TeamDAO {

	/**
	 * load all teams.
	 * @return
	 */
	public List<TeamDO> loadAllTeams();
	
	/**
	 * load teams by query.
	 * @param query
	 * @return
	 */
	public List<TeamDO> loadAllTeamsByQuery(TeamQuery query);
	
	/**
	 * get nums of teams by query.
	 * @param query
	 * @return
	 */
	public int getTotalNumsByQuery(TeamQuery query);
	
	/**
	 * delete team by id.
	 * @param id
	 * @return
	 */
	public int delTeamById(int id);
	
	/**
	 * update team.
	 * @param team
	 * @return
	 */
	public int update(final TeamDO team);
	
	/**
	 * insert a new team.
	 * @param team
	 * @return
	 */
	public int insert(final TeamDO team);
	
	/**
	 * find team by id.
	 * @param id
	 * @return
	 */
	public TeamDO findTeamById(int id);
	
	/**
	 * find team by name.
	 * @param name
	 * @return
	 */
	public TeamDO findTeamByName(String name);
	
	/**
	 * find teams by username.
	 * @param username
	 * @return
	 */
	public List<TeamDO> findTeamsByUsername(String username);
	
	/**
	 * find teams by project id.
	 * @param projectId
	 * @return
	 */
	public List<TeamDO> findTeamsByProjectId(int projectId);
}

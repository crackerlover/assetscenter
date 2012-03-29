package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.UserQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;

/**
 * user database access class.
 * @author shuaizha
 *
 */
public interface UserDAO {

	/**
	 * load all users.
	 * @return
	 */
	public List<UserDO> loadAllUsers();
	
	/**
	 * get total nums of users.
	 * @return
	 */
	public int getUserTotalNums();
	
	/**
	 * get nums of users by query.
	 * @param query
	 * @return
	 */
	public int getUserTotalNumsByQuery(UserQuery query);
	
	/**
	 * insert a new user.
	 * @param user
	 * @return
	 */
	public int insert(UserDO user);
	
	/**
	 * load user by query.
	 * @param query
	 * @return
	 */
	public List<UserDO> loadUserByQuery(UserQuery query);
	
	/**
	 * delete user by id.
	 * @param id
	 * @return
	 */
	public int deleteUserById(int id);
	
	/**
	 * update user.
	 * @param user
	 * @return
	 */
	public int update(UserDO user);
	
	/**
	 * find user by id.
	 * @param id
	 * @return
	 */
	public UserDO findUserById(int id);
	
	/**
	 * find user by username.
	 * @param username
	 * @return
	 */
	public UserDO findUserByUserName(String username);
	
	/**
	 * insert a new user team.
	 * @param userTeam
	 * @return
	 */
	public int insertUserTeam(UserTeamDO userTeam);
	
	/**
	 * insert a new user project.
	 * @param userProject
	 * @return
	 */
	public int insertUserProject(UserProjectDO userProject);
	
	/**
	 * find user team by ids.
	 * @param username
	 * @param teamId
	 * @return
	 */
	public UserTeamDO findUserTeamByIds(String username, int teamId);
	
	/**
	 * find user team by team id.
	 * @param teamId
	 * @return
	 */
	public List<UserTeamDO> findUserTeamByTeamId(int teamId);
	
	/**
	 * find user project by username, projectId.
	 * @param username
	 * @param projectId
	 * @return
	 */
	public UserProjectDO findUserProjectByIds(String username, int projectId);
	
	/**
	 * find user project by projecy id.
	 * @param projectId
	 * @return
	 */
	public List<UserProjectDO> findUserProjectByProjectId(int projectId);
	
	/**
	 * find user by role.
	 * @param role
	 * @return
	 */
	public List<UserDO> findUserByRole(int role);
	
	public List<UserProjectDO> findUserProjectByProjectRole(int projectId, int role);
	
	public List<UserTeamDO> findUserTeamByTeamRole(int teamId, int role);
}

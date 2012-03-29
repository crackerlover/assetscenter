package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.UserQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;

/**
 * Provide user service interface.
 * @author shuaizha
 *
 */
public interface UserService {

	public boolean createUser(UserDO user);
	
	public List<UserDO> viewUsersByQuery(UserQuery query);
	
	public int viewUserTotalQuantity();
	public int viewUserTotalQuantityByQuery(UserQuery query);
	
	public boolean deleteUserById(int id);
	
	public boolean updateUser(UserDO user);
	
	public UserDO findUserById(int id);
	
	public UserDO findUserByUserName(String username);
	
	public boolean createUserTeam(UserTeamDO userTeam);
	public boolean createUserProject(UserProjectDO userProject);
	
	public boolean isExistUserTeam(String username, int teamId);
	public boolean isExsitUserProject(String username, int projectId);
	
	public List<UserDO> findUserByRole(int role);
	
	public List<UserProjectDO> findUserProjectByProjectRole(int projectId, int role);
	public List<UserTeamDO> findUserTeamByTeamRole(int teamId, int role);
}

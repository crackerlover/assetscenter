package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.UserDAO;
import com.cisco.assetscenter.dao.dataobject.query.UserQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;
import com.cisco.assetscenter.service.asset.UserService;

public class DefaultUserService implements UserService{

	private UserDAO userDAO;
	@Override
	public boolean createUser(UserDO user) {
		if(null == user) {
			return false;
		}
		return userDAO.insert(user) > 0;
	}

	@Override
	public List<UserDO> viewUsersByQuery(UserQuery query) {
		if(null == query) {
			return null;
		}
		return userDAO.loadUserByQuery(query);
	}

	@Override
	public int viewUserTotalQuantity() {
		return userDAO.getUserTotalNums();
	}

	@Override
	public boolean deleteUserById(int id) {
		if(0 == id) {
			return false;
		}
		return userDAO.deleteUserById(id) > 0;
	}

	@Override
	public boolean updateUser(UserDO user) {
		if(null == user) {
			return false;
		}
		return userDAO.update(user) > 0;
	}

	@Override
	public UserDO findUserById(int id) {
		if(0 == id) {
			return null;
		}
		return userDAO.findUserById(id);
	}

	@Override
	public UserDO findUserByUserName(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		return userDAO.findUserByUserName(username);
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public int viewUserTotalQuantityByQuery(UserQuery query) {
		if(null == query) {
			return 0;
		}
		return userDAO.getUserTotalNumsByQuery(query);
	}

	@Override
	public boolean createUserTeam(UserTeamDO userTeam) {
		if(null == userTeam) {
			return false;
		}
		return userDAO.insertUserTeam(userTeam) > 0;
	}

	@Override
	public boolean createUserProject(UserProjectDO userProject) {
		if(null == userProject) {
			return false;
		}
		return userDAO.insertUserProject(userProject) > 0;
	}

	@Override
	public boolean isExistUserTeam(String username, int teamId) {
		if(StringUtils.isEmpty(username) || 0 == teamId) {
			return false;
		}
		return null != userDAO.findUserTeamByIds(username, teamId);
	}

	@Override
	public boolean isExsitUserProject(String username, int projectId) {
		if(0 == projectId) {
			return false;
		}
		if(StringUtils.isEmpty(username)) {
			return false;
		}
		return null != userDAO.findUserProjectByIds(username, projectId);
	}

	@Override
	public List<UserDO> findUserByRole(int role) {
		if(0 == role) {
			return null;
		}
		return userDAO.findUserByRole(role);
	}

	@Override
	public List<UserProjectDO> findUserProjectByProjectRole(int projectId,
			int role) {
		return userDAO.findUserProjectByProjectRole(projectId, role);
	}

	@Override
	public List<UserTeamDO> findUserTeamByTeamRole(int teamId, int role) {
		return userDAO.findUserTeamByTeamRole(teamId, role);
	}

}

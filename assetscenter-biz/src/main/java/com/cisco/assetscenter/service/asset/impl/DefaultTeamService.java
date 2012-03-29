package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.TeamDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.service.asset.TeamService;

public class DefaultTeamService implements TeamService {

	private TeamDAO cacheTeamDAO;
	@Override
	public List<TeamDO> viewAllTeams() {
		return cacheTeamDAO.loadAllTeams();
	}

	@Override
	public TeamDO findTeamById(int id) {
		if(0 == id) {
			return null;
		}
		return cacheTeamDAO.findTeamById(id);
	}

	@Override
	public TeamDO findTeamByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		return cacheTeamDAO.findTeamByName(name);
	}

	@Override
	public int createTeam(TeamDO team) {
		if(null == team) {
			return 0;
		}
		return cacheTeamDAO.insert(team);
	}

	public void setCacheTeamDAO(TeamDAO cacheTeamDAO) {
		this.cacheTeamDAO = cacheTeamDAO;
	}

	@Override
	public List<TeamDO> findTeamsByUsername(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		return cacheTeamDAO.findTeamsByUsername(username);
	}

	@Override
	public List<TeamDO> findTeamsByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		return cacheTeamDAO.findTeamsByProjectId(projectId);
	}

	@Override
	public List<TeamDO> loadAllTeamsByQuery(TeamQuery query) {
		if(null == query) {
			return null;
		}
		return cacheTeamDAO.loadAllTeamsByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(TeamQuery query) {
		if(null == query) {
			return 0;
		}
		return cacheTeamDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int delTeamById(int id) {
		if(0 == id) {
			return id;
		}
		return cacheTeamDAO.delTeamById(id);
	}

	@Override
	public int update(TeamDO team) {
		if(null == team) {
			return 0;
		}
		return cacheTeamDAO.update(team);
	}

}

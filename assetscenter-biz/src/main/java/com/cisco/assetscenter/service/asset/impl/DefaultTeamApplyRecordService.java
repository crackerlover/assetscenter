package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.TeamApplyRecordDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamApplyRecordQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;
import com.cisco.assetscenter.service.asset.TeamApplyRecordService;

public class DefaultTeamApplyRecordService implements TeamApplyRecordService {

	private TeamApplyRecordDAO teamApplyRecordDAO;
	@Override
	public int insert(TeamApplyRecordDO teamApplyRecord) {
		if(null == teamApplyRecord) {
			return 0;
		}
		return teamApplyRecordDAO.insert(teamApplyRecord);
	}

	@Override
	public boolean updateStatus(int status, int id) {
		if(0 == id) {
			return false;
		}
		return teamApplyRecordDAO.updateStatus(status, id) > 0;
	}

	@Override
	public List<TeamApplyRecordDO> loadTeamApplyRecordByQuery(
			TeamApplyRecordQuery query) {
		if(null == query) {
			return null;
		}
		return teamApplyRecordDAO.loadTeamApplyRecordByQuery(query);
	}

	@Override
	public int getTeamApplyRecordTotalNums(TeamApplyRecordQuery query) {
		if(null == query) {
			return 0;
		}
		return teamApplyRecordDAO.getTeamApplyRecordTotalNums(query);
	}

	@Override
	public TeamApplyRecordDO findTeamApplyRecordById(int id) {
		if(0 == id) {
			return null;
		}
		return teamApplyRecordDAO.findTeamApplyRecordById(id);
	}

	@Override
	public List<TeamApplyRecordDO> findTeamApplyRecordByIdRole(int id, int role) {
		if(0 == id) {
			return null;
		}
		return teamApplyRecordDAO.findTeamApplyRecordByIdRole(id, role);
	}

	public void setTeamApplyRecordDAO(TeamApplyRecordDAO teamApplyRecordDAO) {
		this.teamApplyRecordDAO = teamApplyRecordDAO;
	}

	@Override
	public TeamApplyRecordDO findTeamApplyRecordByIdUserRole(String team,
			String username, int role) {
		if(StringUtils.isEmpty(team) || StringUtils.isEmpty(username)) {
			return null;
		}
		return teamApplyRecordDAO.findTeamApplyRecordByIdUserRole(team, username, role);
	}

}

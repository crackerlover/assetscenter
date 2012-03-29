package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.TeamAssetDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamAssetQuery;
import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;
import com.cisco.assetscenter.service.asset.TeamAssetService;

public class DefaultTeamAssetService implements TeamAssetService {

	private TeamAssetDAO teamAssetDAO;
	@Override
	public int insert(TeamAssetDO teamAsset) {
		if(null == teamAsset) {
			return 0;
		}
		return teamAssetDAO.insert(teamAsset);
	}

	@Override
	public List<TeamAssetDO> loadTeamAssetByQuery(TeamAssetQuery query) {
		if(null == query) {
			return null;
		}
		return teamAssetDAO.loadTeamAssetByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(TeamAssetQuery query) {
		if(null == query) {
			return 0;
		}
		return teamAssetDAO.getTotalNumsByQuery(query);
	}

	@Override
	public boolean updateTeamByIds(int id, int teamId) {
		if(0 == id || 0 == teamId) {
			return false;
		}
		return teamAssetDAO.updateTeamByIds(id, teamId) > 0;
	}

	@Override
	public boolean deleteTeamAssetById(int id) {
		if(0 == id) {
			return false;
		}
		return teamAssetDAO.deleteTeamAssetById(id) > 0;
	}

	public void setTeamAssetDAO(TeamAssetDAO teamAssetDAO) {
		this.teamAssetDAO = teamAssetDAO;
	}

	@Override
	public TeamAssetDO findTeamAssetByIds(int assetId) {
		if(0 == assetId) {
			return null;
		}
		return teamAssetDAO.findTeamAssetByIds(assetId);
	}

}

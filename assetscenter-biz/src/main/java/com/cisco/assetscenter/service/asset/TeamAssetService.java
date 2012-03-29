package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamAssetQuery;
import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;

public interface TeamAssetService {

	public int insert(TeamAssetDO teamAsset);
	
	public List<TeamAssetDO> loadTeamAssetByQuery(TeamAssetQuery query);
	
	public int getTotalNumsByQuery(TeamAssetQuery query);
	
	public boolean updateTeamByIds(int id, int teamId);
	
	public boolean deleteTeamAssetById(int id);
	public TeamAssetDO findTeamAssetByIds(int assetId);
}

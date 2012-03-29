package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamApplyRecordQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;

public interface TeamApplyRecordService {

	public int insert(TeamApplyRecordDO teamApplyRecord);
	
	public boolean updateStatus(int status, int id);
	
	public List<TeamApplyRecordDO> loadTeamApplyRecordByQuery(TeamApplyRecordQuery query);
	
	public int getTeamApplyRecordTotalNums(TeamApplyRecordQuery query);
	
	public TeamApplyRecordDO findTeamApplyRecordById(int id);
	public List<TeamApplyRecordDO> findTeamApplyRecordByIdRole(int id, int role);	
	public TeamApplyRecordDO findTeamApplyRecordByIdUserRole(String team, String username, int role);
}

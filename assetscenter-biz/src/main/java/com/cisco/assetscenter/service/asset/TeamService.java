package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;

public interface TeamService {

	
	public List<TeamDO> viewAllTeams();
	
	public TeamDO findTeamById(int id);
	
	public TeamDO findTeamByName(String name);
	
	public int createTeam(TeamDO team);
	public List<TeamDO> findTeamsByUsername(String username);
	public List<TeamDO> findTeamsByProjectId(int projectId);
	
	public List<TeamDO> loadAllTeamsByQuery(TeamQuery query);
	
	public int getTotalNumsByQuery(TeamQuery query);
	
	public int delTeamById(int id);
	
	public int update(final TeamDO team);
}

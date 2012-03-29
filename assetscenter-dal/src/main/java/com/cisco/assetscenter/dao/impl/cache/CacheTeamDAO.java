package com.cisco.assetscenter.dao.impl.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;

import com.cisco.assetscenter.dao.TeamDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;

public class CacheTeamDAO extends SimpleJdbcDaoSupport implements TeamDAO {

	private Map<Integer, TeamDO> cacheTeamIdMap;
	private Map<String, TeamDO> cacheTeamNameMap;
	private TeamDAO teamDAO;
	
	public CacheTeamDAO(TeamDAO teamDAO) {
		this.teamDAO = teamDAO;
		initCache();
	}
	
	private synchronized void initCache() {
		if(null == cacheTeamIdMap) {
			cacheTeamIdMap = new HashMap<Integer, TeamDO>();
		}
		if(null == cacheTeamNameMap) {
			cacheTeamNameMap = new HashMap<String, TeamDO>();
		}
		List<TeamDO> list = teamDAO.loadAllTeams();
		if(null != list && list.size() > 0) {
			for(TeamDO team : list) {
				cacheTeamIdMap.put(team.getId(), team);
				cacheTeamNameMap.put(team.getName(), team);
			}
		}
	}
	
	public synchronized void cleanCache() {
		if(null != cacheTeamIdMap) {
			cacheTeamIdMap.clear();
			cacheTeamIdMap = null;
		}
		if(null != cacheTeamNameMap) {
			cacheTeamNameMap.clear();
			cacheTeamNameMap = null;
		}
		initCache();
	}
	@Override
	public List<TeamDO> loadAllTeams() {
		if(null == cacheTeamIdMap) {
			initCache();
		}
		List<TeamDO> list = new ArrayList<TeamDO>();
		for(Integer index : cacheTeamIdMap.keySet()) {
			list.add(cacheTeamIdMap.get(index));
		}
		return list;
	}

	@Override
	public int insert(TeamDO team) {
		if(null == team) {
			return 0;
		}
		TeamDO teamDO = cacheTeamNameMap.get(team.getName());
		if(null == teamDO) {
			int id = teamDAO.insert(team);
			team.setId(id);
			cacheTeamIdMap.put(id, team);
			cacheTeamNameMap.put(team.getName(), team);
			return id;
		}
		return teamDO.getId();
	}

	@Override
	public TeamDO findTeamById(int id) {
		if(0 == id) {
			return null;
		}
		TeamDO team = cacheTeamIdMap.get(id);
		if(null == team) {
			team = teamDAO.findTeamById(id);
		}
		return team;
	}

	@Override
	public TeamDO findTeamByName(String name) {
		if(StringUtils.isEmpty(name)){
			return null;
		}
		TeamDO team = cacheTeamNameMap.get(name);
		if(null == team) {
			team = teamDAO.findTeamByName(name);
		}
		return team;
	}

	@Override
	public List<TeamDO> findTeamsByUsername(String username) {
		return teamDAO.findTeamsByUsername(username);
	}

	@Override
	public List<TeamDO> findTeamsByProjectId(int projectId) {
		return teamDAO.findTeamsByProjectId(projectId);
	}

	@Override
	public List<TeamDO> loadAllTeamsByQuery(TeamQuery query) {
		return teamDAO.loadAllTeamsByQuery(query);
	}

	@Override
	public int getTotalNumsByQuery(TeamQuery query) {
		return teamDAO.getTotalNumsByQuery(query);
	}

	@Override
	public int delTeamById(int id) {
		TeamDO team = cacheTeamIdMap.get(id);
		cacheTeamIdMap.remove(id);
		cacheTeamNameMap.remove(team.getName());
		return teamDAO.delTeamById(id);
	}

	@Override
	public int update(TeamDO team) {
		cacheTeamIdMap.put(team.getId(), team);
		cacheTeamNameMap.put(team.getName(), team);
		return teamDAO.update(team);
	}


}

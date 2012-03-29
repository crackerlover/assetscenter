package com.cisco.assetscenter.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.cisco.assetscenter.dao.TeamDAO;
import com.cisco.assetscenter.dao.UserDAO;
import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;

public class DefaultTeamDAO extends SimpleJdbcDaoSupport implements TeamDAO {

	private UserDAO userDAO;
	private PlatformTransactionManager txManager;
	@Override
	public List<TeamDO> loadAllTeams() {
		final String sql = "SELECT * FROM AC_TEAM ORDER BY NAME ASC";
		List<TeamDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamMapper());
		if(null != list) {
			for(TeamDO team : list) {
				final String sql_user_project = "SELECT * FROM AC_USER_TEAM WHERE TEAM_ID = " + team.getId();
				List<UserTeamDO> upds = this.getSimpleJdbcTemplate().query(sql_user_project, new UserTeamMapper());
				
				List<String> managers = new ArrayList<String>();
				if(null != upds)
					for(UserTeamDO upd : upds) {
						if(upd.getRole() == Constants.TEAM_MANAGER_ROLE)
							managers.add(upd.getUsername());
						
					}
				if(null != managers) {
					team.setManagers(managers.toArray(new String[]{}));
				}
			}
		}
		return list;
	}

	private final class UserTeamMapper implements ParameterizedRowMapper<UserTeamDO> {

		@Override
		public UserTeamDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserTeamDO userTeam = new UserTeamDO();
			userTeam.setId(rs.getInt("ID"));
			userTeam.setUsername(rs.getString("USERNAME"));
			userTeam.setTeamId(rs.getInt("TEAM_ID"));
			userTeam.setRole(rs.getInt("ROLE"));
			return userTeam;
		}
		
	}
	@Override
	public int insert(final TeamDO team) {
		if(null == team) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("InsertTeamTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		final String sql = "INSERT INTO AC_TEAM(NAME, DESCRIPTION, GMT_CREATE) VALUES (?, ?, ?)";
		final String sql_user_team = "INSERT INTO AC_USER_TEAM(USERNAME, TEAM_ID, ROLE) VALUES (?, ?, ?)";
		int teamId = 0;
		try {
			KeyHolder keyholder = new GeneratedKeyHolder();
			this.getJdbcTemplate().update(new PreparedStatementCreator() {

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
					ps.setString(1, team.getName());
					ps.setString(2, team.getDescription());
					ps.setString(3, team.getGmtCreate());
					return ps;
				}
				
			}, keyholder);
			teamId = keyholder.getKey().intValue();
			String[] managers = team.getManagers();
			List<Object[]> batch = new ArrayList<Object[]>();
			if(null != managers)
				for(String manager : managers) {
					Object[] values = new Object[]{
							manager,
							teamId,
							Constants.TEAM_MANAGER_ROLE
					};
					batch.add(values);
				}
			this.getSimpleJdbcTemplate().batchUpdate(sql_user_team, batch);
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return teamId;
	}

	@Override
	public TeamDO findTeamById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM WHERE ID = " + id;
		List<TeamDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public TeamDO findTeamByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM WHERE NAME = '" + name + "'";
		List<TeamDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class TeamMapper implements ParameterizedRowMapper<TeamDO> {

		@Override
		public TeamDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			TeamDO team = new TeamDO();
			team.setId(rs.getInt("id"));
			team.setName(rs.getString("name"));
			team.setDescription(rs.getString("description"));
			team.setGmtCreate(rs.getString("GMT_CREATE"));
			return team;
		}
		
	}

	@Override
	public List<TeamDO> findTeamsByUsername(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT AT.* FROM AC_TEAM AT, AC_USER_TEAM AUT WHERE AUT.TEAM_ID = AT.ID AND AUT.USERNAME = '" + username + "'";
		return this.getSimpleJdbcTemplate().query(sql, new TeamMapper());
	}

	@Override
	public List<TeamDO> findTeamsByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		final String sql = "SELECT AT.* FROM AC_TEAM AT, AC_PROJECT_TEAM APT WHERE APT.TEAM_ID = AT.ID AND APT.PROJECT_ID = " + projectId;
		return this.getSimpleJdbcTemplate().query(sql, new TeamMapper());
	}

	@Override
	public List<TeamDO> loadAllTeamsByQuery(TeamQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_TEAM");
		String name = query.getName();
		String dateSql = "";
		String nameSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		sql.append(" WHERE 1 = 1 ");
		if(StringUtils.isNotBlank(name)) {
			nameSql = " NAME LIKE '%" + name + "%'";
		}
		if(StringUtils.isNotBlank(nameSql)) {
			sql.append(" AND ").append(nameSql);
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_CREATE BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " GMT_CREATE >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_CREATE <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		List<TeamDO> list = this.getSimpleJdbcTemplate().query(sql.toString(), new TeamMapper());
		if(null != list) {
			for(TeamDO team : list) {
				final String sql_user_project = "SELECT * FROM AC_USER_TEAM WHERE TEAM_ID = " + team.getId();
				List<UserTeamDO> upds = this.getSimpleJdbcTemplate().query(sql_user_project, new UserTeamMapper());
				
				List<String> managers = new ArrayList<String>();
				if(null != upds)
					for(UserTeamDO upd : upds) {
						if(upd.getRole() == Constants.TEAM_MANAGER_ROLE)
							managers.add(upd.getUsername());
						
					}
				if(null != managers) {
					team.setManagers(managers.toArray(new String[]{}));
				}
			}
		}
		return list;
	}

	@Override
	public int getTotalNumsByQuery(TeamQuery query) {
		if(null == query) {
			return 0;
		}
		final StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_TEAM");
		sql.append(" WHERE 1 = 1 ");
		String name = query.getName();
		String nameSql = "";
		if(StringUtils.isNotBlank(name)) {
			nameSql = " NAME LIKE '%" + name + "%'";
		}
		if(StringUtils.isNotBlank(nameSql)) {
			sql.append(" AND ").append(nameSql);
		}
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_CREATE BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " GMT_CREATE >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_CREATE <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}

	@Override
	public int delTeamById(final int id) {
		if(0 == id) {
			return id;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateTeamTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int teamId = 0;
		final String sql = "DELETE FROM AC_TEAM WHERE ID = ?";
		try {
			teamId = this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, id);
					return ps;
			}});
			final String sql_team_user = "DELETE FROM AC_USER_TEAM WHERE TEAM_ID = ?";
			this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql_team_user);
					ps.setInt(1, id);
					return ps;
			}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return teamId;
		
	}

	@Override
	public int update(final TeamDO team) {
		if(null == team) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateTeamTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int teamId = 0;
		final String sql = "UPDATE AC_TEAM SET NAME=?, DESCRIPTION=? WHERE ID=?";
		try {
			teamId = this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, team.getName());
					ps.setString(2, team.getDescription());
					ps.setInt(3, team.getId());
					return ps;
				}});
			String[] managers = team.getManagers();
			if(null != managers && managers.length > 0) {
				for(String manager : managers) {
					UserTeamDO up = userDAO.findUserTeamByIds(manager, team.getId());
					if(null == up) {
						UserTeamDO upo = new UserTeamDO();
						upo.setTeamId(team.getId());
						upo.setUsername(manager);
						upo.setRole(Constants.TEAM_MANAGER_ROLE);
						userDAO.insertUserTeam(upo);
					}
				}
			}
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return teamId;
		
	}

	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

}

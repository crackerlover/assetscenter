package com.cisco.assetscenter.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import com.cisco.assetscenter.dao.TeamApplyRecordDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamApplyRecordQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;

public class DefaultTeamApplyRecordDAO extends SimpleJdbcDaoSupport implements
		TeamApplyRecordDAO {

	@Override
	public int insert(final TeamApplyRecordDO teamApplyRecord) {
		if(null == teamApplyRecord) {
			return 0;
		}
		final String sql = "INSERT INTO AC_TEAM_APPLY_RECORD(APPLICANT, TEAM, ROLE, STATUS, APPLY_TIME) VALUES(?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1,teamApplyRecord.getApplicant());
				ps.setString(2, teamApplyRecord.getTeam());
				ps.setInt(3, teamApplyRecord.getRole());
				ps.setInt(4, teamApplyRecord.getStatus());
				ps.setString(5, teamApplyRecord.getApplyTime());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public int updateStatus(final int status,final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "UPDATE AC_TEAM_APPLY_RECORD SET STATUS=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, status);
				ps.setInt(2, id);
				return ps;
			}});
	}

	@Override
	public List<TeamApplyRecordDO> loadTeamApplyRecordByQuery(
			TeamApplyRecordQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_TEAM_APPLY_RECORD");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String roleSql = "";
		int role = query.getRole();
		if(-1 != role) {
			roleSql = " ROLE = " + role;
		}
		if(StringUtils.isNotBlank(roleSql)) {
			sql.append(" AND ").append(roleSql);
		}
		
		String applicantSql = "";
		String applicant = query.getApplicant();
		if(StringUtils.isNotBlank(applicant)) {
			applicantSql = " APPLICANT LIKE '%" + applicant + "%'";
		}
		if(StringUtils.isNotBlank(applicantSql)) {
			sql.append(" AND ").append(applicantSql);
		}
		String teamSql = "";
		String team = query.getTeam();
		if(StringUtils.isNotBlank(team)) {
			teamSql = " TEAM LIKE '%" + team + "%'";
		}
		if(StringUtils.isNotBlank(teamSql)) {
			sql.append(" AND ").append(teamSql);
		}
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_MODIFIED BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " GMT_MODIFIED >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_MODIFIED <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		return this.getSimpleJdbcTemplate().query(sql.toString(), new TeamApplyRecordMapper());
	}

	@Override
	public int getTeamApplyRecordTotalNums(TeamApplyRecordQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM AC_TEAM_APPLY_RECORD");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String roleSql = "";
		int role = query.getRole();
		if(-1 != role) {
			roleSql = " ROLE = " + role;
		}
		if(StringUtils.isNotBlank(roleSql)) {
			sql.append(" AND ").append(roleSql);
		}
		
		String applicantSql = "";
		String applicant = query.getApplicant();
		if(StringUtils.isNotBlank(applicant)) {
			applicantSql = " APPLICANT LIKE '%" + applicant + "%'";
		}
		if(StringUtils.isNotBlank(applicantSql)) {
			sql.append(" AND ").append(applicantSql);
		}
		String teamSql = "";
		String team = query.getTeam();
		if(StringUtils.isNotBlank(team)) {
			teamSql = " TEAM LIKE '%" + team + "%'";
		}
		if(StringUtils.isNotBlank(teamSql)) {
			sql.append(" AND ").append(teamSql);
		}
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_MODIFIED BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " GMT_MODIFIED >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " GMT_MODIFIED <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}

	@Override
	public TeamApplyRecordDO findTeamApplyRecordById(int id) {
		if(id == 0) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM_APPLY_RECORD WHERE ID = " + id;
		List<TeamApplyRecordDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamApplyRecordMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public List<TeamApplyRecordDO> findTeamApplyRecordByIdRole(int id, int role) {
		if(0 == id || 0 == role) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM_APPLY_RECORD WHERE ID = " + id + " AND ROLE= " + role;
		return this.getSimpleJdbcTemplate().query(sql, new TeamApplyRecordMapper());
	}
	
	private final class TeamApplyRecordMapper implements ParameterizedRowMapper<TeamApplyRecordDO> {

		@Override
		public TeamApplyRecordDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			TeamApplyRecordDO teamApplyRecord = new TeamApplyRecordDO();
			teamApplyRecord.setId(rs.getInt("id"));
			teamApplyRecord.setApplicant(rs.getString("APPLICANT"));
			teamApplyRecord.setTeam(rs.getString("TEAM"));
			teamApplyRecord.setStatus(rs.getInt("STATUS"));
			teamApplyRecord.setRole(rs.getInt("ROLE"));
			teamApplyRecord.setApplyTime(rs.getString("APPLY_TIME"));
			return teamApplyRecord;
		}
		
	}

	@Override
	public TeamApplyRecordDO findTeamApplyRecordByIdUserRole(String team,String username, int role) {
		if(StringUtils.isEmpty(team) || StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM_APPLY_RECORD WHERE TEAM = '" + team + "' AND ROLE= " + role + " AND APPLICANT='" + username + "'";
		List<TeamApplyRecordDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamApplyRecordMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

}

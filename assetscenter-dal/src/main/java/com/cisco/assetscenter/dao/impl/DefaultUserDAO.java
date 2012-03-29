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

import com.cisco.assetscenter.dao.UserDAO;
import com.cisco.assetscenter.dao.dataobject.query.UserQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;

public class DefaultUserDAO extends SimpleJdbcDaoSupport implements UserDAO {

	@Override
	public List<UserDO> loadAllUsers() {
		final String sql = "SELECT * FROM AC_USER ORDER BY USERNAME ASC";
		return this.getSimpleJdbcTemplate().query(sql, new UserMapper());
	}

	@Override
	public int getUserTotalNums() {
		final String sql = "SELECT COUNT(ID) FROM AC_USER";
		return this.getSimpleJdbcTemplate().queryForInt(sql);
	}

	@Override
	public int insert(final UserDO user) {
		if(null == user) {
			return 0;
		}
		final String sql = "INSERT INTO AC_USER(USERNAME, PASSWORD, ROLE, EMAIL, FULLNAME, GMT_CREATE, GMT_MODIFIED) VALUES(?,?,?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, user.getUsername());
				ps.setString(2, user.getPassword());
				ps.setInt(3, user.getRole());
				ps.setString(4, user.getEmail());
				ps.setString(5, user.getFullName());
				ps.setString(6, user.getGmtCreate());
				ps.setString(7, user.getGmtModified());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<UserDO> loadUserByQuery(UserQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_USER");
		int role = query.getRole();
		String roleSql = " WHERE ROLE = " + role;
		sql.append(roleSql);
		
		
		String nameSql = "";
		String username = query.getUsername();
		if(StringUtils.isNotBlank(username)) {
			nameSql = " USERNAME LIKE '%" + username + "%'";
		}
		if(StringUtils.isNotBlank(nameSql)) {
			sql.append(" AND ").append(nameSql);
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
		return this.getSimpleJdbcTemplate().query(sql.toString(), new UserMapper());
	}

	@Override
	public int deleteUserById(final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "DELETE FROM AC_USER WHERE ID = ?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, id);
				return ps;
		}});
	}

	@Override
	public int update(final UserDO user) {
		if(null == user) {
			return 0;
		}
		final String sql = "UPDATE AC_USER SET USERNAME=?, ROLE=?, EMAIL=?, FULLNAME=?, GMT_MODIFIED=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, user.getUsername());
				ps.setInt(2, user.getRole());
				ps.setString(3, user.getEmail());
				ps.setString(4, user.getFullName());
				ps.setString(5, user.getGmtModified());
				ps.setInt(6, user.getId());
				return ps;
			}});
	}

	@Override
	public UserDO findUserById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER WHERE ID = " + id;
		List<UserDO> list = this.getSimpleJdbcTemplate().query(sql, new UserMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public UserDO findUserByUserName(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER WHERE USERNAME = '" + username + "'";
		List<UserDO> list = this.getSimpleJdbcTemplate().query(sql, new UserMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class UserMapper implements ParameterizedRowMapper<UserDO> {

		@Override
		public UserDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserDO user = new UserDO();
			user.setId(rs.getInt("id"));
			user.setUsername(rs.getString("username"));
			user.setPassword(rs.getString("password"));
			user.setRole(rs.getShort("role"));
			user.setEmail(rs.getString("email"));
			user.setFullName(rs.getString("fullname"));
			user.setGmtCreate(rs.getString("gmt_create"));
			user.setGmtModified(rs.getString("gmt_modified"));
			return user;
		}
		
	}

	@Override
	public int getUserTotalNumsByQuery(UserQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_USER");
		int role = query.getRole();
		String roleSql = " WHERE ROLE = " + role;
		sql.append(roleSql);
		
		
		String nameSql = "";
		String username = query.getUsername();
		if(StringUtils.isNotBlank(username)) {
			nameSql = " USERNAME LIKE '%" + username + "%'";
		}
		if(StringUtils.isNotBlank(nameSql)) {
			sql.append(" AND ").append(nameSql);
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
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}

	@Override
	public int insertUserTeam(final UserTeamDO userTeam) {
		if(null == userTeam) {
			return 0;
		}
		final String sql = "INSERT INTO AC_USER_TEAM(USERNAME, TEAM_ID, ROLE) VALUES(?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, userTeam.getUsername());
				ps.setInt(2, userTeam.getTeamId());
				ps.setInt(3, userTeam.getRole());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public int insertUserProject(final UserProjectDO userProject) {
		if(null == userProject) {
			return 0;
		}
		final String sql = "INSERT INTO AC_USER_PROJECT(USERNAME, PROJECT_ID, ROLE) VALUES(?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, userProject.getUsername());
				ps.setInt(2, userProject.getProjectId());
				ps.setInt(3, userProject.getRole());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public UserTeamDO findUserTeamByIds(String username, int teamId) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		if(0 == teamId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_TEAM WHERE TEAM_ID = " + teamId + " AND USERNAME = '" + username + "'";
		List<UserTeamDO> list = this.getSimpleJdbcTemplate().query(sql, new UserTeamMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public UserProjectDO findUserProjectByIds(String username, int projectId) {
		if(0 == projectId) {
			return null;
		}
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_PROJECT WHERE PROJECT_ID = " + projectId + " AND USERNAME = '" + username + "'";
		List<UserProjectDO> list = this.getSimpleJdbcTemplate().query(sql, new UserProjectMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
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
	private final class UserProjectMapper implements ParameterizedRowMapper<UserProjectDO> {
		
		@Override
		public UserProjectDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserProjectDO userProject = new UserProjectDO();
			userProject.setId(rs.getInt("ID"));
			userProject.setUsername(rs.getString("USERNAME"));
			userProject.setProjectId(rs.getInt("PROJECT_ID"));
			userProject.setRole(rs.getInt("ROLE"));
			return userProject;
		}
		
	}

	@Override
	public List<UserTeamDO> findUserTeamByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_TEAM WHERE TEAM_ID = " + teamId;
		return this.getSimpleJdbcTemplate().query(sql, new UserTeamMapper());
	}

	@Override
	public List<UserProjectDO> findUserProjectByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_PROJECT WHERE PROJECT_ID = " + projectId;
		return this.getSimpleJdbcTemplate().query(sql, new UserProjectMapper());
	}

	@Override
	public List<UserDO> findUserByRole(int role) {
		if(0 == role) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER WHERE ROLE = " + role;
		return this.getSimpleJdbcTemplate().query(sql, new UserMapper());
	}

	@Override
	public List<UserProjectDO> findUserProjectByProjectRole(int projectId,
			int role) {
		if(0 == projectId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_PROJECT WHERE PROJECT_ID = " + projectId + " AND ROLE = " + role;
		return this.getSimpleJdbcTemplate().query(sql, new UserProjectMapper());
	}

	@Override
	public List<UserTeamDO> findUserTeamByTeamRole(int teamId, int role) {
		if(0 == teamId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_USER_TEAM WHERE TEAM_ID = " + teamId + " AND ROLE = " + role;
		return this.getSimpleJdbcTemplate().query(sql, new UserTeamMapper());
	}


}

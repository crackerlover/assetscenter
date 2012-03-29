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

import com.cisco.assetscenter.dao.ProjectApplyRecordDAO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectApplyRecordQuery;

public class DefaultProjectApplyRecordDAO extends SimpleJdbcDaoSupport implements ProjectApplyRecordDAO {

	@Override
	public int insert(final ProjectApplyRecordDO projectApplyRecord) {
		if(null == projectApplyRecord) {
			return 0;
		}
		final String sql = "INSERT INTO AC_PROJECT_APPLY_RECORD(APPLICANT, PROJECT, ROLE, STATUS, APPLY_TIME) VALUES(?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1,projectApplyRecord.getApplicant());
				ps.setString(2, projectApplyRecord.getProject());
				ps.setInt(3, projectApplyRecord.getRole());
				ps.setInt(4, projectApplyRecord.getStatus());
				ps.setString(5, projectApplyRecord.getApplyTime());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public int updateStatus(final int status, final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "UPDATE AC_PROJECT_APPLY_RECORD SET STATUS=? WHERE ID=?";
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
	public List<ProjectApplyRecordDO> loadProjectApplyRecordByQuery(
			ProjectApplyRecordQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_PROJECT_APPLY_RECORD");
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
		String projectSql = "";
		String project = query.getProject();
		if(StringUtils.isNotBlank(project)) {
			projectSql = " PROJECT LIKE '%" + project + "%'";
		}
		if(StringUtils.isNotBlank(projectSql)) {
			sql.append(" AND ").append(projectSql);
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
		return this.getSimpleJdbcTemplate().query(sql.toString(), new ProjectApplyRecordMapper());
	}

	@Override
	public int getProjectApplyRecordTotalNums(ProjectApplyRecordQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM AC_PROJECT_APPLY_RECORD");
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
		String projectSql = "";
		String project = query.getProject();
		if(StringUtils.isNotBlank(project)) {
			projectSql = " PROJECT LIKE '%" + project + "%'";
		}
		if(StringUtils.isNotBlank(projectSql)) {
			sql.append(" AND ").append(projectSql);
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
	
	private final class ProjectApplyRecordMapper implements ParameterizedRowMapper<ProjectApplyRecordDO> {

		@Override
		public ProjectApplyRecordDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ProjectApplyRecordDO projectApplyRecord = new ProjectApplyRecordDO();
			projectApplyRecord.setId(rs.getInt("id"));
			projectApplyRecord.setApplicant(rs.getString("APPLICANT"));
			projectApplyRecord.setProject(rs.getString("PROJECT"));
			projectApplyRecord.setStatus(rs.getInt("STATUS"));
			projectApplyRecord.setRole(rs.getInt("ROLE"));
			projectApplyRecord.setApplyTime(rs.getString("APPLY_TIME"));
			return projectApplyRecord;
		}
		
	}

	@Override
	public ProjectApplyRecordDO findProjectApplyRecordById(int id) {
		if(id == 0) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_APPLY_RECORD WHERE ID = " + id;
		List<ProjectApplyRecordDO> list = this.getSimpleJdbcTemplate().query(sql, new ProjectApplyRecordMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public List<ProjectApplyRecordDO> findProjectApplyRecordByIdRole(int id, int role) {
		if(0 == id || 0 == role) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_APPLY_RECORD WHERE ID = " + id + " AND ROLE= " + role;
		return this.getSimpleJdbcTemplate().query(sql, new ProjectApplyRecordMapper());
	}

	@Override
	public ProjectApplyRecordDO findProjectApplyRecordByIdUserRole(String project,
			String username, int role) {
		if(StringUtils.isEmpty(project) || StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_APPLY_RECORD WHERE PROJECT  = '" + project + "' AND ROLE= " + role + " AND APPLICANT = '" + username + "'";
		List<ProjectApplyRecordDO> list = this.getSimpleJdbcTemplate().query(sql, new ProjectApplyRecordMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

}

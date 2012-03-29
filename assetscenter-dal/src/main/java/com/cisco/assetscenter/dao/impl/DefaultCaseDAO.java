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

import com.cisco.assetscenter.dao.CaseDAO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseQuery;

public class DefaultCaseDAO extends SimpleJdbcDaoSupport implements CaseDAO {

	@Override
	public int insert(final CaseDO caseDO) {
		if(null == caseDO) {
			return 0;
		}
		final String sql = "INSERT INTO AC_CASE(NAME, DESCRIPTION, SUBMITER, GMT_CREATE, EXPECT_TIME, STATUS, TYPE_ID, TOS, GMT_FINISH, UPDATE_INFO) VALUES(?,?,?,?,?,?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, caseDO.getName());
				ps.setString(2, caseDO.getDescription());
				ps.setString(3, caseDO.getSubmiter());
				ps.setString(4, caseDO.getGmtCreate());
				ps.setString(5, caseDO.getExpectTime());
				ps.setInt(6, caseDO.getStatus());
				ps.setInt(7, caseDO.getTypeId());
				ps.setString(8, caseDO.getTos());
				ps.setString(9, caseDO.getGmtFinish());
				ps.setString(10, caseDO.getUpdateInfo());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<CaseDO> loadAllCases() {
		final String sql = "SELECT * FROM AC_CASE ORDER BY EXPECT_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new CaseMapper());
	}

	@Override
	public int getCaseTotalNums() {
		final String sql = "SELECT COUNT(ID) FROM AC_CASE";
		return this.getSimpleJdbcTemplate().queryForInt(sql);
	}

	@Override
	public List<CaseDO> loadCasesByQuery(CaseQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_CASE");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE_ID = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String titleSql = "";
		String title = query.getTitle();
		if(StringUtils.isNotBlank(title)) {
			titleSql = " NAME LIKE '%" + title + "%'";
		}
		if(StringUtils.isNotBlank(titleSql)) {
			sql.append(" AND ").append(titleSql);
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " EXPECT_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " EXPECT_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " EXPECT_TIME <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		return this.getSimpleJdbcTemplate().query(sql.toString(), new CaseMapper());
	}

	@Override
	public int deleteCaseById(final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "DELETE FROM AC_CASE WHERE ID = ?";
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
	public CaseDO loadCaseById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_CASE WHERE ID = " + id;
		List<CaseDO> list = this.getSimpleJdbcTemplate().query(sql, new CaseMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class CaseMapper implements ParameterizedRowMapper<CaseDO> {

		@Override
		public CaseDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			CaseDO caseDO = new CaseDO();
			caseDO.setId(rs.getInt("id"));
			caseDO.setName(rs.getString("name"));
			caseDO.setDescription(rs.getString("description"));
			caseDO.setTypeId(rs.getInt("type_id"));
			caseDO.setStatus(rs.getInt("status"));
			caseDO.setSubmiter(rs.getString("submiter"));
			caseDO.setGmtCreate(rs.getString("gmt_create"));
			caseDO.setExpectTime(rs.getString("expect_time"));
			caseDO.setTos(rs.getString("TOS"));
			caseDO.setGmtFinish(rs.getString("GMT_FINISH"));
			caseDO.setUpdateInfo(rs.getString("UPDATE_INFO"));
			return caseDO;
		}
		
	}

	@Override
	public int getCaseTotalNumsByQuery(CaseQuery query) {
		if(null == query) {
			return 0;
		}
		final StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_CASE");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE_ID = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String titleSql = "";
		String title = query.getTitle();
		if(StringUtils.isNotBlank(title)) {
			titleSql = " NAME LIKE '%" + title + "%'";
		}
		if(StringUtils.isNotBlank(titleSql)) {
			sql.append(" AND ").append(titleSql);
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " EXPECT_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " EXPECT_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " EXPECT_TIME <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}

	@Override
	public int updateStatus(final int id, final int status) {
		if(0 == id) {
			return 0;
		}
		final String sql = "UPDATE AC_CASE SET STATUS=? WHERE ID=?";
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
	public int update(final CaseDO caseDO) {
		if(null == caseDO) {
			return 0;
		}
		final String sql = "UPDATE AC_CASE SET STATUS=?, GMT_FINISH=?, UPDATE_INFO=?, TOS=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, caseDO.getStatus());
				ps.setString(2, caseDO.getGmtFinish());
				ps.setString(3, caseDO.getUpdateInfo());
				ps.setString(4, caseDO.getTos());
				ps.setInt(5, caseDO.getId());
				return ps;
			}});
	}

}

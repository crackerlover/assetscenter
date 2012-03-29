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
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.cisco.assetscenter.dao.CaseTypeDAO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;

import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;

public class DefaultCaseTypeDAO extends SimpleJdbcDaoSupport implements CaseTypeDAO {
	
	private PlatformTransactionManager txManager;
	@Override
	public List<CaseTypeDO> loadCaseTypes() {
		final String sql = "SELECT * FROM AC_CASE_TYPE ORDER BY NAME ASC";
		return this.getSimpleJdbcTemplate().query(sql, new CaseTypeMapper());
	}

	public List<CaseTypeDO> loadCaseTypesByQuery(CaseTypeQuery query)
	{
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_CASE_TYPE");
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
		List<CaseTypeDO> list = this.getSimpleJdbcTemplate().query(sql.toString(), new CaseTypeMapper());
		
		return list;
	}
	
	public int getTotalNumsByQuery(CaseTypeQuery query) {
		if(null == query) {
			return 0;
		}
		final StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_CASE_TYPE");
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
	public int insert(final CaseTypeDO caseType) {
		if(null == caseType) {
			return 0;
		}
		final String sql = "INSERT INTO AC_CASE_TYPE(NAME, DESCRIPTION) VALUES (?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, caseType.getName());
				ps.setString(2, caseType.getDescription());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public CaseTypeDO findCaseTypeById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_CASE_TYPE WHERE ID = " + id;
		List<CaseTypeDO> list = this.getSimpleJdbcTemplate().query(sql, new CaseTypeMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public CaseTypeDO findCaseTypeByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_CASE_TYPE WHERE NAME = '" + name + "'";
		List<CaseTypeDO> list = this.getSimpleJdbcTemplate().query(sql, new CaseTypeMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	@Override
	public int update(final CaseTypeDO caseType){
		if(null == caseType) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateCaseTypeTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int casetypeId = 0;
		final String sql = "UPDATE AC_CASE_TYPE SET NAME=?, DESCRIPTION=? WHERE ID=?";
		try {
			casetypeId = this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, caseType.getName());
					ps.setString(2, caseType.getDescription());
					ps.setInt(3, caseType.getId());
					return ps;
				}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return casetypeId;
	}
	
	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}
	
	private final class CaseTypeMapper implements ParameterizedRowMapper<CaseTypeDO> {

		@Override
		public CaseTypeDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			CaseTypeDO caseType = new CaseTypeDO();
			caseType.setId(rs.getInt("id"));
			caseType.setName(rs.getString("name"));
			caseType.setDescription(rs.getString("description"));
			return caseType;
		}
		
	}

	@Override
	public int delCaseTypeById(final int id) {
		if(0 == id) {
			return id;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("DeleteCaseTypeTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int casetypeId = 0;
		try {
			final String sql = "DELETE FROM AC_CASE_TYPE WHERE ID = ?";
			casetypeId = this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, id);
					return ps;
			}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return casetypeId;
	}

}

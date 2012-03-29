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

import com.cisco.assetscenter.dao.ProjectAssetDAO;
import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectAssetQuery;

public class DefaultProjectAssetDAO extends SimpleJdbcDaoSupport implements
		ProjectAssetDAO {

	@Override
	public int insert(final ProjectAssetDO projectAsset) {
		if(null == projectAsset) {
			return 0;
		}
		final String sql = "INSERT INTO AC_PROJECT_ASSET(PROJECT_ID, ASSET_ID, SET_TIME) VALUES (?, ?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, projectAsset.getProjectId());
				ps.setInt(2, projectAsset.getAssetId());
				ps.setString(3, projectAsset.getSetTime());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<ProjectAssetDO> loadProjectAssetByQuery(ProjectAssetQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM (SELECT AA.ID ASSET_ID, AA.SN, AA.ELTMS, AA.USER_NAME, AA.OWNER_NAME, APA.ID, APA.PROJECT_ID, APA.SET_TIME FROM AC_ASSET AA LEFT JOIN AC_PROJECT_ASSET APA ON AA.ID = APA.ASSET_ID) PA WHERE PA.USER_NAME = '" + query.getOwner() + "'");
		
		String snSql = "";
		String sn = query.getSn();
		if(StringUtils.isNotBlank(sn)) {
			snSql = " PA.SN LIKE '%" + sn + "%'";
		}
		if(StringUtils.isNotBlank(snSql)) {
			sql.append(" AND ").append(snSql);
		}
		
		String eltmsSql = "";
		String eltms = query.getEltms();
		if(StringUtils.isNotBlank(eltms)) {
			eltmsSql = " PA.ELTMS LIKE '%" + eltms + "%'";
		}
		if(StringUtils.isNotBlank(eltmsSql)) {
			sql.append(" AND ").append(eltmsSql);
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " PA.SET_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " PA.SET_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " PA.SET_TIME <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		return this.getSimpleJdbcTemplate().query(sql.toString(), new ProjectAssetMapper());
	}

	@Override
	public int getTotalNumsByQuery(ProjectAssetQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM (SELECT AA.ID ASSET_ID, AA.SN, AA.ELTMS, AA.USER_NAME, AA.OWNER_NAME, APA.ID, APA.PROJECT_ID,APA.SET_TIME FROM AC_ASSET AA LEFT JOIN AC_PROJECT_ASSET APA ON AA.ID = APA.ASSET_ID) PA WHERE PA.USER_NAME = '" + query.getOwner() + "'");
		
		String snSql = "";
		String sn = query.getSn();
		if(StringUtils.isNotBlank(sn)) {
			snSql = " PA.SN LIKE '%" + sn + "%'";
		}
		if(StringUtils.isNotBlank(snSql)) {
			sql.append(" AND ").append(snSql);
		}
		
		String eltmsSql = "";
		String eltms = query.getEltms();
		if(StringUtils.isNotBlank(eltms)) {
			eltmsSql = " PA.ELTMS LIKE '%" + eltms + "%'";
		}
		if(StringUtils.isNotBlank(eltmsSql)) {
			sql.append(" AND ").append(eltmsSql);
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " PA.SET_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " PA.SET_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " PA.SET_TIME <= '" + endTime + "'";
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
	public int updateProjectByIds(final int id, final int projectId) {
		if(0 == id || 0 == projectId) {
			return 0;
		}
		final String sql = "UPDATE AC_PROJECT_ASSET SET PROJECT_ID=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, projectId);
				ps.setInt(2, id);
				return ps;
		}});
	}

	@Override
	public int deleteProjectAssetById(final int id) {
		if(0 == id) {
			return 0;
		}
		final String sql = "DELETE FROM AC_PROJECT_ASSET WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, id);
				return ps;
		}});
	}
	
	private final class ProjectAssetMapper implements ParameterizedRowMapper<ProjectAssetDO> {

		@Override
		public ProjectAssetDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			ProjectAssetDO projectAsset = new ProjectAssetDO();
			projectAsset.setId(rs.getInt("ID"));
			projectAsset.setSn(rs.getString("SN"));
			projectAsset.setEltms(rs.getString("ELTMS"));
			projectAsset.setOwnerName(rs.getString("USER_NAME"));
			projectAsset.setAssetId(rs.getInt("ASSET_ID"));
			projectAsset.setProjectId(rs.getInt("PROJECT_ID"));
			projectAsset.setSetTime(rs.getString("SET_TIME"));
			return projectAsset;
		}
		
	}

	@Override
	public ProjectAssetDO findProjectAssetByIds(int assetId) {
		if(0 == assetId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_ASSET WHERE ASSET_ID = " + assetId;
		List<ProjectAssetDO> list = this.getSimpleJdbcTemplate().query(sql, new ProjectAssetAloneMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class ProjectAssetAloneMapper implements ParameterizedRowMapper<ProjectAssetDO> {

		@Override
		public ProjectAssetDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			ProjectAssetDO projectAsset = new ProjectAssetDO();
			projectAsset.setId(rs.getInt("ID"));
			projectAsset.setAssetId(rs.getInt("ASSET_ID"));
			projectAsset.setProjectId(rs.getInt("PROJECT_ID"));
			projectAsset.setSetTime(rs.getString("SET_TIME"));
			return projectAsset;
		}
		
	}

}

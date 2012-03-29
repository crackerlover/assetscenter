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

import com.cisco.assetscenter.dao.TeamAssetDAO;
import com.cisco.assetscenter.dao.dataobject.query.TeamAssetQuery;
import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;

public class DefaultTeamAssetDAO extends SimpleJdbcDaoSupport implements
		TeamAssetDAO {

	@Override
	public int insert(final TeamAssetDO teamAsset) {
		if(null == teamAsset) {
			return 0;
		}
		final String sql = "INSERT INTO AC_TEAM_ASSET(TEAM_ID, ASSET_ID, SET_TIME) VALUES (?, ?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, teamAsset.getTeamId());
				ps.setInt(2, teamAsset.getAssetId());
				ps.setString(3, teamAsset.getSetTime());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<TeamAssetDO> loadTeamAssetByQuery(TeamAssetQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM (SELECT AA.ID ASSET_ID, AA.SN, AA.ELTMS, AA.USER_NAME, AA.OWNER_NAME, APA.ID, APA.TEAM_ID, APA.SET_TIME FROM AC_ASSET AA LEFT JOIN AC_TEAM_ASSET APA ON AA.ID = APA.ASSET_ID) PA WHERE PA.USER_NAME = '" + query.getOwner() + "'");
		
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
		return this.getSimpleJdbcTemplate().query(sql.toString(), new TeamAssetMapper());
	}

	@Override
	public int getTotalNumsByQuery(TeamAssetQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM (SELECT AA.ID ASSET_ID, AA.SN, AA.ELTMS, AA.USER_NAME, AA.OWNER_NAME, APA.ID, APA.TEAM_ID,APA.SET_TIME FROM AC_ASSET AA LEFT JOIN AC_TEAM_ASSET APA ON AA.ID = APA.ASSET_ID) PA WHERE PA.USER_NAME = '" + query.getOwner() + "'");
		
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
	public int updateTeamByIds(final int id, final int teamId) {
		if(0 == id || 0 == teamId) {
			return 0;
		}
		final String sql = "UPDATE AC_TEAM_ASSET SET TEAM_ID=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, teamId);
				ps.setInt(2, id);
				return ps;
		}});
	}

	@Override
	public int deleteTeamAssetById(final int id) {
		if(0 == id) {
			return 0;
		}
		final String sql = "DELETE FROM AC_TEAM_ASSET WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, id);
				return ps;
		}});
	}

	private final class TeamAssetMapper implements ParameterizedRowMapper<TeamAssetDO> {

		@Override
		public TeamAssetDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			TeamAssetDO teamAsset = new TeamAssetDO();
			teamAsset.setId(rs.getInt("ID"));
			teamAsset.setSn(rs.getString("SN"));
			teamAsset.setEltms(rs.getString("ELTMS"));
			teamAsset.setOwnerName(rs.getString("USER_NAME"));
			teamAsset.setAssetId(rs.getInt("ASSET_ID"));
			teamAsset.setTeamId(rs.getInt("TEAM_ID"));
			teamAsset.setSetTime(rs.getString("SET_TIME"));
			return teamAsset;
		}
		
	}

	@Override
	public TeamAssetDO findTeamAssetByIds(int assetId) {
		if(0 == assetId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_TEAM_ASSET WHERE ASSET_ID = " + assetId;
		List<TeamAssetDO> list = this.getSimpleJdbcTemplate().query(sql, new TeamAssetAloneMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class TeamAssetAloneMapper implements ParameterizedRowMapper<TeamAssetDO> {

		@Override
		public TeamAssetDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			TeamAssetDO teamAsset = new TeamAssetDO();
			teamAsset.setId(rs.getInt("ID"));
			teamAsset.setAssetId(rs.getInt("ASSET_ID"));
			teamAsset.setTeamId(rs.getInt("TEAM_ID"));
			teamAsset.setSetTime(rs.getString("SET_TIME"));
			return teamAsset;
		}
		
	}
}

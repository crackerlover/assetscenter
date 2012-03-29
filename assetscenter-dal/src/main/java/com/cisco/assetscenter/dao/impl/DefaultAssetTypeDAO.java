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

import com.cisco.assetscenter.dao.AssetTypeDAO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetTypeQuery;

public class DefaultAssetTypeDAO extends SimpleJdbcDaoSupport implements AssetTypeDAO {
	
	private PlatformTransactionManager txManager;

	@Override
	public List<AssetTypeDO> loadAssetTypes() {
		final String sql = "SELECT * FROM AC_ASSET_TYPE ORDER BY NAME ASC";
		return this.getSimpleJdbcTemplate().query(sql, new AssetTypeMapper());
	}
	
	private final class AssetTypeMapper implements ParameterizedRowMapper<AssetTypeDO> {

		@Override
		public AssetTypeDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			AssetTypeDO assetTypeDO = new AssetTypeDO();
			assetTypeDO.setId(rs.getInt("id"));
			assetTypeDO.setName(rs.getString("name"));
			assetTypeDO.setDescription(rs.getString("description"));
			return assetTypeDO;
		}
		
	}

	@Override
	public int insert(final AssetTypeDO assetTypeDO) {
		if(null == assetTypeDO) {
			return 0;
		}
		final String sql = "INSERT INTO AC_ASSET_TYPE(NAME, DESCRIPTION) VALUES (?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, assetTypeDO.getName());
				ps.setString(2, assetTypeDO.getDescription());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public AssetTypeDO findAssetTypeById(int id) {
		if(id == 0) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET_TYPE WHERE ID = " + id;
		List<AssetTypeDO> list = this.getSimpleJdbcTemplate().query(sql, new AssetTypeMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public AssetTypeDO findAssetTypeByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET_TYPE WHERE NAME = '" + name + "'";
		List<AssetTypeDO> list = this.getSimpleJdbcTemplate().query(sql, new AssetTypeMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public  List<AssetTypeDO> loadAssetTypeByQuery(AssetTypeQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_ASSET_TYPE");
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
		List<AssetTypeDO> list = this.getSimpleJdbcTemplate().query(sql.toString(), new AssetTypeMapper());
		
		return list;
	}

	@Override
	public int getTotalNumsByQuery(AssetTypeQuery query) {
		if(null == query) {
			return 0;
		}
		final StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_ASSET_TYPE");
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
	public int update(final AssetTypeDO assetType) {
		if(null == assetType) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateAssetTypeTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int assetTypeId = 0;
		final String sql = "UPDATE AC_ASSET_TYPE SET NAME=?, DESCRIPTION=? WHERE ID=?";
		try {
			assetTypeId = this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, assetType.getName());
					ps.setString(2, assetType.getDescription());
					ps.setInt(3, assetType.getId());
					return ps;
				}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return assetTypeId;
	}

	@Override
	public int delAssetTypeById(final int id) {
		if(0 == id) {
			return id;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("DeleteAssetTypeTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int assetTypeId = 0;
		try {
			final String sql = "DELETE FROM AC_ASSET_TYPE WHERE ID = ?";
			assetTypeId = this.getJdbcTemplate().update(new PreparedStatementCreator(){

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
		return assetTypeId;
	}
	
	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}

}

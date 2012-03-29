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

import com.cisco.assetscenter.dao.TransferDAO;
import com.cisco.assetscenter.dao.dataobject.query.TransferQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;

public class DefaultTransferDAO extends SimpleJdbcDaoSupport implements
		TransferDAO {

	@Override
	public List<TransferDO> loadAllTransfers() {
		final String sql = "SELECT * FROM AC_ASSET_TRANSFER ORDER BY TRANSFER_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new TransferMapper());
	}

	@Override
	public int getTransferTotalNums(TransferQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_ASSET_TRANSFER");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String transferSql = "";
		String transfer = query.getTransfer();
		if(StringUtils.isNotBlank(transfer)) {
			transferSql = " TRANSFER LIKE '%" + transfer + "%'";
		}
		if(StringUtils.isNotBlank(transferSql)) {
			sql.append(" AND ").append(transferSql);
		}
		String receiveSql = "";
		String receive = query.getReceive();
		if(StringUtils.isNotBlank(receive)) {
			receiveSql = " RECEIVE LIKE '%" + receive + "%'";
		}
		if(StringUtils.isNotBlank(receiveSql)) {
			sql.append(" AND ").append(receiveSql);
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
	public int insert(final TransferDO transfer) {
		if(null == transfer) {
			return 0;
		}
		final String sql = "INSERT INTO AC_ASSET_TRANSFER(TRANSFER, RECEIVE, STATUS, TRANSFER_TIME, MATERIAL_ID, TYPE, EXPECT_TIME) VALUES(?,?,?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setString(1, transfer.getTransfer());
				ps.setString(2, transfer.getReceive());
				ps.setInt(3, transfer.getStatus());
				ps.setString(4, transfer.getTransferTime());
				ps.setInt(5, transfer.getMaterialId());
				ps.setInt(6, transfer.getType());
				ps.setString(7, transfer.getExpectTime());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<TransferDO> loadTransferByQuery(TransferQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_ASSET_TRANSFER");
		int status = query.getStatus();
		String statusSql = " WHERE STATUS = " + status;
		sql.append(statusSql);
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String transferSql = "";
		String transfer = query.getTransfer();
		if(StringUtils.isNotBlank(transfer)) {
			transferSql = " TRANSFER LIKE '%" + transfer + "%'";
		}
		if(StringUtils.isNotBlank(transferSql)) {
			sql.append(" AND ").append(transferSql);
		}
		String receiveSql = "";
		String receive = query.getReceive();
		if(StringUtils.isNotBlank(receive)) {
			receiveSql = " RECEIVE LIKE '%" + receive + "%'";
		}
		if(StringUtils.isNotBlank(receiveSql)) {
			sql.append(" AND ").append(receiveSql);
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
		return this.getSimpleJdbcTemplate().query(sql.toString(), new TransferMapper());
	}

	@Override
	public int updateStatus(final int status, final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "UPDATE AC_ASSET_TRANSFER SET STATUS=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, status);
				ps.setInt(2, id);
				return ps;
			}});
	}
	
	private final class TransferMapper implements ParameterizedRowMapper<TransferDO> {

		@Override
		public TransferDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			TransferDO transfer = new TransferDO();
			transfer.setId(rs.getInt("id"));
			transfer.setTransfer(rs.getString("transfer"));
			transfer.setReceive(rs.getString("receive"));
			transfer.setStatus(rs.getInt("status"));
			transfer.setTransferTime(rs.getString("transfer_time"));
			transfer.setMaterialId(rs.getInt("material_id"));
			transfer.setExpectTime(rs.getString("expect_time"));
			return transfer;
		}
		
	}

	@Override
	public int update(final TransferDO transfer) {
		if(null == transfer) {
			return 0;
		}
		final String sql = "UPDATE AC_ASSET_TRANSFER SET TRANSFER=?, RECEIVE=?, STATUS=?, TRANSFER_TIME=?, MATERIAL_ID=?, TYPE=?, EXPECT_TIME=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, transfer.getTransfer());
				ps.setString(2, transfer.getReceive());
				ps.setInt(3, transfer.getStatus());
				ps.setString(4, transfer.getTransferTime());
				ps.setInt(5, transfer.getMaterialId());
				ps.setInt(6, transfer.getType());
				ps.setString(7, transfer.getExpectTime());
				ps.setInt(8, transfer.getId());
				return ps;
			}});
	}

	@Override
	public TransferDO findTransferById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET_TRANSFER WHERE ID = " + id;
		List<TransferDO> list = this.getSimpleJdbcTemplate().query(sql, new TransferMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public TransferDO findLastedRecord(int assetId, String userName) {
		if(StringUtils.isBlank(userName) || assetId <= 0) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET_TRANSFER WHERE STATUS = 1 AND MATERIAL_ID = " + assetId + " AND RECEIVE = '" + userName + "' order by TRANSFER_TIME desc";
		List<TransferDO> list = this.getSimpleJdbcTemplate().query(sql, new TransferMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

}

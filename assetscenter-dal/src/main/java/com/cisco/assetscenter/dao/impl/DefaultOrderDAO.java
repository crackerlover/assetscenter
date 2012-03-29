package com.cisco.assetscenter.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.cisco.assetscenter.dao.OrderDAO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;

public class DefaultOrderDAO extends SimpleJdbcDaoSupport implements OrderDAO {

	private PlatformTransactionManager txManager;
	@Override
	public int insert(final OrderDO orderDO) {
		if(null == orderDO) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("InsertOrderTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		final String sql_order = "INSERT INTO AC_ORDER(NAME, DESCRIPTION, STATUS, GMT_CREATE, GMT_MODIFIED, REQUEST_NAME) VALUES(?, ?, ?, ?, ?, ?)";
		final String sql_order_asset = "INSERT INTO AC_ORDER_ASSET(ORDER_ID, TYPE_NAME, QUANTITY, EXPECT_TIME) VALUES(?, ?, ?, ?)";
		int orderId = 0;
		try {
			KeyHolder keyholder = new GeneratedKeyHolder();
			this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql_order, new String[]{"id"});
					ps.setString(1, orderDO.getName());
					ps.setString(2, orderDO.getDescription());
					ps.setInt(3, orderDO.getStatus());
					ps.setString(4, orderDO.getGmtCreate());
					ps.setString(5, orderDO.getGmtModified());
					ps.setString(6, orderDO.getRequestName());
					return ps;
				}}, keyholder);
			orderId = keyholder.getKey().intValue();
			List<OrderAssetDO> assetList = orderDO.getAssetList();
			List<Object[]> batch = new ArrayList<Object[]>();
			for(OrderAssetDO oad : assetList) {
				Object[] values = new Object[]{
						orderId,
						oad.getTypeName(),
						oad.getQuantity(),
						oad.getExpectTime()
				};
				batch.add(values);
			}
//			SqlParameterSource[] batch = SqlParameterSourceUtils.createBatch(assetList.toArray(new OrderAssetDO[]{}));
			this.getSimpleJdbcTemplate().batchUpdate(sql_order_asset, batch);
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return orderId;
	}
	

	@Override
	public List<OrderDO> loadOrderList() {
		String sql = "SELECT * FROM AC_ORDER";
		return this.getSimpleJdbcTemplate().query(sql, new OrderMapper());
	}
	

	@Override
	public List<OrderAssetDO> findOrderAssetByOrderId(int orderId) {
		if(0 == orderId) {
			return null;
		}
		String sql = "SELECT ID, ORDER_ID, TYPE_NAME, QUANTITY, EXPECT_TIME FROM AC_ORDER_ASSET WHERE ORDER_ID = :orderId ORDER BY EXPECT_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new OrderAssetMpper(), 
				new MapSqlParameterSource().addValue("orderId", orderId));
	} 
	
	@Override
	public int getOrderTotalNums() {
		String sql = "SELECT COUNT(*) FROM AC_ORDER";
		return this.getSimpleJdbcTemplate().queryForInt(sql);
	}
	
	private final class OrderMapper implements ParameterizedRowMapper<OrderDO> {

		@Override
		public OrderDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			OrderDO orderDO = new OrderDO();
			orderDO.setId(rs.getInt("id"));
			orderDO.setName(rs.getString("name"));
			orderDO.setDescription(rs.getString("description"));
			orderDO.setStatus(rs.getInt("status"));
			orderDO.setGmtCreate(rs.getString("gmt_create"));
			orderDO.setGmtModified(rs.getString("gmt_modified"));
			orderDO.setRequestName(rs.getString("request_name"));
			orderDO.setAssetList(findOrderAssetByOrderId(orderDO.getId())); 
			return orderDO;
		}
		
	}
	private final class OrderAssetMpper implements ParameterizedRowMapper<OrderAssetDO> {

		@Override
		public OrderAssetDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			OrderAssetDO orderAssetDO = new OrderAssetDO();
			orderAssetDO.setId(rs.getInt("id"));
			orderAssetDO.setOrderId(rs.getInt("order_id"));
			orderAssetDO.setTypeName(rs.getString("type_name"));
			orderAssetDO.setQuantity(rs.getInt("quantity"));
			orderAssetDO.setExpectTime(rs.getString("expect_time"));
			return orderAssetDO;
		}
		
	}
	@Override
	public List<OrderDO> loadOrderList(OrderDO orderDO) {
		if(null == orderDO) {
			return null;
		}
		String nameSql = "";
		if(StringUtils.isNotBlank(orderDO.getName())) {
			nameSql = " NAME LIKE '%" + orderDO.getName() + "%'";
		}
		String statusSql = "";
		if(-1 != orderDO.getStatus()) {
			statusSql = " STATUS = " + orderDO.getStatus();
		}
		String dateSql = "";
		if(StringUtils.isNotBlank(orderDO.getStartTime()) && StringUtils.isNotBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED BETWEEN '" + orderDO.getStartTime() + "' AND '" + orderDO.getEndTime() + "'";
		}
		if(StringUtils.isNotBlank(orderDO.getStartTime()) && StringUtils.isBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED >= '" + orderDO.getStartTime() + "'";
		}
		if(StringUtils.isBlank(orderDO.getStartTime()) && StringUtils.isNotBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED <= '" + orderDO.getEndTime() + "'";
		}
		int no = (orderDO.getPageNo() - 1) * orderDO.getPageSize();
		String  orderbySql = " ORDER BY " + orderDO.getSort() + " " + orderDO.getOrder();
		String limitSql = " LIMIT " + no + ", " + orderDO.getPageSize();
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_ORDER ");
		if(StringUtils.isEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(dateSql);
		}
		if(StringUtils.isEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(dateSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(nameSql).append(" AND ").append(dateSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(nameSql);
		}
		if(StringUtils.isEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(nameSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(nameSql).append(" AND ").append(dateSql);
		}
		sql.append(orderbySql).append(limitSql);
		return this.getSimpleJdbcTemplate().query(sql.toString(), new OrderMapper());
	}


	@Override
	public int retrieveRecordNums(OrderDO orderDO) {
		String nameSql = "";
		if(StringUtils.isNotBlank(orderDO.getName())) {
			nameSql = " NAME LIKE '%" + orderDO.getName() + "%'";
		}
		String statusSql = "";
		if(-1 != orderDO.getStatus()) {
			statusSql = " STATUS = " + orderDO.getStatus();
		}
		String dateSql = "";
		if(StringUtils.isNotBlank(orderDO.getStartTime()) && StringUtils.isNotBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED BETWEEN '" + orderDO.getStartTime() + "' AND " + "'" + orderDO.getEndTime() + "'";
		}
		if(StringUtils.isNotBlank(orderDO.getStartTime()) && StringUtils.isBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED >= '" + orderDO.getStartTime() + "'";
		}
		if(StringUtils.isBlank(orderDO.getStartTime()) && StringUtils.isNotBlank(orderDO.getEndTime())) {
			dateSql = " GMT_MODIFIED <= '" + orderDO.getEndTime() + "'";
		}
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM AC_ORDER ");
		if(StringUtils.isEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(dateSql);
		}
		if(StringUtils.isEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(dateSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(nameSql).append(" AND ").append(dateSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(nameSql);
		}
		if(StringUtils.isEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(nameSql);
		}
		if(StringUtils.isNotEmpty(nameSql) && StringUtils.isNotBlank(statusSql) && StringUtils.isNotBlank(dateSql)) {
			sql.append(" WHERE ").append(statusSql).append(" AND ").append(nameSql).append(" AND ").append(dateSql);
		}
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}


	@Override
	public int deleteOrderById(final int id) {
		if(0 == id) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("DelOrderTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		final String sql1 = "DELETE FROM AC_ORDER WHERE ID = ?";
		final String sql2 = "DELETE FROM AC_ORDER_ASSET WHERE ORDER_ID = ?";
		try {
			this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql1);
					ps.setInt(1, id);
					return ps;
			}});
			this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql2);
					ps.setInt(1, id);
					return ps;
			}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return id;
	}


	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}


	@Override
	public OrderDO findOrderById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ORDER WHERE ID = " + id;
		List<OrderDO> list = this.getSimpleJdbcTemplate().query(sql, new OrderMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}


	@Override
	public int update(final OrderDO orderDO) {
		if(null == orderDO) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateOrderTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		final String sql_order = "UPDATE AC_ORDER SET NAME=?, DESCRIPTION=?, STATUS=?, GMT_MODIFIED=?, REQUEST_NAME=? WHERE ID=?";
		final String sql_order_asset = "UPDATE AC_ORDER_ASSET SET TYPE_NAME=?, QUANTITY=?, EXPECT_TIME=? WHERE ID=?";
		try {
			this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql_order);
					ps.setString(1, orderDO.getName());
					ps.setString(2, orderDO.getDescription());
					ps.setInt(3, orderDO.getStatus());
					ps.setString(4, orderDO.getGmtModified());
					ps.setString(5, orderDO.getRequestName());
					ps.setInt(6, orderDO.getId());
					return ps;
				}});
			final List<OrderAssetDO> assetList = orderDO.getAssetList();
			List<Object[]> batch = new ArrayList<Object[]>();
			for(OrderAssetDO oad : assetList) {
				Object[] values = new Object[]{
						oad.getTypeName(),
						oad.getQuantity(),
						oad.getExpectTime(),
						oad.getId()
				};
				batch.add(values);
			}
			this.getSimpleJdbcTemplate().batchUpdate(sql_order_asset, batch);
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return orderDO.getId();
	}


	@Override
	public int[] insertOrderAssets(List<OrderAssetDO> orderAssetList) {
		if(null == orderAssetList || orderAssetList.size() == 0) {
			return null;
		}
		final String sql_order_asset = "INSERT INTO AC_ORDER_ASSET(ORDER_ID, TYPE_NAME, QUANTITY, EXPECT_TIME) VALUES(?, ?, ?, ?)";
		List<Object[]> batch = new ArrayList<Object[]>();
		for(OrderAssetDO oad : orderAssetList) {
			Object[] values = new Object[]{
					oad.getOrderId(),
					oad.getTypeName(),
					oad.getQuantity(),
					oad.getExpectTime()
			};
			batch.add(values);
		}
		return this.getSimpleJdbcTemplate().batchUpdate(sql_order_asset, batch);
	}


	@Override
	public int[] deleteOrderAssetByIds(Integer[] ids) {
		if(null == ids || ids.length == 0) {
			return null;
		}
		final String sql_order_asset = "DELETE FROM AC_ORDER_ASSET WHERE ID=?";
		List<Object[]> batch = new ArrayList<Object[]>();
		for(int id : ids) {
			Object[] values = new Object[]{
					id
			};
			batch.add(values);
		}
		return this.getSimpleJdbcTemplate().batchUpdate(sql_order_asset, batch);
	}



}

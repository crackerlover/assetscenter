package com.cisco.assetscenter.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import com.cisco.assetscenter.dao.AssetDAO;
import com.cisco.assetscenter.dao.UserDAO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;

public class DefaultAssetDAO extends SimpleJdbcDaoSupport implements AssetDAO {

	private UserDAO userDAO;
	@Override
	public List<AssetDO> loadAllAssets() {
		final String sql = "SELECT * FROM AC_ASSET ORDER BY WAREHOUSE_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
	}
	
	private final class AssetMapper implements ParameterizedRowMapper<AssetDO> {

		@Override
		public AssetDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			AssetDO asset = new AssetDO();
			asset.setId(rs.getInt("id"));
			asset.setTypeId(rs.getInt("type_id"));
			asset.setStatus(rs.getInt("status"));
			asset.setSn(rs.getString("sn"));
			asset.setDescription(rs.getString("description"));
			asset.setEltms(rs.getString("eltms"));
			asset.setOrderName(rs.getString("order_name"));
			asset.setOwnerName(rs.getString("owner_name"));
			asset.setUserName(rs.getString("user_name"));
			asset.setWarehouseTime(rs.getString("warehouse_time"));
			asset.setLocation(rs.getString("location"));
			asset.setPrice(rs.getDouble("price"));
			return asset;
		}
		
	}

	@Override
	public int getAssetTotalNums() {
		final String sql = "SELECT COUNT(ID) FROM AC_ASSET";
		return this.getSimpleJdbcTemplate().queryForInt(sql);
	}

	@Override
	public int insert(final AssetDO assetDO) {
		if(null == assetDO) {
			return 0;
		}
		final String sql = "INSERT INTO AC_ASSET(TYPE_ID, STATUS, SN, DESCRIPTION, ELTMS, ORDER_NAME, OWNER_NAME, WAREHOUSE_TIME, LOCATION, PRICE, USER_NAME) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, assetDO.getTypeId());
				ps.setInt(2, assetDO.getStatus());
				ps.setString(3, assetDO.getSn());
				ps.setString(4, assetDO.getDescription());
				ps.setString(5, assetDO.getEltms());
				ps.setString(6, assetDO.getOrderName());
				ps.setString(7, assetDO.getOwnerName());
				ps.setString(8, assetDO.getWarehouseTime());
				ps.setString(9, assetDO.getLocation());
				ps.setDouble(10, assetDO.getPrice());
				ps.setString(11, assetDO.getUserName());
				return ps;
			}}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<AssetDO> loadAssetByQuery(AssetQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = null;
		if(0 != query.getProjectId()) {
//			List<UserProjectDO> userProjects = userDAO.findUserProjectByProjectId(query.getProjectId());
//			StringBuffer buffer = new StringBuffer("");
//			if(null == userProjects || userProjects.size() < 1) {
//				return null;
//			}
//			buffer.append("(");
//			for(int i = 0; i < userProjects.size(); i ++) {
////				UserDO user = userDAO.findUserById(userProjects.get(i).getUserId());
//				buffer.append("'");
//				buffer.append(userProjects.get(i).getUsername());
//				buffer.append("'");
//				if(i != userProjects.size() - 1) {
//					buffer.append(",");
//				}
//			}
//			buffer.append(")");
//			sql = new StringBuffer("SELECT * FROM (SELECT * FROM AC_ASSET WHERE OWNER_NAME in" + buffer.toString() + ") AA ");
			sql = new StringBuffer("SELECT * FROM AC_ASSET WHERE ID IN (SELECT ASSET_ID FROM AC_PROJECT_ASSET WHERE PROJECT_ID = " + query.getProjectId() +")");
			int status = query.getStatus();
			String statusSql = " AND STATUS = " + status;
			sql.append(statusSql);
		}
		else if(0 != query.getTeamId()) {
//			List<UserTeamDO> userTeams = userDAO.findUserTeamByTeamId(query.getTeamId());
//			StringBuffer buffer = new StringBuffer("");
//			if(null == userTeams || userTeams.size() < 1) {
//				return null;
//			}
//			buffer.append("(");
//			for(int i = 0; i < userTeams.size(); i ++) {
////				UserDO user = userDAO.findUserById(userTeams.get(i).getUserId());
//				buffer.append("'");
//				buffer.append(userTeams.get(i).getUsername());
//				buffer.append("'");
//				if(i != userTeams.size() - 1) {
//					buffer.append(",");
//				}
//			}
//			buffer.append(")");
//			sql = new StringBuffer("SELECT * FROM (SELECT * FROM AC_ASSET WHERE OWNER_NAME in" + buffer.toString() + ") AA ");
			sql = new StringBuffer("SELECT * FROM AC_ASSET WHERE ID IN (SELECT ASSET_ID FROM AC_TEAM_ASSET WHERE TEAM_ID = " + query.getTeamId() +")");
			int status = query.getStatus();
			String statusSql = " AND STATUS = " + status;
			sql.append(statusSql);
		}
		else {
			sql = new StringBuffer("SELECT * FROM AC_ASSET");
			int status = query.getStatus();
			String statusSql = " WHERE STATUS = " + status;
			sql.append(statusSql);
		}
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE_ID = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String ownerSql = "";
		String owner = query.getOwnerName();
		if(StringUtils.isNotBlank(owner)) {
			ownerSql = " OWNER_NAME LIKE '%" + owner + "%'";
		}
		if(StringUtils.isNotBlank(ownerSql)) {
			sql.append(" AND ").append(ownerSql);
		}
		String snSql = "";
		String sn = query.getSn();
		if(StringUtils.isNotBlank(sn)) {
			snSql = " SN LIKE '%" + sn + "%'";
		}
		if(StringUtils.isNotBlank(snSql)) {
			sql.append(" AND ").append(snSql);
		}
		
		String eltmsSql = "";
		String eltms = query.getEltms();
		if(StringUtils.isNotBlank(eltms)) {
			eltmsSql = " ELTMS LIKE '%" + eltms + "%'";
		}
		if(StringUtils.isNotBlank(eltmsSql)) {
			sql.append(" AND ").append(eltmsSql);
		}
		String tp = query.getTp();
		if(StringUtils.isNotBlank(tp) && (tp.equalsIgnoreCase("projects") 
				|| tp.equalsIgnoreCase("teams"))) {
			String userSql = "";
			String userName = query.getUserName();
			if(StringUtils.isNotBlank(userName)) {
				userSql = " USER_NAME ='" + userName + "'";
			}
			if(StringUtils.isNotBlank(userSql)) {
				sql.append(" AND ").append(userSql);
			}
		}
		else {
			String userSql = "";
			String userName = query.getUserName();
			if(StringUtils.isNotBlank(userName)) {
				userSql = " USER_NAME ='" + userName + "' AND OWNER_NAME != '" + userName + "'";
			}
			if(StringUtils.isNotBlank(userSql)) {
				sql.append(" AND ").append(userSql);
			}
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		
		int no = (query.getPageNO() - 1) * query.getPageSize();
		String orderBySql = " ORDER BY " + query.getOrderBy() + " " + query.getSort();
		String limitSql = " LIMIT " + no + ", " + query.getPageSize();
		
		sql.append(orderBySql).append(limitSql);
		return this.getSimpleJdbcTemplate().query(sql.toString(), new AssetMapper());
	}

	@Override
	public int deleteAssetById(final int id) {
		if(0 == id) {
			return id;
		}
		final String sql = "DELETE FROM AC_ASSET WHERE ID = ?";
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
	public int update(final AssetDO asset) {
		if(null == asset) {
			return 0;
		}
		final String sql = "UPDATE AC_ASSET SET TYPE_ID=?, STATUS=?, SN=?, DESCRIPTION=?, ELTMS=?, ORDER_NAME=?, OWNER_NAME=?, WAREHOUSE_TIME=?, LOCATION=?, PRICE=?, USER_NAME=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, asset.getTypeId());
				ps.setInt(2, asset.getStatus());
				ps.setString(3, asset.getSn());
				ps.setString(4, asset.getDescription());
				ps.setString(5, asset.getEltms());
				ps.setString(6, asset.getOrderName());
				ps.setString(7, asset.getOwnerName());
				ps.setString(8, asset.getWarehouseTime());
				ps.setString(9, asset.getLocation());
				ps.setDouble(10, asset.getPrice());
				ps.setString(11, asset.getUserName());
				ps.setInt(12, asset.getId());
				return ps;
			}});
	}

	@Override
	public AssetDO loadAssetById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET WHERE ID = " + id;
		List<AssetDO> list = this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public int getAssetTotalNumsByQuery(AssetQuery query) {
		if(null == query) {
			return 0;
		}
		StringBuffer sql = null;
		if(0 != query.getProjectId()) {
//			List<UserProjectDO> userProjects = userDAO.findUserProjectByProjectId(query.getProjectId());
//			StringBuffer buffer = new StringBuffer("");
//			if(null == userProjects || userProjects.size() < 1) {
//				return null;
//			}
//			buffer.append("(");
//			for(int i = 0; i < userProjects.size(); i ++) {
////				UserDO user = userDAO.findUserById(userProjects.get(i).getUserId());
//				buffer.append("'");
//				buffer.append(userProjects.get(i).getUsername());
//				buffer.append("'");
//				if(i != userProjects.size() - 1) {
//					buffer.append(",");
//				}
//			}
//			buffer.append(")");
//			sql = new StringBuffer("SELECT * FROM (SELECT * FROM AC_ASSET WHERE OWNER_NAME in" + buffer.toString() + ") AA ");
			sql = new StringBuffer("SELECT COUNT(*) FROM AC_ASSET WHERE ID IN (SELECT ASSET_ID FROM AC_PROJECT_ASSET WHERE PROJECT_ID = " + query.getProjectId() +")");
			int status = query.getStatus();
			String statusSql = " AND STATUS = " + status;
			sql.append(statusSql);
		}
		else if(0 != query.getTeamId()) {
//			List<UserTeamDO> userTeams = userDAO.findUserTeamByTeamId(query.getTeamId());
//			StringBuffer buffer = new StringBuffer("");
//			if(null == userTeams || userTeams.size() < 1) {
//				return null;
//			}
//			buffer.append("(");
//			for(int i = 0; i < userTeams.size(); i ++) {
////				UserDO user = userDAO.findUserById(userTeams.get(i).getUserId());
//				buffer.append("'");
//				buffer.append(userTeams.get(i).getUsername());
//				buffer.append("'");
//				if(i != userTeams.size() - 1) {
//					buffer.append(",");
//				}
//			}
//			buffer.append(")");
//			sql = new StringBuffer("SELECT * FROM (SELECT * FROM AC_ASSET WHERE OWNER_NAME in" + buffer.toString() + ") AA ");
			sql = new StringBuffer("SELECT COUNT(*) FROM AC_ASSET WHERE ID IN (SELECT ASSET_ID FROM AC_TEAM_ASSET WHERE TEAM_ID = " + query.getTeamId() +")");
			int status = query.getStatus();
			String statusSql = " AND STATUS = " + status;
			sql.append(statusSql);
		}
		else {
			sql = new StringBuffer("SELECT COUNT(*) FROM AC_ASSET");
			int status = query.getStatus();
			String statusSql = " WHERE STATUS = " + status;
			sql.append(statusSql);
		}
		
		String typeSql = "";
		int type = query.getType();
		if(-1 != type) {
			typeSql = " TYPE_ID = " + type;
		}
		if(StringUtils.isNotBlank(typeSql)) {
			sql.append(" AND ").append(typeSql);
		}
		
		String ownerSql = "";
		String owner = query.getOwnerName();
		if(StringUtils.isNotBlank(owner)) {
			ownerSql = " OWNER_NAME LIKE '%" + owner + "%'";
		}
		if(StringUtils.isNotBlank(ownerSql)) {
			sql.append(" AND ").append(ownerSql);
		}
		String snSql = "";
		String sn = query.getSn();
		if(StringUtils.isNotBlank(sn)) {
			snSql = " SN LIKE '%" + sn + "%'";
		}
		if(StringUtils.isNotBlank(snSql)) {
			sql.append(" AND ").append(snSql);
		}
		
		String eltmsSql = "";
		String eltms = query.getEltms();
		if(StringUtils.isNotBlank(eltms)) {
			eltmsSql = " ELTMS LIKE '%" + eltms + "%'";
		}
		if(StringUtils.isNotBlank(eltmsSql)) {
			sql.append(" AND ").append(eltmsSql);
		}
		
		String tp = query.getTp();
		if(StringUtils.isNotBlank(tp) && (tp.equalsIgnoreCase("projects") 
				|| tp.equalsIgnoreCase("teams"))) {
			String userSql = "";
			String userName = query.getUserName();
			if(StringUtils.isNotBlank(userName)) {
				userSql = " USER_NAME ='" + userName + "'";
			}
			if(StringUtils.isNotBlank(userSql)) {
				sql.append(" AND ").append(userSql);
			}
		}
		else {
			String userSql = "";
			String userName = query.getUserName();
			if(StringUtils.isNotBlank(userName)) {
				userSql = " USER_NAME ='" + userName + "' AND OWNER_NAME != '" + userName + "'";
			}
			if(StringUtils.isNotBlank(userSql)) {
				sql.append(" AND ").append(userSql);
			}
		}
		
		String dateSql = "";
		String startTime = query.getStartTime();
		String endTime = query.getEndTime();
		if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME BETWEEN '" + startTime + "' AND '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(startTime) && StringUtils.isBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME >= '" + startTime + "'";
		}
		if(StringUtils.isBlank(startTime) && StringUtils.isNotBlank(endTime)) {
			dateSql = " WAREHOUSE_TIME <= '" + endTime + "'";
		}
		if(StringUtils.isNotBlank(dateSql)) {
			sql.append(" AND ").append(dateSql);
		}
		return this.getSimpleJdbcTemplate().queryForInt(sql.toString());
	}

	@Override
	public int[] batchInsert(List<AssetDO> list) {
		if(null == list || list.size() < 1) {
			return null;
		}
		final String sql = "INSERT INTO AC_ASSET(TYPE_ID, STATUS, SN, DESCRIPTION, ELTMS, ORDER_NAME, OWNER_NAME, WAREHOUSE_TIME, LOCATION, PRICE, USER_NAME) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		List<Object[]> batch = new ArrayList<Object[]>();
		for(AssetDO asset : list) {
			Object[] values = new Object[]{
					asset.getTypeId(),
					asset.getStatus(),
					asset.getSn(),
					asset.getDescription(),
					asset.getEltms(),
					asset.getOrderName(),
					asset.getOwnerName(),
					asset.getWarehouseTime(),
					asset.getLocation(),
					asset.getPrice(),
					asset.getUserName()
			};
			batch.add(values);
		}
		return this.getSimpleJdbcTemplate().batchUpdate(sql, batch);
	}

	@Override
	public List<AssetDO> findAssetByUserName(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET WHERE OWNER_NAME = '" + username +"' ORDER BY WAREHOUSE_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
	}

	@Override
	public List<AssetDO> findAssetByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		List<UserTeamDO> userTeams = userDAO.findUserTeamByTeamId(teamId);
		StringBuffer buffer = new StringBuffer("");
		if(null == userTeams || userTeams.size() < 1) {
			return null;
		}
		buffer.append("(");
		for(int i = 0; i < userTeams.size(); i ++) {
//			UserDO user = userDAO.findUserById(userTeams.get(i).getUserId());
			buffer.append("'");
			buffer.append(userTeams.get(i).getUsername());
			buffer.append("'");
			if(i != userTeams.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append(")");
		final String sql = "SELECT * FROM AC_ASSET WHERE OWNER_NAME in " + buffer.toString() +" ORDER BY WAREHOUSE_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
	}

	@Override
	public List<AssetDO> findAssetByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		List<UserProjectDO> userProjects = userDAO.findUserProjectByProjectId(projectId);
		StringBuffer buffer = new StringBuffer("");
		if(null == userProjects || userProjects.size() < 1) {
			return null;
		}
		buffer.append("(");
		for(int i = 0; i < userProjects.size(); i ++) {
//			UserDO user = userDAO.findUserById(userProjects.get(i).getUserId());
			buffer.append("'");
			buffer.append(userProjects.get(i).getUsername());
			buffer.append("'");
			if(i != userProjects.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append(")");
		final String sql = "SELECT * FROM AC_ASSET WHERE OWNER_NAME in " + buffer.toString() +" ORDER BY WAREHOUSE_TIME DESC";
		return this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public List<AssetDO> loadAssetByProjectQuery(AssetQuery query) {
		if(null == query) {
			return null;
		}
		return null;
	}

	@Override
	public AssetDO loadAssetBySN(String sn) {
		if(StringUtils.isEmpty(sn)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET WHERE SN = '" + sn + "'";
		List<AssetDO> list = this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public AssetDO loadAssetBySnEltms(String sn, String eltms) {
		if(StringUtils.isEmpty(sn) || StringUtils.isEmpty(eltms)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_ASSET WHERE SN = '" + sn + "'" + " AND ELTMS = '" + eltms + "'";
		List<AssetDO> list = this.getSimpleJdbcTemplate().query(sql, new AssetMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public int updateStatusById(final int id, final int status) {
		if(0 == id) {
			return 0;
		}
		final String sql = "UPDATE AC_ASSET SET STATUS=? WHERE ID=?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, status);
				ps.setInt(2, id);
				return ps;
			}});
	}

}

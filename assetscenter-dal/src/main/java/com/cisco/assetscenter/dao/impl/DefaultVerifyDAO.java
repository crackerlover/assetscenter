package com.cisco.assetscenter.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import com.cisco.assetscenter.dao.VerifyDAO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;

public class DefaultVerifyDAO extends SimpleJdbcDaoSupport implements VerifyDAO {

	@Override
	public int insert(final VerifyDO verify) {
		if(null == verify) {
			return 0;
		}
		final String sql = "INSERT INTO AC_VERIFY(USER_ID, VERIFY_STRING, STATUS, START_TIME, TYPE) VALUES (?, ?, ?, ?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, verify.getUserId());
				ps.setString(2, verify.getVerifyString());
				ps.setInt(3, verify.getStatus());
				ps.setLong(4, verify.getStartTime());
				ps.setInt(5, verify.getType());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public VerifyDO loadVerify(VerifyDO verify) {
		if(null == verify) {
			return null;
		}
		final String sql = "SELECT * FROM AC_VERIFY WHERE USER_ID = " + verify.getUserId() + " AND VERIFY_STRING = '"
				+ verify.getVerifyString() + "' AND STATUS = " + verify.getStatus() + " AND START_TIME = " + verify.getStartTime()
				+ " AND TYPE = " + verify.getType();
		List<VerifyDO> list = this.getSimpleJdbcTemplate().query(sql, new VerifyMapper());
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
			return id;
		}
		final String sql = "UPDATE AC_VERIFY SET STATUS = ? WHERE ID = ?";
		return this.getJdbcTemplate().update(new PreparedStatementCreator(){
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, status);
				ps.setInt(2, id);
				return ps;
			}});
	}
	
	private final class VerifyMapper implements ParameterizedRowMapper<VerifyDO> {

		@Override
		public VerifyDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			VerifyDO verify = new VerifyDO();
			verify.setId(rs.getInt("ID"));
			verify.setUserId(rs.getInt("USER_ID"));
			verify.setVerifyString("VERIFY_STRING");
			verify.setStatus(rs.getInt("STATUS"));
			verify.setStartTime(rs.getLong("START_TIME"));
			verify.setType(rs.getInt("TYPE"));
			return verify;
		}
		
	}

}

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

import com.cisco.assetscenter.dao.ProjectTeamDAO;
import com.cisco.assetscenter.dao.dataobject.projectteam.ProjectTeamDO;

public class DefaultProjectTeamDAO extends SimpleJdbcDaoSupport implements
		ProjectTeamDAO {

	@Override
	public int insert(final ProjectTeamDO projectTeam) {
		if(null == projectTeam) {
			return 0;
		}
		final String sql = "INSERT INTO AC_PROJECT_TEAM(PROJECT_ID, TEAM_ID) VALUES (?, ?)";
		KeyHolder keyholder = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, projectTeam.getProjectId());
				ps.setInt(2, projectTeam.getTeamId());
				return ps;
			}
			
		}, keyholder);
		return keyholder.getKey().intValue();
	}

	@Override
	public List<ProjectTeamDO> findProjectTeamByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_TEAM WHERE PROJECT_ID = " + projectId;
		return this.getSimpleJdbcTemplate().query(sql, new ProjectTeamMapper());
	}

	@Override
	public List<ProjectTeamDO> findProjectTeamByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT_TEAM WHERE TEAM_ID = " + teamId;
		return this.getSimpleJdbcTemplate().query(sql, new ProjectTeamMapper());
	}
	
	private final class ProjectTeamMapper implements ParameterizedRowMapper<ProjectTeamDO> {

		@Override
		public ProjectTeamDO mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			ProjectTeamDO projectTeam = new ProjectTeamDO();
			projectTeam.setId(rs.getInt("ID"));
			projectTeam.setProjectId(rs.getInt("PROJECT_ID"));
			projectTeam.setTeamId(rs.getInt("TEAM_ID"));
			return projectTeam;
		}
		
	}

}

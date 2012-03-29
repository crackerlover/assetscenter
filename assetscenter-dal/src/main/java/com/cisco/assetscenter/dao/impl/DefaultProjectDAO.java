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
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.cisco.assetscenter.dao.ProjectDAO;
import com.cisco.assetscenter.dao.UserDAO;
import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;

public class DefaultProjectDAO extends SimpleJdbcDaoSupport implements
		ProjectDAO {
	private UserDAO userDAO;
	private PlatformTransactionManager txManager;
	@Override
	public List<ProjectDO> loadAllProjects() {
		final String sql = "SELECT * FROM AC_PROJECT ORDER BY NAME ASC";
		List<ProjectDO> projects = this.getSimpleJdbcTemplate().query(sql, new ProjectMapper());
		if(null != projects)
		for(ProjectDO project : projects) {
			final String sql_user_project = "SELECT * FROM AC_USER_PROJECT WHERE PROJECT_ID = " + project.getId();
			List<UserProjectDO> upds = this.getSimpleJdbcTemplate().query(sql_user_project, new UserProjectMapper());
			
			List<String> managers = new ArrayList<String>();
			if(null != upds)
				for(UserProjectDO upd : upds) {
					if(upd.getRole() == Constants.PROJECT_MANAGER_ROLE)
						managers.add(upd.getUsername());
					
				}
			if(null != managers) {
				project.setManagers(managers.toArray(new String[]{}));
			}
		}
		
		return projects;
	}
	private final class UserProjectMapper implements ParameterizedRowMapper<UserProjectDO> {
		
		@Override
		public UserProjectDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserProjectDO userProject = new UserProjectDO();
			userProject.setId(rs.getInt("ID"));
			userProject.setUsername(rs.getString("USERNAME"));
			userProject.setProjectId(rs.getInt("PROJECT_ID"));
			userProject.setRole(rs.getInt("ROLE"));
			return userProject;
		}
		
	}

	@Override
	public int insert(final ProjectDO project) {
		if(null == project) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("InsertProjectTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		final String sql = "INSERT INTO AC_PROJECT(NAME, DESCRIPTION, START_TIME, END_TIME, GMT_CREATE) VALUES (?, ?, ?, ?, ?)";
		final String sql_user_project = "INSERT INTO AC_USER_PROJECT(USERNAME, PROJECT_ID, ROLE) VALUES (?, ?, ?)";
		int projectId = 0;
		try {
			KeyHolder keyholder = new GeneratedKeyHolder();
			this.getJdbcTemplate().update(new PreparedStatementCreator() {

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
					ps.setString(1, project.getName());
					ps.setString(2, project.getDescription());
					ps.setString(3, project.getStartTime());
					ps.setString(4, project.getEndTime());
					ps.setString(5, project.getGmtCreate());
					return ps;
				}
				
			}, keyholder);
			projectId = keyholder.getKey().intValue();
			String[] managers = project.getManagers();
			List<Object[]> batch = new ArrayList<Object[]>();
			if(null != managers)
				for(String manager : managers) {
					Object[] values = new Object[]{
							manager,
							projectId,
							Constants.PROJECT_MANAGER_ROLE
					};
					batch.add(values);
				}
			this.getSimpleJdbcTemplate().batchUpdate(sql_user_project, batch);
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return projectId;
	}

	@Override
	public ProjectDO findProjectById(int id) {
		if(0 == id) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT WHERE ID = " + id;
		List<ProjectDO> list = this.getSimpleJdbcTemplate().query(sql, new ProjectMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}

	@Override
	public ProjectDO findProjectByName(String name) {
		if(StringUtils.isEmpty(name)) {
			return null;
		}
		final String sql = "SELECT * FROM AC_PROJECT WHERE NAME = '" + name + "'";
		List<ProjectDO> list = this.getSimpleJdbcTemplate().query(sql, new ProjectMapper());
		if(null != list && list.size() > 0) {
			return list.get(0);
		}
		else {
			return null;
		}
	}
	
	private final class ProjectMapper implements ParameterizedRowMapper<ProjectDO> {

		@Override
		public ProjectDO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ProjectDO project = new ProjectDO();
			project.setId(rs.getInt("id"));
			project.setName(rs.getString("name"));
			project.setDescription(rs.getString("description"));
			project.setStartTime(rs.getString("start_time"));
			project.setEndTime(rs.getString("end_time"));
			project.setGmtCreate(rs.getString("gmt_create"));
			return project;
		}
		
	}

	@Override
	public List<ProjectDO> findProjectByUsername(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		final String sql = "SELECT AP.* FROM AC_PROJECT AP, AC_USER_PROJECT AUP WHERE AUP.PROJECT_ID = AP.ID AND AUP.USERNAME = '" + username + "'";
		return this.getSimpleJdbcTemplate().query(sql, new ProjectMapper());
	}

	@Override
	public List<ProjectDO> findProjectByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		final String sql = "SELECT AP.* FROM AC_PROJECT AP, AC_PROJECT_TEAM APT WHERE APT.PROJECT_ID = AP.ID AND APT.TEAM_ID = " + teamId;
		return this.getSimpleJdbcTemplate().query(sql, new ProjectMapper());
	}

	@Override
	public List<ProjectDO> loadAllProjectsByQuery(ProjectQuery query) {
		if(null == query) {
			return null;
		}
		StringBuffer sql = new StringBuffer("SELECT * FROM AC_PROJECT");
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
		List<ProjectDO> projects = this.getSimpleJdbcTemplate().query(sql.toString(), new ProjectMapper());
		for(ProjectDO project : projects) {
			final String sql_user_project = "SELECT * FROM AC_USER_PROJECT WHERE PROJECT_ID = " + project.getId();
			List<UserProjectDO> upds = this.getSimpleJdbcTemplate().query(sql_user_project, new UserProjectMapper());
			
			List<String> managers = new ArrayList<String>();
			if(null != upds)
				for(UserProjectDO upd : upds) {
					if(upd.getRole() == Constants.PROJECT_MANAGER_ROLE)
						managers.add(upd.getUsername());
					
				}
			if(null != managers) {
				project.setManagers(managers.toArray(new String[]{}));
			}
		}
		
		return projects;
	}

	@Override
	public int getTotalNumsByQuery(ProjectQuery query) {
		if(null == query) {
			return 0;
		}
		final StringBuffer sql = new StringBuffer("SELECT COUNT(ID) FROM AC_PROJECT");
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
	public int update(final ProjectDO project) {
		if(null == project) {
			return 0;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("UpdateProjectTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int projectId = 0;
		try {
			final String sql = "UPDATE AC_PROJECT SET NAME=?, DESCRIPTION=?, START_TIME=?, END_TIME=? WHERE ID=?";
			projectId = this.getJdbcTemplate().update(new PreparedStatementCreator(){
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, project.getName());
					ps.setString(2, project.getDescription());
					ps.setString(3, project.getStartTime());
					ps.setString(4, project.getEndTime());
					ps.setInt(5, project.getId());
					return ps;
				}});
			String[] managers = project.getManagers();
			if(null != managers && managers.length > 0) {
				for(String manager : managers) {
					UserProjectDO up = userDAO.findUserProjectByIds(manager, project.getId());
					if(null == up) {
						UserProjectDO upo = new UserProjectDO();
						upo.setProjectId(project.getId());
						upo.setUsername(manager);
						upo.setRole(Constants.PROJECT_MANAGER_ROLE);
						userDAO.insertUserProject(upo);
					}
				}
			}
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return projectId;
	}

	@Override
	public int delProjectById(final int id) {
		if(0 == id) {
			return id;
		}
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("DeleteProjectTransaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = txManager.getTransaction(def);
		int projectId = 0;
		try {
			final String sql = "DELETE FROM AC_PROJECT WHERE ID = ?";
			projectId = this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setInt(1, id);
					return ps;
			}});
			final String sql_project_user = "DELETE FROM AC_USER_PROJECT WHERE PROJECT_ID = ?";
			this.getJdbcTemplate().update(new PreparedStatementCreator(){

				@Override
				public PreparedStatement createPreparedStatement(Connection con)
						throws SQLException {
					PreparedStatement ps = con.prepareStatement(sql_project_user);
					ps.setInt(1, id);
					return ps;
			}});
		}catch(Exception e) {
			txManager.rollback(status);
			return 0;
		}
		txManager.commit(status);
		return projectId;
	}

	public void setTxManager(PlatformTransactionManager txManager) {
		this.txManager = txManager;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

}

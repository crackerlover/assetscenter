package com.cisco.assetscenter.dao.dataobject.user;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

/**
 * user team data object.
 * @author shuaizha
 *
 */
public class UserTeamDO extends BaseDO {

	private static final long serialVersionUID = -5663686047337412229L;

	private String username;
	private int teamId;
	private int role = 1;//default engineer role
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public String getUsername() {
		return username == null ? "" : username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}

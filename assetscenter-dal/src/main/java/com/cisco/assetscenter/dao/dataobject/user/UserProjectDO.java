package com.cisco.assetscenter.dao.dataobject.user;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

/**
 * User project data object.
 * @author shuaizha
 *
 */
public class UserProjectDO extends BaseDO {

	private static final long serialVersionUID = -3422384913935444670L;
	private String username;
	private int projectId;
	private int role = 1;//default the engineer role
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
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

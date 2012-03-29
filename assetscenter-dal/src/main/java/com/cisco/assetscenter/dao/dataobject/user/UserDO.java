package com.cisco.assetscenter.dao.dataobject.user;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

/**
 * User data object class.
 * @author shuaizha
 *
 */
public class UserDO extends BaseDO {

	private static final long serialVersionUID = -3184117772722328206L;
	
	private String username;
	private String password;
	private int role;
	private String email;
	private String fullName;
	private String gmtCreate;
	private String gmtModified;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getGmtCreate() {
		return gmtCreate;
	}
	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public String getGmtModified() {
		return gmtModified;
	}
	public void setGmtModified(String gmtModified) {
		this.gmtModified = gmtModified;
	}

}

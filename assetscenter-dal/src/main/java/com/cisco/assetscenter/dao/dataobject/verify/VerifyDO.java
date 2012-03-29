package com.cisco.assetscenter.dao.dataobject.verify;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

/**
 * verify data object class.
 * @author shuaizha
 * @date 2011-11-2
 */
public class VerifyDO extends BaseDO {

	private static final long serialVersionUID = -4229282075554443754L;

	private int userId;
	private String verifyString;
	private int status;
	private int type;
	private long startTime;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getVerifyString() {
		return verifyString;
	}
	public void setVerifyString(String verifyString) {
		this.verifyString = verifyString;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public long getStartTime() {
		return startTime;
	}
	public void setStartTime(long startTime) {
		this.startTime = startTime;
	}
}

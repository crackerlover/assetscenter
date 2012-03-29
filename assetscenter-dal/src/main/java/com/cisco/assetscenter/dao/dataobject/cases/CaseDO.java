package com.cisco.assetscenter.dao.dataobject.cases;

import com.cisco.assetscenter.dao.dataobject.BaseDO;
import com.cisco.assetscenter.dao.dataobject.Constants;

public class CaseDO extends BaseDO {

	private static final long serialVersionUID = -6873331739300653711L;

	private String name;
	private String tos;
	private String description;
	private String updateInfo;
	private String submiter;
	private String gmtCreate;
	private String gmtFinish;
	private String expectTime;
	private int status = Constants.PENDING_CASE_STATUS; // default status is pending
	private int typeId;
	public String getName() {
		return name == null ? "" : name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description == null ? "" : description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSubmiter() {
		return submiter == null ? "" : submiter;
	}
	public void setSubmiter(String submiter) {
		this.submiter = submiter;
	}
	public String getGmtCreate() {
		return gmtCreate == null ? "" : gmtCreate;
	}
	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public String getExpectTime() {
		return expectTime == null ? "" : expectTime;
	}
	public void setExpectTime(String expectTime) {
		this.expectTime = expectTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTos() {
		return tos == null ? "" : tos;
	}
	public void setTos(String tos) {
		this.tos = tos;
	}
	public String getUpdateInfo() {
		return updateInfo == null ? "" : updateInfo;
	}
	public void setUpdateInfo(String updateInfo) {
		this.updateInfo = updateInfo;
	}
	public String getGmtFinish() {
		return gmtFinish == null ? "" : gmtFinish;
	}
	public void setGmtFinish(String gmtFinish) {
		this.gmtFinish = gmtFinish;
	}
}

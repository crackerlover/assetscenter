package com.cisco.assetscenter.dao.dataobject.projectassest;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class ProjectAssetDO extends BaseDO {

	private static final long serialVersionUID = 1L;

	private String sn;
	private String eltms;
	private String ownerName;
	private int assetId;
	private int projectId;
	private String setTime;
	public String getSn() {
		return sn == null ? "" : sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getEltms() {
		return eltms == null ? "" : eltms;
	}
	public void setEltms(String eltms) {
		this.eltms = eltms;
	}
	public String getOwnerName() {
		return ownerName == null ? "" : ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public int getAssetId() {
		return assetId;
	}
	public void setAssetId(int assetId) {
		this.assetId = assetId;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getSetTime() {
		return setTime == null ? "" : setTime;
	}
	public void setSetTime(String setTime) {
		this.setTime = setTime;
	}
}

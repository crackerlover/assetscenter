package com.cisco.assetscenter.dao.dataobject.query;

import java.io.Serializable;

public class AssetQuery implements Serializable {

	private static final long serialVersionUID = 5071143468568795156L;
	
	private int status = 1;
	private int type = -1; // for all type.
	private String ownerName;
	private String userName;
	private String sn;
	private String eltms;
	private String startTime;
	private String endTime;
	private String orderBy = "WAREHOUSE_TIME"; // order by what
	private String sort = "desc";// desc/asc
	private int pageNO = 1;
	private int pageSize = 10;
	private int projectId;
	private int teamId;
	private String tp;// projects or teams
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public int getPageNO() {
		return pageNO;
	}
	public void setPageNO(int pageNO) {
		this.pageNO = pageNO;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getEltms() {
		return eltms;
	}
	public void setEltms(String eltms) {
		this.eltms = eltms;
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
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public String getUserName() {
		return userName == null ? "" : userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTp() {
		return tp;
	}
	public void setTp(String tp) {
		this.tp = tp;
	}

}

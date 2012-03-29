package com.cisco.assetscenter.dao.dataobject.query;

import java.io.Serializable;

public class ProjectAssetQuery implements Serializable {

	private static final long serialVersionUID = 1L;

	private String sn;
	private String eltms;
	private String owner;
	private String startTime;
	private String endTime;
	private String orderBy = "SET_TIME"; // order by what
	private String sort = "desc";// desc/asc
	private int pageNO = 1;
	private int pageSize = 10;
	private int projectId;
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
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
}

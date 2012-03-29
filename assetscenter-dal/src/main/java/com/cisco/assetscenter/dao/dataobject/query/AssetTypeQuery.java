package com.cisco.assetscenter.dao.dataobject.query;

import java.io.Serializable;

public class AssetTypeQuery implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4109271812009837112L;
	private String name;
	private String startTime;
	private String endTime;
	private String orderBy = "NAME"; // order by what
	private String sort = "desc";// desc/asc
	private int pageNO = 1;
	private int pageSize = 10;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
}

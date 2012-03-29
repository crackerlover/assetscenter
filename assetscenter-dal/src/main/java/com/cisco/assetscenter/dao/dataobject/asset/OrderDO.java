package com.cisco.assetscenter.dao.dataobject.asset;


import java.util.ArrayList;
import java.util.List;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class OrderDO extends BaseDO {

	private static final long serialVersionUID = -2381860736393325038L;

	private String name;
	private String description;
	private int status = -1;//0: UNFINISHED 1:FINISHED 2: PART
	private String gmtCreate;
	private String gmtModified;
	private String requestName;
	private List<OrderAssetDO> assetList;
	private String sort = "GMT_MODIFIED"; //descending order by sortName , such as id, name
	private int pageNo = 1; //default page no is 1
	private int pageSize = 10; //default page size is 10
	private String order = "desc"; // default sort order is descending.
	private int nums;// the amount of retrieve result.
	private String startTime;
	private String endTime;
	
	{
		assetList = new ArrayList<OrderAssetDO>();
	}

	public String getName() {
		return name == null ? "" : name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description == null? "" : description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}


	public List<OrderAssetDO> getAssetList() {
		return assetList;
	}

	public void setAssetList(List<OrderAssetDO> assetList) {
		this.assetList = assetList;
	}

	public String getGmtCreate() {
		return gmtCreate == null? "" : gmtCreate;
	}

	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}

	public String getGmtModified() {
		return gmtModified == null? "" : gmtModified;
	}

	public void setGmtModified(String gmtModified) {
		this.gmtModified = gmtModified;
	}

	public String getRequestName() {
		return requestName == null? "" : requestName;
	}

	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getOrder() {
		return order == null? "" : order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public int getNums() {
		return nums;
	}

	public void setNums(int nums) {
		this.nums = nums;
	}

	public String getStartTime() {
		return startTime == null? "" : startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime == null? "" : endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}

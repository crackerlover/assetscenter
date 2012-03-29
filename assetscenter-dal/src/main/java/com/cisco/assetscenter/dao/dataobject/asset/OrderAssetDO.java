package com.cisco.assetscenter.dao.dataobject.asset;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class OrderAssetDO extends BaseDO {

	private static final long serialVersionUID = 635054955805598065L;
	
	private int quantity;
	private String expectTime;
	private String typeName;
	private int orderId;
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getExpectTime() {
		return expectTime;
	}
	public void setExpectTime(String expectTime) {
		this.expectTime = expectTime;
	}

}

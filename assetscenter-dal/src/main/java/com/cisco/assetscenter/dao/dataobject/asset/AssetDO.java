package com.cisco.assetscenter.dao.dataobject.asset;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

/**
 * The asset dataobject.
 * @author shuaizha
 * @date 2011-8-22
 */
public class AssetDO extends BaseDO {

	private static final long serialVersionUID = 7693834427425747470L;

	private int status;//0:abandoned 1:used
	private String sn;
	private String eltms;
	private String orderName;
	private String ownerName;
	private String userName;
	private String description;
	private int typeId;
	private String typeName;
	private String warehouseTime;
	private double price;
	private String location;
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getSn() {
		return sn == null ? "" : sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getEltms() {
		return eltms  == null ? "" : eltms;
	}
	public void setEltms(String eltms) {
		this.eltms = eltms;
	}
	public String getOrderName() {
		return orderName  == null ? "" : orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getOwnerName() {
		return ownerName  == null ? "" : ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public String getDescription() {
		return description == null? "" : description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName == null? "" : typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getWarehouseTime() {
		return warehouseTime == null? "" : warehouseTime;
	}
	public void setWarehouseTime(String warehouseTime) {
		this.warehouseTime = warehouseTime;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getLocation() {
		return location == null ? "" : location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getUserName() {
		return userName == null ? "" : userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}

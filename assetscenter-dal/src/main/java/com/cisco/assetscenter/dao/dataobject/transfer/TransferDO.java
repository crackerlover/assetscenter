package com.cisco.assetscenter.dao.dataobject.transfer;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class TransferDO extends BaseDO {

	private static final long serialVersionUID = -4619916287539635511L;

	private String transfer;
	private String receive;
	private int status;
	private String transferTime;
	private int materialId;
	private int type;
	private String expectTime;
	public String getTransfer() {
		return transfer;
	}
	public void setTransfer(String transfer) {
		this.transfer = transfer;
	}
	public String getReceive() {
		return receive;
	}
	public void setReceive(String receive) {
		this.receive = receive;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getTransferTime() {
		return transferTime;
	}
	public void setTransferTime(String transferTime) {
		this.transferTime = transferTime;
	}
	public int getMaterialId() {
		return materialId;
	}
	public void setMaterialId(int materialId) {
		this.materialId = materialId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getExpectTime() {
		return expectTime == null ? "" : expectTime;
	}
	public void setExpectTime(String expectTime) {
		this.expectTime = expectTime;
	}
}

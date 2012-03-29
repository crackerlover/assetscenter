package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TransferQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;

public interface TransferService {

	public int createTransfer(TransferDO transfer);
	
	public int viewTransferQuantityByQuery(TransferQuery query);
	
	public boolean updateStatus(int status, int id);
	
	public boolean updateTransfer(TransferDO transfer);
	
	public List<TransferDO> viewTransfersByQuery(TransferQuery query);
	
	public TransferDO viewTransferById(int id);

	/**
	 * find the lasted transfer record.
	 * @param assetId
	 * @param userName
	 * @return
	 */
	public TransferDO findLastedRecord(int assetId, String userName);
}

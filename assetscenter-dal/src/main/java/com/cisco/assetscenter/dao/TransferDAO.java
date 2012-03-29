package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.query.TransferQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;

/**
 * transfer database access class.
 * @author shuaizha
 *
 */
public interface TransferDAO {

	/**
	 * load all transfers.
	 * @return
	 */
	public List<TransferDO> loadAllTransfers();
	
	/**
	 * get total nums by query.
	 * @param query
	 * @return
	 */
	public int getTransferTotalNums(TransferQuery query);
	
	/**
	 * insert a new transfer.
	 * @param transfer
	 * @return
	 */
	public int insert(TransferDO transfer);
	
	/**
	 * load transfer by query.
	 * @param query
	 * @return
	 */
	public List<TransferDO> loadTransferByQuery(TransferQuery query);
	
	/**
	 * update transfer status.
	 * @param status
	 * @param id
	 * @return
	 */
	public int updateStatus(int status, int id);
	
	/**
	 * update transfer.
	 * @param transfer
	 * @return
	 */
	public int update(TransferDO transfer);
	
	/**
	 * find transfer by id.
	 * @param id
	 * @return
	 */
	public TransferDO findTransferById(int id);
	
	/**
	 * find the lasted transfer record.
	 * @param assetId
	 * @param userName
	 * @return
	 */
	public TransferDO findLastedRecord(int assetId, String userName);
}

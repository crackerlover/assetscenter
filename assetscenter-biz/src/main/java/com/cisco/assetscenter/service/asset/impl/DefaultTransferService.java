package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.TransferDAO;
import com.cisco.assetscenter.dao.dataobject.query.TransferQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.service.asset.TransferService;

public class DefaultTransferService implements TransferService {

	private TransferDAO transferDAO;
	@Override
	public int createTransfer(TransferDO transfer) {
		if(null == transfer) {
			return 0;
		}
		return transferDAO.insert(transfer);
	}

	@Override
	public int viewTransferQuantityByQuery(TransferQuery query) {
		if(null == query) {
			return 0;
		}
		return transferDAO.getTransferTotalNums(query);
	}

	@Override
	public boolean updateStatus(int status, int id) {
		if(0 == id) {
			return false;
		}
		return transferDAO.updateStatus(status, id) > 0;
	}

	@Override
	public boolean updateTransfer(TransferDO transfer) {
		if(null == transfer) {
			return false;
		}
		return transferDAO.update(transfer) > 0;
	}

	@Override
	public List<TransferDO> viewTransfersByQuery(TransferQuery query) {
		if(null == query) {
			return null;
		}
		return transferDAO.loadTransferByQuery(query);
	}

	public void setTransferDAO(TransferDAO transferDAO) {
		this.transferDAO = transferDAO;
	}

	@Override
	public TransferDO viewTransferById(int id) {
		if(0 == id) {
			return null;
		}
		return transferDAO.findTransferById(id);
	}

	@Override
	public TransferDO findLastedRecord(int assetId, String userName) {
		return transferDAO.findLastedRecord(assetId, userName);
	}
	
}

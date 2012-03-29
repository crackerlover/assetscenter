package com.cisco.assetscenter.service.asset.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.AssetDAO;
import com.cisco.assetscenter.dao.TransferDAO;
import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.service.asset.AssetService;

public class DefaultAssetService implements AssetService {

	private AssetDAO assetDAO;
	private TransferDAO transferDAO;
	@Override
	public boolean createAsset(AssetDO asset) {
		if(null == asset) {
			return false;
		}
		return assetDAO.insert(asset) > 0;
	}
	public void setAssetDAO(AssetDAO assetDAO) {
		this.assetDAO = assetDAO;
	}
	@Override
	public List<AssetDO> viewAssetsByQuery(AssetQuery query) {
		if(null == query) {
			return null;
		}
		return assetDAO.loadAssetByQuery(query);
	}
	@Override
	public int viewAssetTotalQuantity() {
		return assetDAO.getAssetTotalNums();
	}
	@Override
	public boolean deleteAssetById(int id) {
		if(0 == id) {
			return false;
		}
		return assetDAO.deleteAssetById(id) > 0;
	}
	@Override
	public boolean updateAsset(AssetDO asset) {
		if(null == asset) {
			return false;
		}
		
		return assetDAO.update(asset) > 0;
	}
	@Override
	public AssetDO viewAssetById(int id) {
		if(0 == id) {
			return null;
		}
		return assetDAO.loadAssetById(id);
	}
	@Override
	public int viewAssetTotalQuantity(AssetQuery query) {
		if(null == query) {
			return 0;
		}
		return assetDAO.getAssetTotalNumsByQuery(query);
	}
	@Override
	public List<AssetDO> findAssetByUserName(String username) {
		if(StringUtils.isEmpty(username)) {
			return null;
		}
		return assetDAO.findAssetByUserName(username);
	}
	@Override
	public List<AssetDO> findAssetByTeamId(int teamId) {
		if(0 == teamId) {
			return null;
		}
		return assetDAO.findAssetByTeamId(teamId);
	}
	@Override
	public List<AssetDO> findAssetByProjectId(int projectId) {
		if(0 == projectId) {
			return null;
		}
		return assetDAO.findAssetByProjectId(projectId);
	}
	@Override
	public boolean returnAsset(int assetId, String userName) {
		if(StringUtils.isBlank(userName) || assetId <= 0) {
			return false;
		}
		TransferDO t  = transferDAO.findLastedRecord(assetId, userName);
		AssetDO asset = assetDAO.loadAssetById(assetId);
		if(null == t || null == asset) {
			return false;
		}
		asset.setUserName(t.getTransfer());
		int result = assetDAO.update(asset);
		int rs = -1;
		if(result > 0) {
			TransferDO transfer = new TransferDO();
			transfer.setReceive(asset.getUserName());
			transfer.setTransfer(t.getReceive());
			transfer.setStatus(Constants.APPROVED_TRANSFER_STATUS);
			transfer.setMaterialId(asset.getId());
			transfer.setTransferTime(convertDate2Str(new Date(), "yyyy-MM-dd"));
			transfer.setExpectTime(transfer.getTransferTime());
			rs = transferDAO.insert(transfer);
		}
		return rs > 0;
	}
	public void setTransferDAO(TransferDAO transferDAO) {
		this.transferDAO = transferDAO;
	}
	
	private String convertDate2Str(Date date, String format) {
		return new SimpleDateFormat(format).format(date);
	}
	@Override
	public AssetDO loadAssetBySnEltms(String sn, String eltms) {
		if(StringUtils.isEmpty(sn) || StringUtils.isEmpty(eltms)) {
			return null;
		}
		return assetDAO.loadAssetBySnEltms(sn, eltms);
	}
	@Override
	public List<AssetDO> loadAllAssets() {
		return assetDAO.loadAllAssets();
	}
	@Override
	public int updateStatusById(int id, int status) {
		if(0 == id) {
			return id;
		}
		return assetDAO.updateStatusById(id, status);
	}
	
}

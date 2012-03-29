package com.cisco.assetscenter.service.asset.impl;

import com.cisco.assetscenter.dao.VerifyDAO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;
import com.cisco.assetscenter.service.asset.VerifyService;

public class DefaultVerifyService implements VerifyService {

	private VerifyDAO verifyDAO;
	@Override
	public int insert(VerifyDO verify) {
		if(null == verify) {
			return 0;
		}
		return verifyDAO.insert(verify);
	}

	@Override
	public VerifyDO loadVerify(VerifyDO verify) {
		if(null == verify) {
			return null;
		}
		return verifyDAO.loadVerify(verify);
	}

	@Override
	public boolean updateStatusById(int id, int status) {
		if(0 == id) {
			return false;
		}
		return verifyDAO.updateStatusById(id, status) > 0;
	}

	public void setVerifyDAO(VerifyDAO verifyDAO) {
		this.verifyDAO = verifyDAO;
	}

}

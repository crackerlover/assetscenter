package com.cisco.assetscenter.service.asset;

import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;

public interface VerifyService {

	/**
	 * insert a verify record.
	 * @param verify
	 * @return
	 */
	public int insert(VerifyDO verify);
	
	/**
	 * load the verify record by verify data object.
	 * @param verify
	 * @return
	 */
	public VerifyDO loadVerify(VerifyDO verify);
	
	/**
	 * update the verify record status.
	 * @param id
	 * @return
	 */
	public boolean updateStatusById(int id, int status);
}

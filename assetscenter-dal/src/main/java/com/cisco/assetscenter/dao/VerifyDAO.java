package com.cisco.assetscenter.dao;

import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;

public interface VerifyDAO {

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
	public int updateStatusById(int id, int status);
}

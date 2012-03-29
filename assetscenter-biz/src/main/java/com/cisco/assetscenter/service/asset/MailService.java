package com.cisco.assetscenter.service.asset;

import com.cisco.assetscenter.dao.dataobject.mail.MailDO;

public interface MailService {

	/**
	 * provide sending mail function.
	 * @param mail
	 * @return
	 */
	public boolean sendMail(MailDO mail);
}

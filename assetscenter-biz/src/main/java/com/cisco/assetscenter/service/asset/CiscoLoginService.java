package com.cisco.assetscenter.service.asset;

public interface CiscoLoginService {

	/**
	 * check the authorization of the user in cisco domain network.
	 * @param username
	 * @param password
	 * @return
	 */
	public boolean login(String username, String password);
}

package com.cisco.assetscenter.dao.dataobject;

import java.io.Serializable;

public class Constants implements Serializable {

	private static final long serialVersionUID = -7801185476266653165L;
	
	
	/**
	 * The abandoned status asset.
	 */
	public static final int ABANDONED_ASSET_STATUS = 0x0;
	/**
	 * The used status asset.
	 */
	public static final int USED_ASSET_STATUS = 0x1;
	/**
	 * The unfinished status order.
	 */
	public static final int UNFINISHED_ORDER_STATUS = 0x0;
	/**
	 * The finished status order.
	 */
	public static final int FINISHED_ORDER_STATUS = 0x1;
	/**
	 * The part finished status order.
	 */
	public static final int PARTFINISHED_ORDER_STATUS = 0x2;
	
	/**
	 * The pending status case.
	 */
	public static final int PENDING_CASE_STATUS = 0x0;
	/**
	 * The approved status case.
	 */
	public static final int APPROVED_CASE_STATUS = 0x1;
	/**
	 * The pending status apply.
	 */
	public static final int PENDING_APPLY_PROJECT_STATUS = 0x0;
	/**
	 * The approved status apply.
	 */
	public static final int APPROVED_APPLY_PROJECT_STATUS = 0x1;
	
	/**
	 * The pending status apply.
	 */
	public static final int PENDING_APPLY_TEAM_STATUS = 0x0;
	/**
	 * The approved status apply.
	 */
	public static final int APPROVED_APPLY_TEAM_STATUS = 0x1;
	
	/**
	 * The roles of user
	 */
	public static final int VIEWER_ROLE = 0x1;
	public static final int USER_ROLE = 0x2;
	public static final int MANAGER_ROLE = 0x3;
	public static final int ADMIN_ROLE = 0x4;
	
	/**
	 * The status of user
	 */
	public static final int VALID_STATUS = 0x0;
	public static final int INVALID_STATUS = 0x1;
	
	/**
	 * The pending status transfer.
	 */
	public static final int PENDING_TRANSFER_STATUS = 0x0;
	/**
	 * The approved status transfer.
	 */
	public static final int APPROVED_TRANSFER_STATUS = 0x1;
	/**
	 * tansfer the asset between engineer and engineer
	 */
	public static final int E2E_TYPE = 0x0;
	/**
	 * the engineer borrow the asset from admin.
	 */
	public static final int E2A_TYPE = 0x1;
	/**
	 * the engineer role of the team
	 */
	public static final int TEAM_ENGINEER_ROLE = 0x1;
	/**
	 * the manager role of the team
	 */
	public static final int TEAM_MANAGER_ROLE = 0x2;
	/**
	 * the engineer role of the project
	 */
	public static final int PROJECT_ENGINEER_ROLE = 0x1;
	/**
	 * the manager role of the project
	 */
	public static final int PROJECT_MANAGER_ROLE = 0x2;
	
	public static final int ACCOUNT_VERIFY_TYPE = 0x1;
	public static final int PROJECT_VERIFY_TYPE = 0x2;
	public static final int TEAM_VERIFY_TYPE = 0x3;
	public static final int TRANSFER_ASSET_VERIFY_TYPE = 0x4;
	public static final int RETURN_ASSET_VERIFY_TYPE = 0x5;
	
	public static final int PENDING_VERIFY_STATUS = 0x0;
	public static final int APPROVED_VERIFY_STATUS = 0x1;
	
	public static final String MAIL_TEAM_TEMPLATE = "<html><body>" +
													"Hi, {$recipient}<br/><br/>" +
													"{$sender} want to join your ${name} team, please confirm it.<br/><br/>" +
													"<a href=\"http://10.74.59.247:8080/assetscenter\">eAssets System</a><br/><br/>" +
													"</body></html>";
	public static final String MAIL_PROJECT_TEMPLATE = "<html><body>" +
			"Hi, {$recipient}<br/><br/>" +
			"{$sender} want to join your ${name} project, please confirm it.<br/><br/>" +
			"<a href=\"http://10.74.59.247:8080/assetscenter\">eAssets System</a><br/><br/>" +
			"</body></html>";
	public static final String MAIL_TRANSFER_TEMPLATE = "<html><body>" +
			"Hi, {$recipient}<br/><br/>" +
			"{$receiver} want to borrow the sn:${sn} asset from {$transfer}, please confirm it.<br/><br/>" +
			"<a href=\"http://10.74.59.247:8080/assetscenter\">eAssets System</a><br/><br/>" +
			"</body></html>";
	
	public static final String EAASETS_URL = "http://10.74.59.175:8080";
	
	public static final String VERIFY_BASE_URL = "http://10.74.59.175:8080/verify.do";
//	public static final String EAASETS_URL = "http://localhost:8080";
//	
//	public static final String VERIFY_BASE_URL = "http://localhost:8080/assetscenter/verify.do";
	

}

package com.cisco.assetscenter.web.transfer;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.TransferService;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.service.asset.VerifyService;
import com.cisco.assetscenter.web.util.DateUtils;

public class TransferController implements Controller {

	protected final Logger logger = Logger.getLogger(TransferController.class);
	private AssetService assetService;
	private TransferService transferService;
	private UserService userService;
	private MailService mailService;
	private VerifyService verifyService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String expectTime = request.getParameter("expectTime");
		final String queryString = "?selectKey=&selectValue=&owner=&type=&status=&startTime=&endTime=";
		if(StringUtils.isNotEmpty(id) && StringUtils.isNotEmpty(expectTime)) {
			HttpSession session = request.getSession(false);
			if(null != session) {
				AssetDO asset = assetService.viewAssetById(Integer.parseInt(id));
				UserDO user = (UserDO)session.getAttribute("user");
				if(null != user && null != asset) {
					TransferDO transfer = new TransferDO();
					transfer.setReceive(user.getUsername());
					transfer.setTransfer(asset.getUserName());
					transfer.setStatus(Constants.PENDING_TRANSFER_STATUS);
					transfer.setMaterialId(asset.getId());
					UserDO tmp = userService.findUserByUserName(asset.getUserName());
					if(null == tmp) {
						return new ModelAndView("asset/asset_ajax", "queryString", queryString);
					}
					if(Constants.ADMIN_ROLE == tmp.getRole()) {
						transfer.setType(Constants.E2A_TYPE);
					}
					else {
						transfer.setType(Constants.E2E_TYPE);
					}
					transfer.setTransferTime("");
					transfer.setExpectTime(DateUtils.convertStr2Str(expectTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
					int success = transferService.createTransfer(transfer);
					if(success > 0) {
						//provide efficient operation
						String verifyString = UUID.randomUUID().toString();
						VerifyDO verify = new VerifyDO();
						verify.setVerifyString(verifyString);
						verify.setStatus(Constants.PENDING_VERIFY_STATUS);
						verify.setType(Constants.TRANSFER_ASSET_VERIFY_TYPE);
						verify.setUserId(user.getId());
						verify.setStartTime(System.currentTimeMillis());
						int rs = verifyService.insert(verify);
						if(rs > 0) {
							final String VERIFY_URL = Constants.VERIFY_BASE_URL + 
									"?uid=" + verify.getUserId() + "&s=" + verify.getStatus()
									+ "&t=" + verify.getType() + "&st=" + verify.getStartTime() 
									+"&oid=" + success + "&vs=" + verify.getVerifyString();
							//send an email to user
							MailDO mailT = new MailDO();
							mailT.setSender(user.getEmail());
							mailT.setRecipient(transfer.getTransfer() + "@cisco.com");
							mailT.setSubject(user.getUsername() + " want to borrow your asset");
							List<UserDO> admins = userService.findUserByRole(Constants.ADMIN_ROLE);
							String contentT = "<html><body>" +
									"Hi, " + transfer.getTransfer() + "<br/><br/>" +
									"I want to borrow the sn:" + asset.getSn() + " asset from you, <br/><br/>I will return it to you before the time: " + expectTime +
									"<br/><br/>" + "<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
									"</body></html>";
							mailT.setContent(contentT);
							mailService.sendMail(mailT);
							
							//send an email to administrator
							if(null != admins) {
								MailDO mail = new MailDO();
								mail.setSender(user.getEmail());
								mail.setRecipient(admins.get(0).getEmail());
								mail.setSubject(user.getUsername() + " Asset Transfer Record");
								String content = "";
								if(Constants.ADMIN_ROLE == tmp.getRole()) {
									content = "<html><body>" +
											"Hi, " + admins.get(0).getUsername() + "<br/><br/>" +
											user.getUsername() + " want to borrow the sn:" + asset.getSn() + " asset from " + asset.getUserName()
											+ "<br/><br/>He will return it before the time: " + expectTime
											+ ", <br/><br/>please confirm it.<br/><br/>" +
											"<br/><br/>" + 
											"You can approve request with clicking this link." + "<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
											+"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
											"</body></html>";
								}
								else {
									content = "<html><body>" +
											"Hi, " + admins.get(0).getUsername() + "<br/><br/>" +
											user.getUsername() + " want to transfer the sn:" + asset.getSn() + " asset from " + asset.getUserName()
											+ "<br/><br/>He will return it before the time: " + expectTime
											+ ", <br/><br/>please confirm it.<br/><br/>" +
											"<br/><br/>" + 
											"You can approve request with clicking this link." + "<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
											+"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
											"</body></html>";
								}
								mail.setContent(content);
								mailService.sendMail(mail);
							}
						}
						
					}
				}
			}
		}
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setVerifyService(VerifyService verifyService) {
		this.verifyService = verifyService;
	}
	

}

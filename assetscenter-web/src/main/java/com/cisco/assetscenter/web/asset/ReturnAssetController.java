package com.cisco.assetscenter.web.asset;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
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
import com.cisco.assetscenter.service.asset.VerifyService;

public class ReturnAssetController implements Controller {

	private TransferService transferService;
	private VerifyService verifyService;
	private MailService mailService;
	private AssetService assetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		HttpSession session = request.getSession(false);
		UserDO user = (UserDO)session.getAttribute("user");
		if(StringUtils.isBlank(id) || null == user) {
			return new ModelAndView("main");
		}
		TransferDO transfer  = transferService.findLastedRecord(Integer.parseInt(id), user.getUsername());
		if(null == transfer) {
			return new ModelAndView("main");
		}
		String verifyString = UUID.randomUUID().toString();
		VerifyDO verify = new VerifyDO();
		verify.setVerifyString(verifyString);
		verify.setStatus(Constants.PENDING_VERIFY_STATUS);
		verify.setType(Constants.RETURN_ASSET_VERIFY_TYPE);
		verify.setUserId(user.getId());
		verify.setStartTime(System.currentTimeMillis());
		int rs = verifyService.insert(verify);
		
		//if verify information generate success.
		//send the email.
		if(rs > 0) {
			final String VERIFY_URL = Constants.VERIFY_BASE_URL + 
					"?uid=" + verify.getUserId() + "&s=" + verify.getStatus()
					+ "&t=" + verify.getType() + "&st=" + verify.getStartTime() 
					+"&oid=" + transfer.getMaterialId() + "&vs=" + verify.getVerifyString();
			AssetDO asset = assetService.viewAssetById(transfer.getMaterialId());
			if(null == asset) {
				return new ModelAndView("main");
			}
			MailDO mail = new MailDO();
			mail.setSender(user.getEmail());
			mail.setRecipient(transfer.getTransfer() + "@cisco.com");
			mail.setSubject(user.getUsername() + " want to return your asset");
			String content = "<html><body>" +
					"Hi, " + transfer.getTransfer() + "<br/><br/>" +
					user.getUsername() + " want to return the asset[ sn : " + asset.getSn() + ", elTms : " + asset.getEltms() + " ], please confirm it.<br/><br/>" +
					"<br/><br/>" + 
					"You can approve request with clicking this link." + "<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
					+"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
					"</body></html>";
			mail.setContent(content);
			mailService.sendMail(mail);
		}
		return new ModelAndView("main");
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}
	public void setVerifyService(VerifyService verifyService) {
		this.verifyService = verifyService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}

}

package com.cisco.assetscenter.web.transfer;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.TransferService;
import com.cisco.assetscenter.web.util.DateUtils;

public class TransferEditController implements Controller {

	protected final Logger logger = Logger.getLogger(TransferEditController.class);
	private TransferService transferService;
	private AssetService assetService;
	private MailService mailService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(status)) {
			TransferDO transfer = transferService.viewTransferById(Integer.parseInt(id));
			transfer.setStatus(Integer.parseInt(status));
			if(transfer.getStatus() == Constants.APPROVED_TRANSFER_STATUS) {
				transfer.setTransferTime(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
				AssetDO asset = assetService.viewAssetById(transfer.getMaterialId());
//				asset.setOwnerName(transfer.getReceive());
				//set the current asset user.
				asset.setUserName(transfer.getReceive());
				assetService.updateAsset(asset);
			}
			boolean rs = transferService.updateTransfer(transfer);
			if(rs) {
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(transfer.getReceive() + "@cisco.com");
				mail.setSubject("Transfer operation is success. ");
				String content = "<html><body>" +
						"Hi, " + transfer.getReceive() + "<br/><br/>" +
						"Congratulations, your transfer operation is confirmed , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
		}
		final String queryString = "?transfer=&receive=&type=-1&status=&startTime=&endTime=";
		return new ModelAndView("transfer/transfer_ajax", "queryString", queryString);
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

}

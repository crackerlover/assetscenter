package com.cisco.assetscenter.web.transfer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.service.asset.TransferService;


public class TransferInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(TransferInitialController.class);
	private TransferService transferService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String method = request.getParameter("method");
		if(StringUtils.isNotEmpty(id) && StringUtils.isNotBlank(method)) {
			if("confirm".equalsIgnoreCase(method)) {
				TransferDO transfer = transferService.viewTransferById(Integer.parseInt(id));
				return new ModelAndView("transfer/confirm_transfer", "transfer", transfer);
			}
		}
		final String queryString = "?transfer=&receive=&type=-1&status=&startTime=&endTime=";
		return new ModelAndView("transfer/transfer_ajax", "queryString", queryString);
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}

}

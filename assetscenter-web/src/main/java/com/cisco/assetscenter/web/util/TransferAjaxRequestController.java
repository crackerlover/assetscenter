package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class TransferAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String transfer = request.getParameter("transfer");
		String receive = request.getParameter("receive");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		if(StringUtils.isEmpty(transfer)) {
			transfer = "";
		}
		if(StringUtils.isEmpty(receive)) {
			receive = "";
		}
		if(StringUtils.isEmpty(type)) {
			type = "-1";
		}
		if(StringUtils.isEmpty(status)) {
			status = "";
		}
		if(StringUtils.isEmpty(startTime)) {
			startTime = "";
		}
		if(StringUtils.isEmpty(endTime)) {
			endTime = "";
		}
		String queryString = "?transfer=" + transfer + "&receive=" + receive  + "&type="
				+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
		return new ModelAndView("transfer/transfer_ajax", "queryString", queryString);
	}

}

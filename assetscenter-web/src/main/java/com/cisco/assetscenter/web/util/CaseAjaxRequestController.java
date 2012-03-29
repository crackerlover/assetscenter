package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class CaseAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		if(StringUtils.isEmpty(title)) {
			title = "";
		}
		if(StringUtils.isEmpty(type)) {
			type = "";
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
		String queryString = "?title=" + title + "&type="
				+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}

}

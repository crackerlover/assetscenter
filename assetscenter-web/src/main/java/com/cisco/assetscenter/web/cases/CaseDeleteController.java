package com.cisco.assetscenter.web.cases;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.service.asset.CaseService;

public class CaseDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseDeleteController.class);
	private CaseService caseService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
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
		if(StringUtils.isNotBlank(id)) {
			caseService.deleteCaseById(Integer.parseInt(id));
		}
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}

}

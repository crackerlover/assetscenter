package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class ApplyTeamAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String applicant = request.getParameter("applicant");
		String team = request.getParameter("team");
		String role = request.getParameter("role");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		if(StringUtils.isEmpty(team)) {
			team = "";
		}
		if(StringUtils.isEmpty(applicant)) {
			applicant = "";
		}
		if(StringUtils.isEmpty(role)) {
			role = "-1";
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
		String queryString = "?applicant=" + applicant + "&team=" + team  + "&role="
				+ role + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}

}

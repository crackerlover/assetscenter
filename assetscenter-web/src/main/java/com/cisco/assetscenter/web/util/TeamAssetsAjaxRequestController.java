package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class TeamAssetsAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String selectKey = request.getParameter("selectKey");
		String selectValue = request.getParameter("selectValue");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String team = request.getParameter("team");
		if(StringUtils.isEmpty(selectKey)) {
			selectKey = "";
		}
		if(StringUtils.isEmpty(selectValue)) {
			selectValue = "";
		}
		if(StringUtils.isEmpty(startTime)) {
			startTime = "";
		}
		if(StringUtils.isEmpty(endTime)) {
			endTime = "";
		}
		if(StringUtils.isEmpty(team)) {
			team = "";
		}
		String queryString = "?selectKey=" + selectKey + "&selectValue=" + selectValue  + "&team="
				+ team + "startTime" + startTime + "&endTime=" + endTime;
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}

}

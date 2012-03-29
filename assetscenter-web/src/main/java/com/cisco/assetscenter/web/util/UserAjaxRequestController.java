package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class UserAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		if(StringUtils.isEmpty(username)) {
			username = "";
		}
		if(StringUtils.isEmpty(role)) {
			role = "";
		}
		if(StringUtils.isEmpty(startTime)) {
			startTime = "";
		}
		if(StringUtils.isEmpty(endTime)) {
			endTime = "";
		}
		String queryString = "?username=" + username + "&role=" + role +  "&startTime=" + startTime + "&endTime=" + endTime;
		return new ModelAndView("user/user_ajax", "queryString", queryString);
	}

}

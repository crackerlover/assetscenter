package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class AssetAjaxRequestController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String selectKey = request.getParameter("selectKey");
		String selectValue = request.getParameter("selectValue");
		String owner = request.getParameter("owner");
		String user = request.getParameter("user");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String projectId = request.getParameter("projectId");
		String teamId = request.getParameter("teamId");
		String tp = request.getParameter("tp");
		if(StringUtils.isEmpty(selectKey)) {
			selectKey = "";
		}
		if(StringUtils.isEmpty(selectValue)) {
			selectValue = "";
		}
		if(StringUtils.isEmpty(owner)) {
			owner = "";
		}
		if(StringUtils.isEmpty(user)) {
			user = "";
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
		if(StringUtils.isEmpty(tp)) {
			tp = "";
		}
		String queryString = "";
		if(StringUtils.isNotBlank(projectId)) {
			queryString = "?selectKey=" + selectKey + "&selectValue=" + selectValue + "&owner=" + owner + "&user=" + user + "&tp=projects" + "&type="
					+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime + "&projectId=" + projectId;
		}
		else if(StringUtils.isNotBlank(teamId)) {
			queryString = "?selectKey=" + selectKey + "&selectValue=" + selectValue + "&owner=" + owner + "&user=" + user + "&tp=projects" + "&type="
					+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime + "&teamId=" + teamId;
		}
		else {
			queryString = "?selectKey=" + selectKey + "&selectValue=" + selectValue + "&owner=" + owner + "&user=" + user + "&tp=" + tp+ "&type="
					+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
		}	
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}

}

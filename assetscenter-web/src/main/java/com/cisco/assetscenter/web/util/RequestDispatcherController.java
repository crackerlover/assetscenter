package com.cisco.assetscenter.web.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class RequestDispatcherController implements Controller {

	protected final Logger logger = Logger.getLogger(RequestDispatcherController.class);
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession vertifySession = request.getSession();
		String url = request.getParameter("url");
		String id = request.getParameter("id");
		if(null != vertifySession && !vertifySession.isNew()) {
			if(null != vertifySession.getAttribute("user")) {
				if(StringUtils.isEmpty(url)) {
					logger.error("RequestDispatcherController.handleRequest parameter url is null.");
					return new ModelAndView("login/login");
				}
				if(StringUtils.isNotBlank(id)) {
					return new ModelAndView(url, "id", id);
				}
				return new ModelAndView(url);
			}
		}
		return new ModelAndView("login/login");
	}

}

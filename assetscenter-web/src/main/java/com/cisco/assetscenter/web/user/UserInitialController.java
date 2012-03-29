package com.cisco.assetscenter.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.UserService;

public class UserInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(UserInitialController.class);
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(method)) {
			logger.error("UserInitialController.handleRequest parameter method is null.");
			return null;
		}
		if("add".equalsIgnoreCase(method)) {
			return new ModelAndView("user/add_user");
		}
		if("edit".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			UserDO user = userService.findUserById(Integer.parseInt(id));
			if(null == user) {
				return new ModelAndView("main");
			}
			return new ModelAndView("user/edit_user", "user", user);
		}
		return null;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

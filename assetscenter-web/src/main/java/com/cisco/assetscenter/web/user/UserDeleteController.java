package com.cisco.assetscenter.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.UserService;

public class UserDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(UserDeleteController.class);
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
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
		userService.deleteUserById(Integer.parseInt(id));
		HttpSession session = request.getSession();
		UserDO user  = (UserDO) session.getAttribute("user");
		if(null != user)
			logger.warn("The user [ " + user.getUsername() + " ]" + " delete user id : " + id);
		String queryString = "?username=" +username + "&role=" + role + "&startTime=" + startTime + "&endTime=" + endTime;
		return new ModelAndView("user/user_ajax", "queryString", queryString);
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

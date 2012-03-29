package com.cisco.assetscenter.web.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.web.util.DateUtils;

public class UserEditController implements Controller {

	protected final Logger logger = Logger.getLogger(UserAddController.class);
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String username = request.getParameter("username");
		String fullname = request.getParameter("fullname");
		String role = request.getParameter("role");
		UserDO user = new UserDO();
		final String queryString = "?username=&role=2&startTime=&endTime=";
		if(StringUtils.isEmpty(id)) {
			return new ModelAndView("user/user_ajax", "queryString", queryString);
		}
		user.setId(Integer.parseInt(id));
		if(StringUtils.isNotBlank(username)) {
			user.setUsername(username);
		}
		if(StringUtils.isNotBlank(fullname)) {
			user.setFullName(fullname);
		}
		if(StringUtils.isNotBlank(role)) {
			user.setRole(Integer.parseInt(role));
		}
		user.setEmail(username.trim()+"@cisco.com");
		user.setGmtModified(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
		UserDO tmp = userService.findUserByUserName(username.trim());
		UserDO tmp1 = userService.findUserById(user.getId());
		if(null == tmp || tmp.getUsername().equalsIgnoreCase(tmp1.getUsername()))
			userService.updateUser(user);
		return new ModelAndView("user/user_ajax", "queryString", queryString);
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

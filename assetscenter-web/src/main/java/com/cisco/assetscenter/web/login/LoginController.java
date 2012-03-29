package com.cisco.assetscenter.web.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.CiscoLoginService;
import com.cisco.assetscenter.service.asset.UserService;

/**
 * The eAsset system login controller.
 * @author shuaizha
 *
 */
public class LoginController implements Controller {

	public static final int SESSION_TIMEOUT = 1800;// after half an hour, the session will be invalid
//	public static final int SESSION_TIMEOUT = 60;// after half an hour, the session will be invalid
	protected final Logger logger = Logger.getLogger(LoginController.class);
	private CiscoLoginService ciscoLoginService;
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession vertifySession = request.getSession();
		if(null != vertifySession && !vertifySession.isNew()) {
			if(null != vertifySession.getAttribute("user")) {
				return new ModelAndView("main", "msg", "true");
			}
		}  
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		boolean success = false;
		if(StringUtils.isNotBlank(username) && StringUtils.isNotBlank(password)) {
			username = username.trim();
			password = password.trim();
			success = ciscoLoginService.login(username, password);
//			success = true;
		}
		if(success) {
			UserDO user = userService.findUserByUserName(username);
			if(null == user) {
				success = false;
			}
			else {
				HttpSession session = request.getSession(true);
				session.setAttribute("user", user);
				session.setMaxInactiveInterval(SESSION_TIMEOUT);
			}
		}
		return success ? new ModelAndView("main", "msg", success) : new ModelAndView("login/login", "msg", success);
	}
	public void setCiscoLoginService(CiscoLoginService ciscoLoginService) {
		this.ciscoLoginService = ciscoLoginService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

package com.cisco.assetscenter.web.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;
import com.cisco.assetscenter.service.asset.UserService;

public class AddMemberController implements Controller {

	public static final String COMMA_SPLIT = ",";
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String ids = request.getParameter("ids");
		String role = request.getParameter("role");
		if(StringUtils.isEmpty("id") || StringUtils.isEmpty(ids) 
				|| StringUtils.isEmpty(role)) {
			return new ModelAndView("main");
		}
		String[] users = ids.split(COMMA_SPLIT);
		if(null != users && users.length > 0) {
			for(String user : users) {
				UserTeamDO userTeam = new UserTeamDO();
				userTeam.setUsername(user);
				userTeam.setTeamId(Integer.parseInt(id));
				userTeam.setRole(Integer.parseInt(role));
				userService.createUserTeam(userTeam);
			}
		}
		return new ModelAndView("team/team_ajax", "queryString", "true");
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

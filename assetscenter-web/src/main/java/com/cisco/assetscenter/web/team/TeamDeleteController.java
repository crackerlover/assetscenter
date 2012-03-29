package com.cisco.assetscenter.web.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.web.project.ProjectAddController;

public class TeamDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectAddController.class);
	private TeamService teamService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)) {
			teamService.delTeamById(Integer.parseInt(id));
			HttpSession session = request.getSession();
			UserDO user  = (UserDO) session.getAttribute("user");
			if(null != user)
				logger.warn("The user [ " + user.getUsername() + " ]" + " delete team id : " + id);
		}
		String queryString = "?name=&startTime=&endTime=";
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}

}

package com.cisco.assetscenter.web.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.web.project.ProjectAddController;

public class TeamEditController implements Controller{

	protected final Logger logger = Logger.getLogger(ProjectAddController.class);
	private TeamService teamService;
	public static final String MANAGER_SPLIT = ",";
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String manager = request.getParameter("manager");
		String description = request.getParameter("description");
		TeamDO team = new TeamDO();
		if(StringUtils.isNotBlank(id)) {
			team.setId(Integer.parseInt(id));
		}
		if(StringUtils.isNotBlank(name)) {
			team.setName(name);
		}
		if(StringUtils.isNotBlank(manager)) {
			String[] managers = manager.split(MANAGER_SPLIT);
			team.setManagers(managers);
		}
		if(StringUtils.isNotBlank(description)) {
			team.setDescription(description);
		}
		teamService.update(team);
		String queryString = "?name=&startTime=&endTime=";
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}

}

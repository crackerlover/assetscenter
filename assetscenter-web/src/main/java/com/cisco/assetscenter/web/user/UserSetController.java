package com.cisco.assetscenter.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.service.asset.UserService;

public class UserSetController implements Controller {

	private UserService userService;
	private TeamService teamService;
	private ProjectService projectService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String teams = request.getParameter("teams");
		String projects = request.getParameter("projects");
		HttpSession session = request.getSession(false);
		if(null == session) {
			return new ModelAndView("login/login");
		}
		UserDO user = (UserDO)session.getAttribute("user");
		if(null == user) {
			return new ModelAndView("login/login");
		}
		if(StringUtils.isNotBlank(teams)) {
			String[] team = teams.split(",");
			for(String t : team) {
				UserTeamDO userTeam = new UserTeamDO();
				TeamDO teamTmp = teamService.findTeamByName(t);
				if(null != teamTmp) {
					int teamId = teamTmp.getId();
					if(userService.isExistUserTeam(user.getUsername(), teamId)) {
						continue;
					}
					userTeam.setTeamId(teamId);
				}
				else {
					teamTmp = new TeamDO();
					teamTmp.setName(t);
					teamTmp.setDescription(t);
					userTeam.setTeamId(teamService.createTeam(teamTmp));
				}
				userTeam.setUsername(user.getUsername());
				userService.createUserTeam(userTeam);
			}
		}
		if(StringUtils.isNotBlank(projects)) {
			String[] project = projects.split(",");
			for(String p : project) {
				UserProjectDO userProject = new UserProjectDO();
				ProjectDO projectTmp = projectService.findProjectByName(p);
				if(null != projectTmp) {
					int projectId = projectTmp.getId();
					if(userService.isExsitUserProject(user.getUsername(), projectId)) {
						continue;
					}
					userProject.setProjectId(projectId);
				}
				else {
					projectTmp = new ProjectDO();
					projectTmp.setName(p);
					projectTmp.setDescription(p);
					userProject.setProjectId(projectService.createProject(projectTmp));
				}
				userProject.setUsername(user.getUsername());
				userService.createUserProject(userProject);
			}
		}
		return new ModelAndView("user/user_ajax", "queryString", "true");
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

}

package com.cisco.assetscenter.web.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.service.asset.TeamService;

public class TreeInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(TreeInitialController.class);
	private ProjectService projectService;
	private TeamService teamService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession vertifySession = request.getSession();
		String url = request.getParameter("url");
		if(null != vertifySession && !vertifySession.isNew()) {
			UserDO user = (UserDO)vertifySession.getAttribute("user");
			if(null != user) {
				if(StringUtils.isEmpty(url)) {
					logger.error("RequestDispatcherController.handleRequest parameter url is null.");
					return new ModelAndView("login/login");
				}
				List<ProjectDO> projects = projectService.findProjectByUsername(user.getUsername());
				List<TeamDO> teams = teamService.findTeamsByUsername(user.getUsername());
				Map<String, String> map = new HashMap<String, String>();
				map.put("project_json_data", echoProjectJsonData(projects));
				map.put("team_json_data", echoTeamJsonData(teams));
				return new ModelAndView(url, "map", map);
			}
		}
		return new ModelAndView("login/login");
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	private String echoProjectJsonData(List<ProjectDO> list) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer("");
		buffer.append("\"children\":[");
		for(int i = 0;i < list.size(); i ++) {
			ProjectDO project = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(project.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(project.getName()).append("\"");
			buffer.append(",");
			buffer.append("\"iconCls\":\"icon-rss\",");
			buffer.append("\"attributes\":{\"url\":\"requestDispatcher.do?url=project/project_tree_view&id=" + project.getId() + "\"}}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}
	private String echoTeamJsonData(List<TeamDO> list) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer("");
		buffer.append("\"children\":[");
		for(int i = 0;i < list.size(); i ++) {
			TeamDO team = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(team.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(team.getName()).append("\"");
			buffer.append(",");
			buffer.append("\"iconCls\":\"icon-rss\",");
			buffer.append("\"attributes\":{\"url\":\"requestDispatcher.do?url=team/team_tree_view&id=" + team.getId() + "\"}}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}

}

package com.cisco.assetscenter.web.team;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.service.asset.TeamService;


public class TeamViewController implements Controller {

	protected final Logger logger = Logger.getLogger(TeamViewController.class);
	private TeamService teamService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		List<TeamDO> list = teamService.viewAllTeams();
		return new ModelAndView("team/team_json_data", "data", echoJsonData(list, method));
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	
	private String echoJsonData(List<TeamDO> list, String method) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		if(StringUtils.isNotBlank(method)) {
			buffer.append("{");
			buffer.append("\"id\":").append("-1");
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append("ALL").append("\"");
			buffer.append(",").append("\"selected\":true");
			buffer.append("}");
			buffer.append(",");
		}
		for(int i = 0;i < list.size(); i ++) {
			TeamDO team = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(team.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(team.getName()).append("\"");
//			if(i == 0 && StringUtils.isBlank(method)) {
//				buffer.append(",").append("\"selected\":true");
//			}
			buffer.append("}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}

}

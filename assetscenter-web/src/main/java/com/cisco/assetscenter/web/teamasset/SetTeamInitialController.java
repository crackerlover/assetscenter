package com.cisco.assetscenter.web.teamasset;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.TeamService;

public class SetTeamInitialController implements Controller {

	private TeamService teamService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		HttpSession session = request.getSession(false);
		if(null == session) {
			return new ModelAndView("login/login");
		}
		UserDO user = (UserDO)session.getAttribute("user");
		if(null == user) {
			return new ModelAndView("login/login");
		}
		List<TeamDO> teamList = teamService.findTeamsByUsername(user.getUsername());
		if(null == teamList) {
			teamList = new ArrayList<TeamDO>();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("teamList", teamList);
		return new ModelAndView("team/team_list", "map", map);
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}

}

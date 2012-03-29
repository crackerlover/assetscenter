package com.cisco.assetscenter.web.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.service.asset.TeamApplyRecordService;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.web.project.ProjectInitialController;

public class TeamInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectInitialController.class);
	private TeamService teamService;
	private TeamApplyRecordService teamApplyRecordService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(method)) {
			logger.error("CaseInitialController.handleRequest parameter method is null.");
			return null;
		}
		if("add".equalsIgnoreCase(method)) {
			return new ModelAndView("team/add_team");
		}
		if("edit".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			TeamDO team = teamService.findTeamById(Integer.parseInt(id));
			if(null == team) {
				return new ModelAndView("main");
			}
			return new ModelAndView("team/edit_team", "team", team);
		}
		if("apply".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			return new ModelAndView("team/apply_team", "id", id);
		}
		if("addMember".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			return new ModelAndView("team/add_member", "id", id);
		}
		if("confirm".equalsIgnoreCase(method)) {
			if(StringUtils.isNotBlank(id)) {
				TeamApplyRecordDO teamApplyRecordDO = teamApplyRecordService.findTeamApplyRecordById(Integer.parseInt(id));
				return new ModelAndView("team/confirm_apply", "teamApplyRecordDO", teamApplyRecordDO);
			}
		}
		return new ModelAndView("main");
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	public void setTeamApplyRecordService(
			TeamApplyRecordService teamApplyRecordService) {
		this.teamApplyRecordService = teamApplyRecordService;
	}

}

package com.cisco.assetscenter.web.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.TeamApplyRecordService;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.service.asset.UserService;

public class TeamConfirmController implements Controller {

	private TeamApplyRecordService teamApplyRecordService;
	private UserService userService;
	private TeamService teamService;
	private MailService mailService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(status)) {
			TeamApplyRecordDO teamApplyRecordDO = teamApplyRecordService.findTeamApplyRecordById(Integer.parseInt(id));
			UserTeamDO userTeam = new UserTeamDO();
			userTeam.setUsername(teamApplyRecordDO.getApplicant());
			userTeam.setRole(teamApplyRecordDO.getRole());
			TeamDO team = teamService.findTeamByName(teamApplyRecordDO.getTeam());
			if(null == team) {
				return new ModelAndView("main");
			}
			userTeam.setTeamId(team.getId());
			boolean success = teamApplyRecordService.updateStatus(Integer.parseInt(status), Integer.parseInt(id));
			if(success) {
				boolean flag  = userService.isExistUserTeam(userTeam.getUsername(), userTeam.getTeamId());
				if(!flag) {
					userService.createUserTeam(userTeam);
				}
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(userTeam.getUsername() + "@cisco.com");
				mail.setSubject("You have joined the Team " + team.getName());
				String content = "<html><body>" +
						"Hi, " + userTeam.getUsername() + "<br/><br/>" +
						"Congratulations, you have joined the team:" + team.getName() + " , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
		}
		return new ModelAndView("team/team_ajax", "queryString", "?applicant=&team=&role=-1&status=&startTime=&endTime=");
	}
	public void setTeamApplyRecordService(
			TeamApplyRecordService teamApplyRecordService) {
		this.teamApplyRecordService = teamApplyRecordService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

}

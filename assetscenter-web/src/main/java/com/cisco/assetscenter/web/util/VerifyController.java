package com.cisco.assetscenter.web.util;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserTeamDO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.ProjectApplyRecordService;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.service.asset.TeamApplyRecordService;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.service.asset.TransferService;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.service.asset.VerifyService;

public class VerifyController implements Controller {

	protected final Logger logger = Logger.getLogger(VerifyController.class);
	private VerifyService verifyService;
	private ProjectApplyRecordService projectApplyRecordService;
	private TeamApplyRecordService teamApplyRecordService;
	private ProjectService projectService;
	private TeamService teamService;
	private MailService mailService;
	private UserService userService;
	private AssetService assetService;
	private TransferService transferService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String uid = request.getParameter("uid");//for register, uid is fullname, oid is role
		String s = request.getParameter("s");
		String t = request.getParameter("t");
		String st = request.getParameter("st");
		String vs = request.getParameter("vs");
		String oid = request.getParameter("oid");// other id, such project apply record id, etc.
		if(StringUtils.isEmpty(uid) || StringUtils.isEmpty(s) ||
				StringUtils.isEmpty(t) || StringUtils.isEmpty(st) ||
				StringUtils.isEmpty(vs) || StringUtils.isEmpty(oid)) {
			return null;
		}
		int type = Integer.parseInt(t);
		VerifyDO verify = new VerifyDO();
		verify.setUserId(Integer.parseInt(uid));
		verify.setStatus(Integer.parseInt(s));
		verify.setStartTime(Long.parseLong(st));
		verify.setType(Integer.parseInt(t));
		verify.setVerifyString(vs);
		VerifyDO tmp = verifyService.loadVerify(verify);
		if(null == tmp) {
			return null;
		}
		//update the status of the verify information
		boolean success = verifyService.updateStatusById(tmp.getId(), Constants.APPROVED_VERIFY_STATUS);
		if(!success) {
			return null;
		}
		int id = Integer.parseInt(oid);
		switch(type) {
		case Constants.PROJECT_VERIFY_TYPE:{
			//project type
			//return project sucess page.
			
			//update the apply status
			ProjectApplyRecordDO projectApplyRecord = projectApplyRecordService.findProjectApplyRecordById(id);
			UserProjectDO userProject = new UserProjectDO();
			userProject.setUsername(projectApplyRecord.getApplicant());
			userProject.setRole(projectApplyRecord.getRole());
			ProjectDO project = projectService.findProjectByName(projectApplyRecord.getProject());
			if(null == project) {
				return new ModelAndView("main");
			}
			userProject.setProjectId(project.getId());
			boolean rs = projectApplyRecordService.updateStatus(Constants.APPROVED_APPLY_PROJECT_STATUS, id);
			if(rs) {
				boolean flag = userService.isExsitUserProject(userProject.getUsername(), userProject.getProjectId());
				if(!flag) {
					userService.createUserProject(userProject);
				}
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(userProject.getUsername() + "@cisco.com");
				mail.setSubject("You have joined the Project " + project.getName());
				String content = "<html><body>" +
						"Hi, " + userProject.getUsername() + "<br/><br/>" +
						"Congratulations, you have joined the project:" + project.getName() + " , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
				return new ModelAndView("message/msg");
			}
			return new ModelAndView("main");
		}
		case Constants.ACCOUNT_VERIFY_TYPE:{
			//account type
			String username = request.getParameter("un");
			String fullname = request.getParameter("fn");
			if(StringUtils.isBlank(username)) {
				return new ModelAndView("main");
			}
			UserDO tmpDO = userService.findUserByUserName(username);
			if(null != tmpDO){
				return new ModelAndView("main");
			}
			UserDO userDO = new UserDO();
			userDO.setUsername(username.trim());
			userDO.setFullName(fullname);
			userDO.setRole(Integer.parseInt(oid)); //defaultRole is viewer
			userDO.setPassword("");
			userDO.setEmail(username.trim()+"@cisco.com");
			userDO.setGmtCreate(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
			userDO.setGmtModified(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));

			boolean rs = userService.createUser(userDO);
			if(rs) {
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(userDO.getEmail());
				mail.setSubject("Your account can login the eAssets system now");
				String content = "<html><body>" +
						"Hi, " + userDO.getUsername() + "<br/><br/>" +
						"Congratulations, Your account can login the eAssets system now , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
			//send email to the manager if user applied when registered			
			return new ModelAndView("message/msg");
		}
		case Constants.TEAM_VERIFY_TYPE: {
			//team type
			TeamApplyRecordDO teamApplyRecord = teamApplyRecordService.findTeamApplyRecordById(id);
			UserTeamDO userTeam = new UserTeamDO();
			userTeam.setUsername(teamApplyRecord.getApplicant());
			userTeam.setRole(teamApplyRecord.getRole());
			TeamDO team = teamService.findTeamByName(teamApplyRecord.getTeam());
			if(null == team) {
				return new ModelAndView("main");
			}
			userTeam.setTeamId(team.getId());
			
			boolean rs = teamApplyRecordService.updateStatus(Constants.APPROVED_APPLY_TEAM_STATUS, id);
			if(rs) {
				boolean flag = userService.isExistUserTeam(userTeam.getUsername(), userTeam.getTeamId());
				if(!flag) {
					userService.createUserTeam(userTeam);
				}
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(userTeam.getUsername() + "@cisco.com");
				mail.setSubject("You have joined the team " + team.getName());
				String content = "<html><body>" +
						"Hi, " + userTeam.getUsername() + "<br/><br/>" +
						"Congratulations, you have joined the team:" + team.getName() + " , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
				return new ModelAndView("message/msg");
			}
			return new ModelAndView("main");
		}
		case Constants.RETURN_ASSET_VERIFY_TYPE: {
			UserDO user = userService.findUserById(Integer.parseInt(uid));
			boolean rs = assetService.returnAsset(Integer.parseInt(oid), user.getUsername());
			if(rs) {
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(user.getEmail());
				mail.setSubject("Return operation is success. ");
				String content = "<html><body>" +
						"Hi, " + user.getUsername() + "<br/><br/>" +
						"Congratulations, your return operation is success , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
				return new ModelAndView("message/msg");
			}
			return new ModelAndView("main");
		}
		case Constants.TRANSFER_ASSET_VERIFY_TYPE: {
			UserDO user = userService.findUserById(Integer.parseInt(uid));
			
			boolean rs = transferService.updateStatus(Constants.APPROVED_TRANSFER_STATUS, id);
			if(rs) {
				TransferDO transfer = transferService.viewTransferById(id);
				if(transfer.getStatus() == Constants.APPROVED_TRANSFER_STATUS) {
					transfer.setTransferTime(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
					AssetDO asset = assetService.viewAssetById(transfer.getMaterialId());
//					asset.setOwnerName(transfer.getReceive());
					//set the current asset user.
					asset.setUserName(transfer.getReceive());
					assetService.updateAsset(asset);
				}
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(user.getEmail());
				mail.setSubject("transfer operation is success. ");
				String content = "<html><body>" +
						"Hi, " + user.getUsername() + "<br/><br/>" +
						"Congratulations, your transfer operation is confirmed , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
				return new ModelAndView("message/msg");
			}
			return new ModelAndView("main");
		}
		default:
			return new ModelAndView("main");
		}
	}
	public void setVerifyService(VerifyService verifyService) {
		this.verifyService = verifyService;
	}
	public void setProjectApplyRecordService(
			ProjectApplyRecordService projectApplyRecordService) {
		this.projectApplyRecordService = projectApplyRecordService;
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setTeamApplyRecordService(
			TeamApplyRecordService teamApplyRecordService) {
		this.teamApplyRecordService = teamApplyRecordService;
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}

}

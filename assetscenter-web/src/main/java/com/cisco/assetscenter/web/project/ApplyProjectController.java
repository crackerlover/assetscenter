package com.cisco.assetscenter.web.project;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.ProjectApplyRecordService;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.service.asset.VerifyService;
import com.cisco.assetscenter.web.util.DateUtils;

public class ApplyProjectController implements Controller {

	protected final Logger logger = Logger.getLogger(ApplyProjectController.class);
	private ProjectService projectService;
	private ProjectApplyRecordService projectApplyRecordService;
	private MailService mailService;
	private UserService userService;
	private VerifyService verifyService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String role = request.getParameter("role");
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(role)) {
			ProjectApplyRecordDO projectApplyRecord = new ProjectApplyRecordDO();
			HttpSession session = request.getSession(false);
			if(null == session) {
				return new ModelAndView("login/login");
			}
			UserDO user = (UserDO)session.getAttribute("user");
			if(null == user) {
				return new ModelAndView("login/login");
			}
			projectApplyRecord.setApplicant(user.getUsername());
			ProjectDO project = projectService.findProjectById(Integer.parseInt(id));
			if(null == project) {
				return new ModelAndView("main");
			}
			projectApplyRecord.setProject(project.getName());
			projectApplyRecord.setRole(Integer.parseInt(role));
			projectApplyRecord.setApplyTime(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
			projectApplyRecord.setStatus(Constants.PENDING_APPLY_PROJECT_STATUS);
			ProjectApplyRecordDO tmp = projectApplyRecordService.findProjectApplyRecordByIdUserRole(project.getName(), user.getUsername(), Integer.parseInt(role));
			//checking whether the project apply record has already existed.
			if(null == tmp) {
				int record = projectApplyRecordService.insert(projectApplyRecord);
				if(record > 0) {
					//if project apply record insert success
					//will generate the verify information
					String verifyString = UUID.randomUUID().toString();
					VerifyDO verify = new VerifyDO();
					verify.setVerifyString(verifyString);
					verify.setStatus(Constants.PENDING_VERIFY_STATUS);
					verify.setType(Constants.PROJECT_VERIFY_TYPE);
					verify.setUserId(user.getId());
					verify.setStartTime(System.currentTimeMillis());
					int rs = verifyService.insert(verify);
					
					//if verify information generate success.
					//send the email.
					if(rs > 0) {
						final String VERIFY_URL = Constants.VERIFY_BASE_URL + 
								"?uid=" + verify.getUserId() + "&s=" + verify.getStatus()
								+ "&t=" + verify.getType() + "&st=" + verify.getStartTime() 
								+"&oid=" + record + "&vs=" + verify.getVerifyString();
						
						//get the manager of the selected project
//						List<ProjectApplyRecordDO> managerList = projectApplyRecordService.findProjectApplyRecordByIdRole(project.getId(), Constants.PROJECT_MANAGER_ROLE);
						List<UserProjectDO> managerList = userService.findUserProjectByProjectRole(project.getId(), Constants.PROJECT_MANAGER_ROLE);
						if(null == managerList || managerList.size() <= 0) {
							List<UserDO> admins = userService.findUserByRole(Constants.ADMIN_ROLE);
							if(null != admins) {
								MailDO mail = new MailDO();
								mail.setSender(user.getEmail());
								mail.setRecipient(admins.get(0).getEmail());
								String roleStr = "";
								if(Integer.parseInt(role) == Constants.PROJECT_ENGINEER_ROLE) {
									roleStr = "ENGINEER";
								}
								if(Integer.parseInt(role) == Constants.PROJECT_MANAGER_ROLE) {
									roleStr = "MANAGER";
								}
								mail.setSubject(user.getUsername() + " apply to join the Project " + project.getName());
								String content = "<html><body>" +
										"Hi, " + admins.get(0).getUsername() + "<br/><br/>" +
										user.getUsername() + " want to join the project:" + project.getName() + " as " + roleStr + " role, please confirm it.<br/><br/>" +
										"<br/><br/>" + 
										"You can approve request with clicking this link." + "<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
										+"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
										"</body></html>";
								mail.setContent(content);
								mailService.sendMail(mail);
							}
						}
						else {
							MailDO mail = new MailDO();
							mail.setSender(user.getEmail());
							mail.setRecipient((managerList.get(0)).getUsername() + "@cisco.com");
							String roleStr = "";
							if(Integer.parseInt(role) == Constants.PROJECT_ENGINEER_ROLE) {
								roleStr = "ENGINEER";
							}
							if(Integer.parseInt(role) == Constants.PROJECT_MANAGER_ROLE) {
								roleStr = "MANAGER";
							}
							mail.setSubject(user.getUsername() + " apply to join the Project " + project.getName());
							String content = "<html><body>" +
									"Hi, " + managerList.get(0).getUsername() + "<br/><br/>" +
									user.getUsername() + " want to join the project:" + project.getName() + " as " + roleStr + " role, please confirm it.<br/><br/>" +
									"<br/><br/>" + 
									"You can approve request with clicking this link." + "<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
									+"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
									"</body></html>";
							mail.setContent(content);
							mailService.sendMail(mail);
						}
					}
				}
			}
		}
		return new ModelAndView("project/project_ajax", "queryString", "true");
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public void setProjectApplyRecordService(
			ProjectApplyRecordService projectApplyRecordService) {
		this.projectApplyRecordService = projectApplyRecordService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setVerifyService(VerifyService verifyService) {
		this.verifyService = verifyService;
	}

}

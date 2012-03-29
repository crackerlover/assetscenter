package com.cisco.assetscenter.web.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.ProjectApplyRecordService;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.service.asset.UserService;

public class ProjectConfirmController implements Controller {

	private ProjectApplyRecordService projectApplyRecordService;
	private UserService userService;
	private ProjectService projectService;
	private MailService mailService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(status)) {
			ProjectApplyRecordDO projectApplyRecord = projectApplyRecordService.
					findProjectApplyRecordById(Integer.parseInt(id));
			UserProjectDO userProject = new UserProjectDO();
			userProject.setUsername(projectApplyRecord.getApplicant());
			userProject.setRole(projectApplyRecord.getRole());
			ProjectDO project = projectService.findProjectByName(
					projectApplyRecord.getProject());
			if(null == project) {
				return new ModelAndView("main");
			}
			userProject.setProjectId(project.getId());
			boolean success = projectApplyRecordService.updateStatus(
					Integer.parseInt(status), Integer.parseInt(id));
			if(success) {
				boolean flag = userService.isExsitUserProject(
						userProject.getUsername(), userProject.getProjectId());
				if(!flag) {
					userService.createUserProject(userProject);
				}
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(userProject.getUsername() + "@cisco.com");
				mail.setSubject("You have joined the Project " + 
															project.getName());
				String content = "<html><body>" +
						"Hi, " + userProject.getUsername() + "<br/><br/>" +
						"Congratulations, you have joined the project:" + 
						project.getName() + " , please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + 
						">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
		}
		return new ModelAndView("project/project_ajax", "queryString", 
				"?applicant=&project=&role=-1&status=&startTime=&endTime=");
	}
	public void setProjectApplyRecordService(
			ProjectApplyRecordService projectApplyRecordService) {
		this.projectApplyRecordService = projectApplyRecordService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

}

package com.cisco.assetscenter.web.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.service.asset.ProjectApplyRecordService;
import com.cisco.assetscenter.service.asset.ProjectService;


public class ProjectInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectInitialController.class);
	private ProjectService projectService;
	private ProjectApplyRecordService projectApplyRecordService;
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
			return new ModelAndView("project/add_project");
		}
		if("edit".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			ProjectDO project = projectService.findProjectById(Integer.parseInt(id));
			if(null == project) {
				return new ModelAndView("main");
			}
			return new ModelAndView("project/edit_project", "project", project);
		}
		if("apply".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			return new ModelAndView("project/apply_project", "id", id);
		}
		if("addMember".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			return new ModelAndView("project/add_member", "id", id);
		}
		if("confirm".equalsIgnoreCase(method)) {
			if(StringUtils.isNotBlank(id)) {
				ProjectApplyRecordDO projectApplyRecord = projectApplyRecordService.findProjectApplyRecordById(Integer.parseInt(id));
				return new ModelAndView("project/confirm_apply", "projectApplyRecord", projectApplyRecord);
			}
		}
		
		return new ModelAndView("main");
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	public void setProjectApplyRecordService(
			ProjectApplyRecordService projectApplyRecordService) {
		this.projectApplyRecordService = projectApplyRecordService;
	}

}

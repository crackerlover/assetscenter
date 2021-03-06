package com.cisco.assetscenter.web.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.web.util.DateUtils;

public class ProjectEditController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectEditController.class);
	private ProjectService projectService;
	public static final String MANAGER_SPLIT = ",";
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String manager = request.getParameter("manager");
		String startTime = request.getParameter("START_TIME");
		String endTime = request.getParameter("END_TIME");
		String description = request.getParameter("description");
		ProjectDO project = new ProjectDO();
		if(StringUtils.isNotBlank(id)) {
			project.setId(Integer.parseInt(id));
		}
		if(StringUtils.isNotBlank(manager)) {
			String[] managers = manager.split(MANAGER_SPLIT);
			project.setManagers(managers);
		}
		if(StringUtils.isNotBlank(name)) {
			project.setName(name);
		}
		if(StringUtils.isNotBlank(description)) {
			project.setDescription(description);
		}
		if(StringUtils.isNotBlank(startTime)) {
			project.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			project.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		projectService.update(project);
		String queryString = "?name=&startTime=&endTime=";
		return new ModelAndView("project/project_ajax", "queryString", queryString);
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

}

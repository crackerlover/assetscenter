package com.cisco.assetscenter.web.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.ProjectService;

public class ProjectDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectAddController.class);
	private ProjectService projectService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)) {
			projectService.delProjectById(Integer.parseInt(id));
			HttpSession session = request.getSession();
			UserDO user  = (UserDO) session.getAttribute("user");
			if(null != user)
				logger.warn("The user [ " + user.getUsername() + " ]" + " delete project id : " + id);
		}
		String queryString = "?name=&startTime=&endTime=";
		return new ModelAndView("project/project_ajax", "queryString", queryString);
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

}

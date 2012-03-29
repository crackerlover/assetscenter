package com.cisco.assetscenter.web.projectasset;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.ProjectService;

public class SetProjectInitialController implements Controller {

	private ProjectService projectService;
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
		List<ProjectDO> projectList = projectService.findProjectByUsername(user.getUsername());
		if(null == projectList) {
			projectList = new ArrayList<ProjectDO>();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("projectList", projectList);
		return new ModelAndView("project/project_list", "map", map);
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

}

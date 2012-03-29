package com.cisco.assetscenter.web.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserProjectDO;
import com.cisco.assetscenter.service.asset.UserService;

public class AddProjectController implements Controller {

	public static final String COMMA_SPLIT = ",";
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String ids = request.getParameter("ids");
		String role = request.getParameter("role");
		if(StringUtils.isEmpty("id") || StringUtils.isEmpty(ids) 
				|| StringUtils.isEmpty(role)) {
			return new ModelAndView("main");
		}
		String[] users = ids.split(COMMA_SPLIT);
		if(null != users && users.length > 0) {
			for(String user : users) {
				UserProjectDO userProject = new UserProjectDO();
				userProject.setUsername(user);
				userProject.setProjectId(Integer.parseInt(id));
				userProject.setRole(Integer.parseInt(role));
				userService.createUserProject(userProject);
			}
		}
		return new ModelAndView("project/project_ajax", "queryString", "true");
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

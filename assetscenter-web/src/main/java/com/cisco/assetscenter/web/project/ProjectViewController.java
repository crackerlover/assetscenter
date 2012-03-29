package com.cisco.assetscenter.web.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.service.asset.ProjectService;

public class ProjectViewController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectViewController.class);
	private ProjectService projectService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		List<ProjectDO> list = projectService.viewAllProjects();
		return new ModelAndView("project/project_json_data", "data", echoJsonData(list, method));
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	private String echoJsonData(List<ProjectDO> list, String method) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		if(StringUtils.isNotBlank(method)) {
			buffer.append("{");
			buffer.append("\"id\":").append("-1");
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append("ALL").append("\"");
			buffer.append(",").append("\"selected\":true");
			buffer.append("}");
			buffer.append(",");
		}
		for(int i = 0;i < list.size(); i ++) {
			ProjectDO project = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(project.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(project.getName()).append("\"");
//			if(i == 0 && StringUtils.isBlank(method)) {
//				buffer.append(",").append("\"selected\":true");
//			}
			buffer.append("}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}

}

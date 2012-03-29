package com.cisco.assetscenter.web.project;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectQuery;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class ViewProjectController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectViewController.class);
	private ProjectService projectService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		ProjectQuery query =  new ProjectQuery();
		if(StringUtils.isNotBlank(orderBy)) {
			query.setOrderBy(orderBy);
		}
		if(StringUtils.isNotBlank(pageNo)) {
			query.setPageNO(Integer.parseInt(pageNo));
		}
		if(StringUtils.isNotBlank(pageSize)) {
			query.setPageSize(Integer.parseInt(pageSize));
		}
		if(StringUtils.isNotBlank(sort)) {
			query.setSort(sort);
		}
		if(StringUtils.isNotBlank(name)) {
			query.setName(name.trim());
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<ProjectDO> projectList = projectService.loadAllProjectsByQuery(query);
		int total = projectService.getTotalNumsByQuery(query);
		return new ModelAndView("project/project_view_json_data", "json_data", echoJsonData(projectList, total));
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	private String echoJsonData(List<ProjectDO> projectList, int total) {
		if(null == projectList) {
			projectList = new ArrayList<ProjectDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < projectList.size(); i ++) {
			ProjectDO project = projectList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(project.getId()).append("\"").append(",");
			buffer.append("\"name\":\"").append(project.getName()).append("\"").append(",");
			String[] managers = project.getManagers();
			String manager = "";
			if(null != managers && managers.length > 0) {
				for(int j = 0; j < managers.length; j ++) {
					if(j != managers.length - 1) {
						manager = manager + managers[j] + ",";
					}
					else {
						manager = manager + managers[j];
					}
				}
			}
			buffer.append("\"managers\":\"").append(manager).append("\"").append(",");
			buffer.append("\"START_TIME\":\"").append(project.getStartTime()).append("\"").append(",");
			buffer.append("\"END_TIME\":\"").append(project.getEndTime()).append("\"").append(",");
			buffer.append("\"GMT_CREATE\":\"").append(project.getGmtCreate()).append("\"").append(",");
			buffer.append("\"description\":\"").append(JsonUtils.skipChar(project.getDescription())).append("\"");
			buffer.append("}");
			if(i != projectList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

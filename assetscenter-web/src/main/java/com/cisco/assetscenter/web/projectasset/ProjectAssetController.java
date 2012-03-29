package com.cisco.assetscenter.web.projectasset;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.project.ProjectDO;
import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectAssetQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.ProjectAssetService;
import com.cisco.assetscenter.service.asset.ProjectService;
import com.cisco.assetscenter.web.util.DateUtils;

public class ProjectAssetController implements Controller {

	private ProjectAssetService projectAssetService;
	private ProjectService projectService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String selectKey = request.getParameter("selectKey");
		String selectValue = request.getParameter("selectValue");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String project = request.getParameter("project");
		HttpSession session = request.getSession(false);
		if(null == session) {
			return new ModelAndView("login/login");
		}
		UserDO user = (UserDO)session.getAttribute("user");
		if(null == user) {
			return new ModelAndView("login/login");
		}
		ProjectAssetQuery query = new ProjectAssetQuery();
		query.setOwner(user.getUsername());
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
		if(StringUtils.isNotBlank(selectValue)) {
			if("sn".equalsIgnoreCase(selectKey)) {
				query.setSn(selectValue);
			}
			if("eltms".equalsIgnoreCase(selectKey)) {
				query.setEltms(selectValue);
			}
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(project)) {
			ProjectDO projectDO = projectService.findProjectByName(project);
			if(null != projectDO) {
				query.setProjectId(projectDO.getId());
			}
		}
		List<ProjectAssetDO> list = projectAssetService.loadProjectAssetByQuery(query);
		int total = projectAssetService.getTotalNumsByQuery(query);
		return new ModelAndView("project/project_view_json_data", "json_data", echoJsonData(list, total));
	}
	public void setProjectAssetService(ProjectAssetService projectAssetService) {
		this.projectAssetService = projectAssetService;
	}
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	private String echoJsonData(List<ProjectAssetDO> list, int total) {
		if(null == list) {
			list = new ArrayList<ProjectAssetDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < list.size(); i ++) {
			ProjectAssetDO projectAsset = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(projectAsset.getAssetId()).append("\"").append(",");
			ProjectDO project = projectService.findProjectById(projectAsset.getProjectId());
			buffer.append("\"sn\":\"").append(projectAsset.getSn()).append("\"").append(",");
			buffer.append("\"eltms\":\"").append(projectAsset.getEltms()).append("\"").append(",");
			buffer.append("\"owner\":\"").append(projectAsset.getOwnerName()).append("\"").append(",");
			String name = project == null ? "" : project.getName();
			buffer.append("\"project\":\"").append(name).append("\"").append(",");
			buffer.append("\"SET_TIME\":\"").append(projectAsset.getSetTime()).append("\"");
			buffer.append("}");
			if(i != list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

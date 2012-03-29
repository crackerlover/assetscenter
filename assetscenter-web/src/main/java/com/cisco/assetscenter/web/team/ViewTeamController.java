package com.cisco.assetscenter.web.team;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.query.TeamQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.web.project.ProjectViewController;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class ViewTeamController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectViewController.class);
	private TeamService teamService;
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
		TeamQuery query =  new TeamQuery();
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
		List<TeamDO> teamList = teamService.loadAllTeamsByQuery(query);
		int total = teamService.getTotalNumsByQuery(query);
		return new ModelAndView("team/team_view_json_data", "json_data", echoJsonData(teamList, total));
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	private String echoJsonData(List<TeamDO> teamList, int total) {
		if(null == teamList) {
			teamList = new ArrayList<TeamDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < teamList.size(); i ++) {
			TeamDO team = teamList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(team.getId()).append("\"").append(",");
			String[] managers = team.getManagers();
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
			buffer.append("\"name\":\"").append(team.getName()).append("\"").append(",");
			buffer.append("\"GMT_CREATE\":\"").append(team.getGmtCreate()).append("\"").append(",");
			buffer.append("\"description\":\"").append(JsonUtils.skipChar(team.getDescription())).append("\"");
			buffer.append("}");
			if(i != teamList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

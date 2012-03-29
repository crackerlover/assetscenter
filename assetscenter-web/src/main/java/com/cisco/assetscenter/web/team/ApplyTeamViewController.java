package com.cisco.assetscenter.web.team;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.query.TeamApplyRecordQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamApplyRecordDO;
import com.cisco.assetscenter.service.asset.TeamApplyRecordService;
import com.cisco.assetscenter.web.util.DateUtils;

public class ApplyTeamViewController implements Controller {

	private TeamApplyRecordService teamApplyRecordService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String applicant = request.getParameter("applicant");
		String team = request.getParameter("team");
		String role = request.getParameter("role");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		TeamApplyRecordQuery query = new TeamApplyRecordQuery();
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
		if(StringUtils.isNotBlank(team)) {
			query.setTeam(team);
		}
		if(StringUtils.isNotBlank(applicant)) {
			query.setApplicant(applicant);
		}
		if(StringUtils.isNotBlank(role)) {
			query.setRole(Integer.parseInt(role));
		}
		if(StringUtils.isNotBlank(status)) {
			query.setStatus(Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<TeamApplyRecordDO> list = teamApplyRecordService.loadTeamApplyRecordByQuery(query);
		int total = teamApplyRecordService.getTeamApplyRecordTotalNums(query);
		return new ModelAndView("project/project_apply_record_view_json_data", "json_data", echoJsonData(list, total));
	}
	private String echoJsonData(List<TeamApplyRecordDO> list, int total) {
		if(null == list) {
			list = new ArrayList<TeamApplyRecordDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < list.size(); i ++) {
			TeamApplyRecordDO projectApplyRecord = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(projectApplyRecord.getId()).append("\"").append(",");
			buffer.append("\"applicant\":\"").append(projectApplyRecord.getApplicant()).append("\"").append(",");
			buffer.append("\"team\":\"").append(projectApplyRecord.getTeam()).append("\"").append(",");
			int status = projectApplyRecord.getStatus();
			if(status == Constants.PENDING_APPLY_TEAM_STATUS) {
				buffer.append("\"status\":\"").append("Pending").append("\"").append(",");
			}
			if(status == Constants.APPROVED_APPLY_TEAM_STATUS) {
				buffer.append("\"status\":\"").append("Approved").append("\"").append(",");
			}
			int role = projectApplyRecord.getRole();
			if(role == Constants.PROJECT_ENGINEER_ROLE) {
				buffer.append("\"role\":\"").append("Engineer").append("\"").append(",");
			}
			if(role == Constants.PROJECT_MANAGER_ROLE) {
				buffer.append("\"role\":\"").append("Manager").append("\"").append(",");
			}
			buffer.append("\"APPLY_TIME\":\"").append(projectApplyRecord.getApplyTime()).append("\"");
			buffer.append("}");
			if(i != list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}
	public void setTeamApplyRecordService(
			TeamApplyRecordService teamApplyRecordService) {
		this.teamApplyRecordService = teamApplyRecordService;
	}

}

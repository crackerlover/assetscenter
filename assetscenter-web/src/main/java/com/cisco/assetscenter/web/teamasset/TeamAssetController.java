package com.cisco.assetscenter.web.teamasset;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.query.TeamAssetQuery;
import com.cisco.assetscenter.dao.dataobject.team.TeamDO;
import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.TeamAssetService;
import com.cisco.assetscenter.service.asset.TeamService;
import com.cisco.assetscenter.web.util.DateUtils;

/**
 * Team Asset Controller Class.
 * @author shuaizha
 *
 */
public class TeamAssetController implements Controller {

	private TeamService teamService;
	private TeamAssetService teamAssetService;
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
		String team = request.getParameter("team");
		HttpSession session = request.getSession(false);
		if(null == session) {
			return new ModelAndView("login/login");
		}
		UserDO user = (UserDO)session.getAttribute("user");
		if(null == user) {
			return new ModelAndView("login/login");
		}
		TeamAssetQuery query = new TeamAssetQuery();
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
		if(StringUtils.isNotBlank(team)) {
			TeamDO tmp = teamService.findTeamByName(team);
			if(null != tmp) {
				query.setTeamId(tmp.getId());
			}
		}
		List<TeamAssetDO> list = teamAssetService.loadTeamAssetByQuery(query);
		int total = teamAssetService.getTotalNumsByQuery(query);
		return new ModelAndView("team/team_view_json_data", "json_data", echoJsonData(list, total));
	}
	public void setTeamService(TeamService teamService) {
		this.teamService = teamService;
	}
	public void setTeamAssetService(TeamAssetService teamAssetService) {
		this.teamAssetService = teamAssetService;
	}
	private String echoJsonData(List<TeamAssetDO> list, int total) {
		if(null == list) {
			list = new ArrayList<TeamAssetDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < list.size(); i ++) {
			TeamAssetDO teamAsset = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(teamAsset.getAssetId()).append("\"").append(",");
			TeamDO team = teamService.findTeamById(teamAsset.getTeamId());
			buffer.append("\"sn\":\"").append(teamAsset.getSn()).append("\"").append(",");
			buffer.append("\"eltms\":\"").append(teamAsset.getEltms()).append("\"").append(",");
			buffer.append("\"owner\":\"").append(teamAsset.getOwnerName()).append("\"").append(",");
			String name = team == null ? "" : team.getName();
			buffer.append("\"team\":\"").append(name).append("\"").append(",");
			buffer.append("\"SET_TIME\":\"").append(teamAsset.getSetTime()).append("\"");
			buffer.append("}");
			if(i != list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

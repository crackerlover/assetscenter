package com.cisco.assetscenter.web.teamasset;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.teamassest.TeamAssetDO;
import com.cisco.assetscenter.service.asset.TeamAssetService;
import com.cisco.assetscenter.web.util.DateUtils;

public class SetTeamController implements Controller {

	private TeamAssetService teamAssetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String team = request.getParameter("team");
		String assetId = request.getParameter("assetId");
		if(StringUtils.isNotBlank(assetId) && StringUtils.isNotBlank(team)) {
			TeamAssetDO teamAsset = new TeamAssetDO();
			teamAsset.setAssetId(Integer.parseInt(assetId));
			teamAsset.setTeamId(Integer.parseInt(team));
			teamAsset.setSetTime(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
			TeamAssetDO tmp = teamAssetService.findTeamAssetByIds(Integer.parseInt(assetId));
			if(null == tmp) {
				teamAssetService.insert(teamAsset);
			}
			else {
				if(tmp.getTeamId() != Integer.parseInt(team)) {
					teamAssetService.updateTeamByIds(tmp.getId(), Integer.parseInt(team));
				}
			}
		}
		String queryString = "?selectKey=&selectValue=&team=&startTime=&endTime=";
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}
	public void setTeamAssetService(TeamAssetService teamAssetService) {
		this.teamAssetService = teamAssetService;
	}

}

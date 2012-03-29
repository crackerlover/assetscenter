package com.cisco.assetscenter.web.projectasset;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.projectassest.ProjectAssetDO;
import com.cisco.assetscenter.service.asset.ProjectAssetService;
import com.cisco.assetscenter.web.util.DateUtils;

public class SetProjectController implements Controller {

	private ProjectAssetService projectAssetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String project = request.getParameter("project");
		String assetId = request.getParameter("assetId");
		if(StringUtils.isNotBlank(assetId) && StringUtils.isNotBlank(project)) {
			ProjectAssetDO projectAsset = new ProjectAssetDO();
			projectAsset.setAssetId(Integer.parseInt(assetId));
			projectAsset.setProjectId(Integer.parseInt(project));
			projectAsset.setSetTime(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
			ProjectAssetDO tmp = projectAssetService.findProjectAssetByIds(Integer.parseInt(assetId));
			if(null == tmp) {
				projectAssetService.insert(projectAsset);
			}
			else {
				if(tmp.getProjectId() != Integer.parseInt(project)) {
					projectAssetService.updateProjectByIds(tmp.getId(), Integer.parseInt(project));
				}
			}
		}
		String queryString = "?selectKey=&selectValue=&project=&startTime=&endTime=";
		return new ModelAndView("project/project_ajax", "queryString", queryString);
	}
	public void setProjectAssetService(ProjectAssetService projectAssetService) {
		this.projectAssetService = projectAssetService;
	}

}

package com.cisco.assetscenter.web.asset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class AssetTypeEditController implements Controller{

	protected final Logger logger = Logger.getLogger(AssetTypeEditController.class);
	private AssetTypeService assetTypeService;
	public static final String MANAGER_SPLIT = ",";
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		AssetTypeDO assetType = new AssetTypeDO();
		if(StringUtils.isNotBlank(id)) {
			assetType.setId(Integer.parseInt(id));
		}
		if(StringUtils.isNotBlank(name)) {
			assetType.setName(name);
		}
		if(StringUtils.isNotBlank(description)) {
			assetType.setDescription(description);
		}
		assetTypeService.update(assetType);
		String queryString = "?name=&description=";
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

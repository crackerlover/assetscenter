package com.cisco.assetscenter.web.asset;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;


public class AssetTypeAddController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetTypeAddController.class);
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		AssetTypeDO assetTypeDO = new AssetTypeDO();
		
		if(StringUtils.isNotBlank(name)) {
			assetTypeDO.setName(name);
		}
		if(StringUtils.isNotBlank(description)) {
			assetTypeDO.setDescription(description);
		}
		assetTypeService.createAssetType(assetTypeDO);
		String queryString = "?name=&description=";
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}
	}

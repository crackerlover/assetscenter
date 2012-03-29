package com.cisco.assetscenter.web.asset;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;


public class AssetTypeInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetTypeInitialController.class);
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		
		if(StringUtils.isEmpty(method)) {
			logger.error("AssetTypeInitialController.handleRequest parameter method is null.");
			return null;
		}
		if(StringUtils.isNotBlank(method)) {
			if("add".equalsIgnoreCase(method)) {
				return new ModelAndView("asset/type/add_asset_type");
			}
			if("edit".equalsIgnoreCase(method)) {
				if(StringUtils.isEmpty(id)) {
					logger.error("AssetTypeInitialController.handleRequest edit id is null");
					return new ModelAndView("main");
				}
				AssetTypeDO assetTypeDO = assetTypeService.findAssetTypeById(Integer.parseInt(id));
				if(null == assetTypeDO) {
					return new ModelAndView("main");
				}
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("assetTypeDO", assetTypeDO);
				return new ModelAndView("asset/type/edit_asset_type", "map", map);
			}
		}
		return new ModelAndView("main");
	}

	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}
}

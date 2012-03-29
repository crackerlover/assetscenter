package com.cisco.assetscenter.web.asset;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class AssetInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetViewController.class);
	private AssetService assetService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		String ids = request.getParameter("ids");
		if(StringUtils.isEmpty(method)) {
			logger.error("AssetInitialController.handleRequest parameter method is null.");
			return null;
		}
		if("add".equalsIgnoreCase(method)) {
			return new ModelAndView("asset/add_asset");
		}
		if("edit".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("AssetInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			AssetDO asset = assetService.viewAssetById(Integer.parseInt(id));
			List<AssetTypeDO> assetTypeList = assetTypeService.viewAllAssetTypes();
			if(null == asset || null == assetTypeList) {
				return new ModelAndView("main");
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("asset", asset);
			map.put("assetTypeList", assetTypeList);
			return new ModelAndView("asset/edit_asset", "map", map);
		}
		if("transfer".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("AssetInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			return new ModelAndView("asset/transfer_asset", "id", id);
		}
		if("import".equalsIgnoreCase(method)) {
			return new ModelAndView("asset/import_asset");
		}
		if("status".equalsIgnoreCase(method)) {
			return new ModelAndView("asset/status_asset", "ids", ids);
		}
		return new ModelAndView("main");
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

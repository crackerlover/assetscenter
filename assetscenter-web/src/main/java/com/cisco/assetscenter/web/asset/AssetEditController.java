package com.cisco.assetscenter.web.asset;

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
import com.cisco.assetscenter.web.util.DateUtils;

public class AssetEditController implements Controller {


	protected final Logger logger = Logger.getLogger(AssetViewController.class);
	private AssetService assetService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String description = request.getParameter("description");
		String sn = request.getParameter("sn");
		String eltms = request.getParameter("eltms");
		String owner = request.getParameter("owner");
		String user = request.getParameter("user");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String warehouseTime = request.getParameter("WAREHOUSE_TIME");
		String price = request.getParameter("price");
		String order = request.getParameter("order");
		String location = request.getParameter("location");
		AssetDO asset = new AssetDO();
		if(StringUtils.isNotBlank(id)) {
			asset.setId(Integer.parseInt(id));
		}
		if(StringUtils.isNotBlank(description)) {
			asset.setDescription(description);
		}
		if(StringUtils.isNotBlank(sn)) {
			asset.setSn(sn.trim());
		}
		if(StringUtils.isNotBlank(eltms)) {
			asset.setEltms(eltms.trim());
		}
		if(StringUtils.isNotBlank(owner)) {
			asset.setOwnerName(owner.trim());
		}
		if(StringUtils.isNotBlank(user)) {
			asset.setUserName(user.trim());
		}
		if(StringUtils.isNotBlank(type)) {
			AssetTypeDO assetType = assetTypeService.findAssetTypeByName(type);
			/**
			 * If the asset type is not exist, we will create a new type.
			 */
			if(null == assetType) {
				assetType = new AssetTypeDO();
				assetType.setName(type);
				assetType.setDescription(type);
				int typeId = assetTypeService.createAssetType(assetType);
				asset.setTypeId(typeId);
			}
			else {
				asset.setTypeId(assetType.getId());
			}
		}
		if(StringUtils.isNotBlank(status)) {
			asset.setStatus(Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(warehouseTime)) {
			asset.setWarehouseTime(DateUtils.convertStr2Str(warehouseTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(price)) {
			asset.setPrice(Double.parseDouble(price.trim()));
		}
		if(StringUtils.isNotBlank(order)) {
			asset.setOrderName(order.trim());
		}
		if(StringUtils.isNotBlank(location)) {
			asset.setLocation(location.trim());
		}
		//verify the existing asset info.
		AssetDO tmp = assetService.loadAssetBySnEltms(sn, eltms);
		if(null == tmp || tmp.getSn().equalsIgnoreCase(sn) || tmp.getEltms().
				equalsIgnoreCase(eltms)) {
			assetService.updateAsset(asset);
		}
		String queryString = "?selectKey=&selectValue=&owner=&type=&status=&startTime=&endTime=";
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

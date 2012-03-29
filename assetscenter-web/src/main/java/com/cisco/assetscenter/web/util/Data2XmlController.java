package com.cisco.assetscenter.web.util;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class Data2XmlController implements Controller{

	private AssetService assetService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//o or null is read operation, 1 is write operation
		String action = request.getParameter("action");
		if(StringUtils.isEmpty(action)) {
			action = "0";
		}
		String id = request.getParameter("id");
		request.setCharacterEncoding("UTF-8");
		
		//This request is read operation.
		if(action.equals("0")) {
			response.setContentType("text/xml;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			out.println("<assets>");
			if(StringUtils.isNotBlank(id)) {
				AssetDO asset = assetService.viewAssetById(Integer.parseInt(id));
				printDetail(out, asset);
			}
			else {
				List<AssetDO> list = assetService.loadAllAssets();
				for(AssetDO asset : list) {
					printDetail(out, asset);
				}
			}
			
			out.println("</assets>");
		}
		//This request is write operation.
		if(action.equals("1")) {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
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
				asset.setWarehouseTime(DateUtils.convertStr2Str(warehouseTime, 
						DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
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
			
			//if id is null, it is insert operation
			if(StringUtils.isEmpty(id)) {
				AssetDO tmp = assetService.loadAssetBySnEltms(sn, eltms);
				if(null == tmp) {
					assetService.createAsset(asset);
				}
				out.println("insert operation is success....");
			}
			//if id is not null, it is update operation.
			else {
				asset.setId(Integer.parseInt(id));
				AssetDO tmp = assetService.loadAssetBySnEltms(sn, eltms);
				if(null == tmp || tmp.getSn().equalsIgnoreCase(sn) || tmp.getEltms().
						equalsIgnoreCase(eltms)) {
					assetService.updateAsset(asset);
				}
				out.println("update operation is success....");
			}
		}
		
		return null;
		
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	/**
	 * 
	 * @param out
	 * @param asset
	 */
	private void printDetail(PrintWriter out, AssetDO asset) {
		if(null != asset) {
			out.println("\t<asset>");
			out.println("\t\t<sn>" + asset.getSn() + "</sn>");
			out.println("\t\t<eltms>" + asset.getEltms() + "</eltms>");
			out.println("\t\t<ownerName>" + asset.getOwnerName() + "</ownerName>");
			out.println("\t</asset>");
		}
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

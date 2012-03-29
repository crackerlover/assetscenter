package com.cisco.assetscenter.web.asset;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class AssetTypeViewController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetTypeViewController.class);
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		List<AssetTypeDO> list = assetTypeService.viewAllAssetTypes();
		return new ModelAndView("asset/type/asset_type_json_data", "data", echoJsonData(list, method));
	}
	
	private String echoJsonData(List<AssetTypeDO> list, String method) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		if(StringUtils.isNotBlank(method)) {
			buffer.append("{");
			buffer.append("\"id\":").append("-1");
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append("ALL").append("\"");
			buffer.append(",").append("\"selected\":true");
			buffer.append("}");
			buffer.append(",");
		}
		for(int i = 0;i < list.size(); i ++) {
			AssetTypeDO assetTypeDO = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(assetTypeDO.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(assetTypeDO.getName()).append("\"");
			if(i == 0 && StringUtils.isBlank(method)) {
				buffer.append(",").append("\"selected\":true");
			}
			buffer.append("}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}

	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

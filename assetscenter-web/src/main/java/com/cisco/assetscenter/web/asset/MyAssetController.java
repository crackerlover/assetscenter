package com.cisco.assetscenter.web.asset;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.AssetTypeService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class MyAssetController implements Controller {

	private AssetService assetService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String selectKey = request.getParameter("selectKey");
		String selectValue = request.getParameter("selectValue");
		String owner = request.getParameter("owner");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		AssetQuery query = new AssetQuery();
		HttpSession session = request.getSession(false);
		UserDO user = (UserDO)session.getAttribute("user");
		if(null == user) {
			return new ModelAndView("main");
		}
		query.setUserName(user.getUsername());
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
		if(StringUtils.isNotBlank(owner)) {
			query.setOwnerName(owner);
		}
		if(StringUtils.isNotBlank(type)) {
			query.setType(Integer.parseInt(type));
		}
		if(StringUtils.isNotBlank(status)) {
			query.setStatus(Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<AssetDO> assetList = assetService.viewAssetsByQuery(query);
		int total = assetService.viewAssetTotalQuantity(query);
		return new ModelAndView("asset/asset_view_json_data", "json_data", echoJsonData(assetList, total));
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	private String echoJsonData(List<AssetDO> assetList, int total) {
		if(null == assetList) {
			assetList = new ArrayList<AssetDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < assetList.size(); i ++) {
			AssetDO assetDO = assetList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(assetDO.getId()).append("\"").append(",");
			AssetTypeDO type = assetTypeService.findAssetTypeById(assetDO.getTypeId());
			String name = type == null ? "" : type.getName();
			buffer.append("\"type\":\"").append(name).append("\"").append(",");
			buffer.append("\"sn\":\"").append(assetDO.getSn()).append("\"").append(",");
			buffer.append("\"eltms\":\"").append(assetDO.getEltms()).append("\"").append(",");
			buffer.append("\"description\":\"").append(JsonUtils.skipChar(assetDO.getDescription())).append("\"").append(",");
			buffer.append("\"owner\":\"").append(assetDO.getOwnerName()).append("\"").append(",");
			buffer.append("\"user\":\"").append(assetDO.getUserName()).append("\"").append(",");
			buffer.append("\"WAREHOUSE_TIME\":\"").append(assetDO.getWarehouseTime()).append("\"").append(",");
			int status = assetDO.getStatus();
			if(status == Constants.USED_ASSET_STATUS) {
				buffer.append("\"status\":\"").append("Avaliable").append("\"").append(",");
			}
			if(status == Constants.ABANDONED_ASSET_STATUS) {
				buffer.append("\"status\":\"").append("Not Avaliable").append("\"").append(",");
			}
			buffer.append("\"price\":\"").append(assetDO.getPrice() == 0 ? "" : assetDO.getPrice()).append("\"").append(",");
			buffer.append("\"location\":\"").append(assetDO.getLocation()).append("\"");
			buffer.append("}");
			if(i != assetList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

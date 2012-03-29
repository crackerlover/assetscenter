package com.cisco.assetscenter.web.project;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class ProjectTreeController implements Controller {

	protected final Logger logger = Logger.getLogger(ProjectTreeController.class);
	private AssetService assetService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(null != session) {
			UserDO user = (UserDO)session.getAttribute("user");
			if(null != user) {
				String id = request.getParameter("id");
				if(StringUtils.isNotBlank(id)) {
					List<AssetDO> assetList = assetService.findAssetByProjectId(Integer.parseInt(id));
					return new ModelAndView("project/project_tree_json_data", "data", echoJsonData(assetList, assetList.size()));
				}
			}
		}
		return new ModelAndView("login/login");
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
			buffer.append("\"sn\":\"").append(assetDO.getSn()).append("\"").append(",");
			buffer.append("\"eltms\":\"").append(assetDO.getEltms()).append("\"").append(",");
			buffer.append("\"type\":\"").append(assetTypeService.findAssetTypeById(assetDO.getTypeId()).getName()).append("\"").append(",");
			buffer.append("\"description\":\"").append(assetDO.getDescription()).append("\"").append(",");
			buffer.append("\"owner\":\"").append(assetDO.getOwnerName()).append("\"").append(",");
			buffer.append("\"WAREHOUSE_TIME\":\"").append(assetDO.getWarehouseTime()).append("\"").append(",");
			int status = assetDO.getStatus();
			if(status == Constants.USED_ASSET_STATUS) {
				buffer.append("\"status\":\"").append("Avaliable").append("\"").append(",");
			}
			if(status == Constants.ABANDONED_ASSET_STATUS) {
				buffer.append("\"status\":\"").append("Not Avaliable").append("\"").append(",");
			}
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

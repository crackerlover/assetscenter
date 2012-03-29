package com.cisco.assetscenter.web.asset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.service.asset.AssetService;

public class StatusController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetViewController.class);
	private AssetService assetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ids = request.getParameter("ids");
		String status = request.getParameter("status");
		String owner = request.getParameter("owner");
		String user = request.getParameter("user");
		if(StringUtils.isEmpty(ids) || StringUtils.isEmpty(status)) {
			return new ModelAndView("main");
		}
		int s = Integer.parseInt(status);
		String[] id = ids.split(",");
		if(null != id && id.length > 0) {
			for(String i : id) {
				int idI = Integer.parseInt(i);
//				assetService.updateStatusById(Integer.parseInt(i), s);
				AssetDO asset = assetService.viewAssetById(idI);
				if(null != asset) {
					asset.setStatus(s);
					if(StringUtils.isNotBlank(owner)) {
						asset.setOwnerName(owner.trim());
					}
					if(StringUtils.isNotBlank(user)) {
						asset.setUserName(user.trim());
					}
				}
				assetService.updateAsset(asset);
			}
		}
		String queryString = "?selectKey=&selectValue=&owner=&type=&status=&startTime=&endTime=";
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}

}

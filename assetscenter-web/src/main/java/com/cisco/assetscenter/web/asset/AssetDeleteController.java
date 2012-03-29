package com.cisco.assetscenter.web.asset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.AssetService;

public class AssetDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetViewController.class);
	private AssetService assetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String selectKey = request.getParameter("selectKey");
		String selectValue = request.getParameter("selectValue");
		String owner = request.getParameter("owner");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		if(StringUtils.isEmpty(selectKey)) {
			selectKey = "";
		}
		if(StringUtils.isEmpty(selectValue)) {
			selectValue = "";
		}
		if(StringUtils.isEmpty(owner)) {
			owner = "";
		}
		if(StringUtils.isEmpty(type)) {
			type = "";
		}
		if(StringUtils.isEmpty(status)) {
			status = "";
		}
		if(StringUtils.isEmpty(startTime)) {
			startTime = "";
		}
		if(StringUtils.isEmpty(endTime)) {
			endTime = "";
		}
		String queryString = "?selectKey=" + selectKey + "&selectValue=" + selectValue + "&owner=" + owner + "&type="
				+ type + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
		if(StringUtils.isNotBlank(id)) {
			String[] ids = id.split(",");
			for(String str : ids) {
				assetService.deleteAssetById(Integer.parseInt(str));
			}
			HttpSession session = request.getSession();
			UserDO user  = (UserDO) session.getAttribute("user");
			if(null != user)
				logger.warn("The user [ " + user.getUsername() + " ]" + " delete asset id : " + id);
		}
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}

}

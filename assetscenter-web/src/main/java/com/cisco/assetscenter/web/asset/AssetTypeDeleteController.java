package com.cisco.assetscenter.web.asset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;

public class AssetTypeDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetTypeDeleteController.class);
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)) {
			assetTypeService.delAssetTypeById(Integer.parseInt(id));
			HttpSession session = request.getSession();
			UserDO user  = (UserDO) session.getAttribute("user");
			if(null != user)
				logger.warn("The user [ " + user.getUsername() + " ]" + " delete asset type id : " + id);
		}
		String queryString = "?name=&startTime=&endTime=";
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

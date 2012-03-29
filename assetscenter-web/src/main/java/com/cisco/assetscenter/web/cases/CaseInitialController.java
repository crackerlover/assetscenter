package com.cisco.assetscenter.web.cases;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseService;
import com.cisco.assetscenter.service.asset.CaseTypeService;

public class CaseInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseInitialController.class);
	private CaseTypeService caseTypeService;
	private CaseService caseService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(method)) {
			logger.error("CaseInitialController.handleRequest parameter method is null.");
			return null;
		}
		if("add".equalsIgnoreCase(method)) {
			return new ModelAndView("case/add_case");
		}
		if("edit".equalsIgnoreCase(method)) {
			if(StringUtils.isEmpty(id)) {
				logger.error("UserInitialController.handleRequest: parameter id is null");
				return new ModelAndView("main");
			}
			CaseDO caseDO = caseService.viewCaseById(Integer.parseInt(id));
			List<CaseTypeDO> caseTypeList = caseTypeService.viewAllAssetTypes();
			if(null == caseDO || null == caseTypeList) {
				return new ModelAndView("main");
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("caseDO", caseDO);
			map.put("caseTypeList", caseTypeList);
			return new ModelAndView("case/edit_case", "map", map);
		}
		if("confirm".equalsIgnoreCase(method)) {
			if(StringUtils.isNotBlank(id)) {
				CaseDO caseDO = caseService.viewCaseById(Integer.parseInt(id));
				return new ModelAndView("case/confirm_apply", "case", caseDO);
			}
		}
		return new ModelAndView("main");
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}

}

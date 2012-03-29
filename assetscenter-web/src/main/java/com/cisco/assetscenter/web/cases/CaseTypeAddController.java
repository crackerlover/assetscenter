package com.cisco.assetscenter.web.cases;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseTypeService;


public class CaseTypeAddController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseTypeAddController.class);
	private CaseTypeService caseTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		CaseTypeDO casetypeDO = new CaseTypeDO();
		//if(StringUtils.isNotBlank(name)) {
			//CaseTypeDO caseType = caseTypeService.findCaseTypeByName(name);
			/**
			 * If the case type is not exist, we will create a new type.
			 */
		if(StringUtils.isNotBlank(name)) {
			casetypeDO.setName(name);
		}
		if(StringUtils.isNotBlank(description)) {
			casetypeDO.setDescription(description);
		}
		caseTypeService.createAssetType(casetypeDO);
		String queryString = "?name=&description=";
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	}

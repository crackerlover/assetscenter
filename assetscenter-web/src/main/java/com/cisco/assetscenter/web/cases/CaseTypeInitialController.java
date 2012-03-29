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

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseTypeService;


public class CaseTypeInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseTypeInitialController.class);
	private CaseTypeService caseTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(method)) {
			if("add".equalsIgnoreCase(method)) {
				return new ModelAndView("case/type/add_casetype");
			}
			if("edit".equalsIgnoreCase(method)) {
				if(StringUtils.isEmpty(id)) {
					logger.error("CaseTypeInitialController.handleRequest edit id is null");
					return new ModelAndView("main");
				}
				CaseTypeDO casetypeDO = caseTypeService.findCaseTypeById(Integer.parseInt(id));
				List<CaseTypeDO> casetypeList = caseTypeService.viewAllAssetTypes();
				if(null == casetypeDO || null == casetypeList) {
					return new ModelAndView("main");
				}
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("casetypeDO", casetypeDO);
				map.put("casetypeList", casetypeList);
				return new ModelAndView("case/type/edit_casetype", "map", map);
			}
		}
		return new ModelAndView("main");
	}
	/*public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}*/
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
}

package com.cisco.assetscenter.web.cases;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseTypeService;

public class CaseTypeEditController implements Controller{

	protected final Logger logger = Logger.getLogger(CaseTypeEditController.class);
	private CaseTypeService caseTypeService;
	public static final String MANAGER_SPLIT = ",";
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		CaseTypeDO caseType = new CaseTypeDO();
		if(StringUtils.isNotBlank(id)) {
			caseType.setId(Integer.parseInt(id));
		}
		if(StringUtils.isNotBlank(name)) {
			caseType.setName(name);
		}
		if(StringUtils.isNotBlank(description)) {
			caseType.setDescription(description);
		}
		caseTypeService.update(caseType);
		String queryString = "?name=&description=";
		return new ModelAndView("team/team_ajax", "queryString", queryString);
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}

}

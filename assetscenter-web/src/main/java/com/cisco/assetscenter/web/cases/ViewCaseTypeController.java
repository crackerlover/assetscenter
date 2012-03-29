package com.cisco.assetscenter.web.cases;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


import com.cisco.assetscenter.dao.dataobject.query.CaseTypeQuery;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseTypeService;

import com.cisco.assetscenter.web.util.DateUtils;

public class ViewCaseTypeController implements Controller {

	protected final Logger logger = Logger.getLogger(ViewCaseTypeController.class);
	private CaseTypeService caseTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		CaseTypeQuery query =  new CaseTypeQuery();
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
		if(StringUtils.isNotBlank(name)) {
			query.setName(name);
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<CaseTypeDO> casetypeList = caseTypeService.loadCaseTypesByQuery(query);
		int total = caseTypeService.getTotalNumsByQuery(query);
		return new ModelAndView("case/type/case_type_json_data", "data", echoJsonData(casetypeList, total));
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	private String echoJsonData(List<CaseTypeDO> casetypeList, int total) {
		if(null ==  casetypeList) {
			 casetypeList = new ArrayList<CaseTypeDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i <  casetypeList.size(); i ++) {
			CaseTypeDO casetypeDO =  casetypeList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(casetypeDO.getId()).append("\"").append(",");
			buffer.append("\"name\":\"").append(casetypeDO.getName()).append("\"").append(",");
			buffer.append("\"description\":\"").append(casetypeDO.getDescription()).append("\"");
			buffer.append("}");
			if(i != casetypeList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

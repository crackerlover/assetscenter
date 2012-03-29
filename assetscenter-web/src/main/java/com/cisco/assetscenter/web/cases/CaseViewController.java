package com.cisco.assetscenter.web.cases;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.query.CaseQuery;
import com.cisco.assetscenter.service.asset.CaseService;
import com.cisco.assetscenter.service.asset.CaseTypeService;
import com.cisco.assetscenter.web.util.DateUtils;

public class CaseViewController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseViewController.class);
	private CaseTypeService caseTypeService;
	private CaseService caseService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		CaseQuery query = new CaseQuery();
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
		if(StringUtils.isNotBlank(title)) {
			query.setTitle(title.trim());
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
		List<CaseDO> caseList = caseService.viewCaseByQuery(query);
		int total = caseService.viewTotalCaseQuantity(query);
		return new ModelAndView("case/case_view_json_data", "json_data", echoJsonData(caseList, total));
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}
	
	private String echoJsonData(List<CaseDO> caseList, int total) {
		if(null == caseList) {
			caseList = new ArrayList<CaseDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < caseList.size(); i ++) {
			CaseDO caseDO = caseList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(caseDO.getId()).append("\"").append(",");
			buffer.append("\"title\":\"").append(caseDO.getName()).append("\"").append(",");
			buffer.append("\"type\":\"").append(caseTypeService.findCaseTypeById(caseDO.getTypeId()).getName()).append("\"").append(",");
			buffer.append("\"requester\":\"").append(caseDO.getSubmiter()).append("\"").append(",");
			buffer.append("\"tos\":\"").append(caseDO.getTos()).append("\"").append(",");
			buffer.append("\"GMT_CREATE\":\"").append(caseDO.getGmtCreate()).append("\"").append(",");
			buffer.append("\"GMT_FINISH\":\"").append(caseDO.getGmtFinish()).append("\"").append(",");
			buffer.append("\"EXPECT_TIME\":\"").append(caseDO.getExpectTime()).append("\"").append(",");
//			buffer.append("\"description\":\"").append(caseDO.getDescription()).append("\"").append(",");
//			buffer.append("\"info\":\"").append(caseDO.getUpdateInfo()).append("\"").append(",");
			int status = caseDO.getStatus();
			if(status == Constants.PENDING_CASE_STATUS) {
				buffer.append("\"status\":\"").append("Pending").append("\"");
			}
			if(status == Constants.APPROVED_CASE_STATUS) {
				buffer.append("\"status\":\"").append("Closed").append("\"");
			}
			buffer.append("}");
			if(i != caseList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

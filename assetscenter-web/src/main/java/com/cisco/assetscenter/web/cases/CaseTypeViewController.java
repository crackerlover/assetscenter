package com.cisco.assetscenter.web.cases;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.service.asset.CaseTypeService;
import com.cisco.assetscenter.web.asset.AssetTypeViewController;

public class CaseTypeViewController implements Controller {

	protected final Logger logger = Logger.getLogger(AssetTypeViewController.class);
	private CaseTypeService caseTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		List<CaseTypeDO> list = caseTypeService.viewAllAssetTypes();
		return new ModelAndView("case/type/case_type_json_data", "data", echoJsonData(list, method));
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	
	private String echoJsonData(List<CaseTypeDO> list, String method) {
		if(null == list || list.size() <= 0) {
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		if(StringUtils.isNotBlank(method)) {
			buffer.append("{");
			buffer.append("\"id\":").append("-1");
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append("ALL").append("\"");
			buffer.append(",").append("\"selected\":true");
			buffer.append("}");
			buffer.append(",");
		}
		for(int i = 0;i < list.size(); i ++) {
			CaseTypeDO caseTypeDO = list.get(i);
			buffer.append("{");
			buffer.append("\"id\":").append(caseTypeDO.getId());
			buffer.append(",");
			buffer.append("\"text\":").append("\"").append(caseTypeDO.getName()).append("\"");
			if(i == 0 && StringUtils.isBlank(method)) {
				buffer.append(",").append("\"selected\":true");
			}
			buffer.append("}");
			if(i < list.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]");
		return buffer.toString();
	}

}

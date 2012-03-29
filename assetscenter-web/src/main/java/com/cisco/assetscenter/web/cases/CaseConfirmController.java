package com.cisco.assetscenter.web.cases;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.service.asset.CaseService;
import com.cisco.assetscenter.service.asset.MailService;

public class CaseConfirmController implements Controller {

	private CaseService caseService;
	private MailService mailService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(status)) {
			CaseDO caseDO = caseService.viewCaseById(Integer.parseInt(id));
			if(null == caseDO) {
				return new ModelAndView("main");
			}
			boolean success = caseService.updateStatus(Integer.parseInt(id), Integer.parseInt(status));
			if(success && Integer.parseInt(status) == Constants.APPROVED_CASE_STATUS) {
				MailDO mail = new MailDO();
				mail.setSender("admin-eAssets@cisco.com");
				mail.setRecipient(caseDO.getSubmiter() + "@cisco.com");
				mail.setSubject("Your case  " + caseDO.getName() + " is confirmed");
				String content = "<html><body>" +
						"Hi, " + caseDO.getSubmiter() + "<br/><br/>" +
						"Congratulations, your case:" + caseDO.getName() + " is confirmed, please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
		}
		return new ModelAndView("case/case_ajax", "queryString", "?title=&type=-1&status=0&startTime=&endTime=");
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

}

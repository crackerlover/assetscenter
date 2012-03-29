package com.cisco.assetscenter.web.cases;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.CaseService;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class CaseEditController implements Controller {

	private CaseService caseService;
	private MailService mailService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String to = request.getParameter("to");
		String status = request.getParameter("status");
		String info = request.getParameter("info");
		UserDO user = null;
		HttpSession vertifySession = request.getSession();
		if(null != vertifySession && !vertifySession.isNew()) {
			user = (UserDO) vertifySession.getAttribute("user");
			if(null == user) {
				return new ModelAndView("main");
			}
		}  
		CaseDO caseDO = new CaseDO();
		if(StringUtils.isEmpty(id)) {
			return new ModelAndView("main");
		}
		caseDO.setId(Integer.parseInt(id));
		if(StringUtils.isNotBlank(status)) {
			int s = Integer.parseInt(status);
			caseDO.setStatus(s);
			if(s == Constants.APPROVED_CASE_STATUS) {
				caseDO.setGmtFinish(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
			}
			else {
				caseDO.setGmtFinish("");
			}
		}
		CaseDO tmp = caseService.viewCaseById(caseDO.getId());
		if(StringUtils.isNotBlank(info)) {
			String str = "-------Update by " + user.getUsername() + " " + DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT) + "--------<br/>";
			String his = tmp.getUpdateInfo();
			if(StringUtils.isNotBlank(his)) {
				caseDO.setUpdateInfo(his + "<br/>" + str + JsonUtils.skipChar(info.trim()));
			}
			else {
				caseDO.setUpdateInfo(str + JsonUtils.skipChar(info.trim()));
			}
		}
		else {
			caseDO.setUpdateInfo(tmp.getUpdateInfo());
		}
		if(StringUtils.isNotBlank(to)) {
			caseDO.setTos(to);
		}
		boolean success = caseService.update(caseDO);
		if(success) {
			if(caseDO.getStatus() == Constants.APPROVED_CASE_STATUS) {
				MailDO mail = new MailDO();
				mail.setSender("eAsset-system@cisco.com");
				mail.setRecipient(tmp.getSubmiter() + "@cisco.com");
				mail.setSubject(tmp.getName() + " has been closed");
				String content = "<html><body>" +
						"Hi, " + caseDO.getSubmiter() + "<br/><br/>" +
						"Your case : [" + tmp.getName() +"] has beed closed, please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
			else {
				MailDO mail = new MailDO();
				mail.setSender("eAsset-system@cisco.com");
				mail.setRecipient(caseDO.getSubmiter() + "@cisco.com");
				mail.setSubject(tmp.getName() + " has beed updated");
				String content = "<html><body>" +
						"Hi, " + caseDO.getSubmiter() + "<br/><br/>" +
						"Your case : [" + tmp.getName() +"] has beed updated, please take a look.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
				//send mail to the operators.
				String[] tos = to.split(",");
				if(null != tos) 
					for(String t : tos) {
						MailDO m = new MailDO();
						m.setSender("eAsset-system@cisco.com");
						m.setRecipient(t.trim() + "@cisco.com");
						m.setSubject(tmp.getName() + " has beed updated");
						String c = "<html><body>" +
								"Hi, " + t + "<br/><br/>" +
								"The case : [" + tmp.getName() +"] has beed updated, please take a look.<br/><br/>" +
								"The following is the work history information: <br/><br/>" + caseDO.getUpdateInfo() + "<br/><br/>" +
								"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
								"</body></html>";
						m.setContent(c);
						mailService.sendMail(m);
					}
			}
		}
		String queryString = "?title=&type=-1&status=0&startTime=&endTime=";
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

}

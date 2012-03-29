package com.cisco.assetscenter.web.cases;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.cases.CaseDO;
import com.cisco.assetscenter.dao.dataobject.cases.CaseTypeDO;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.CaseService;
import com.cisco.assetscenter.service.asset.CaseTypeService;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class CaseAddController implements Controller {

	protected final Logger logger = Logger.getLogger(CaseAddController.class);
	private CaseTypeService caseTypeService;
	private CaseService caseService;
	private MailService mailService;
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String type = request.getParameter("type");
		String to = request.getParameter("to");
		String title = request.getParameter("title");
		String expectTime = request.getParameter("EXPECT_TIME");
		String requester = request.getParameter("requester");
		String description = request.getParameter("description");
		CaseDO caseDO = new CaseDO();
		if(StringUtils.isNotBlank(type)) {
			CaseTypeDO caseType = caseTypeService.findCaseTypeByName(type);
			/**
			 * If the case type is not exist, we will create a new type.
			 */
			if(null == caseType) {
				caseType = new CaseTypeDO();
				caseType.setName(type);
				caseType.setDescription(type);
				int typeId = caseTypeService.createAssetType(caseType);
				caseDO.setTypeId(typeId);
			}
			else {
				caseDO.setTypeId(caseType.getId());
			}
		}
		if(StringUtils.isNotBlank(title)) {
			caseDO.setName(title.trim());
		}
		if(StringUtils.isNotBlank(expectTime)) {
			caseDO.setExpectTime(DateUtils.convertStr2Str(expectTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(requester)) {
			caseDO.setSubmiter(requester);
		}
		if(StringUtils.isNotBlank(description)) {
			caseDO.setDescription(JsonUtils.skipChar(description));
		}
		if(StringUtils.isNotBlank(to)) {
			caseDO.setTos(to);
		}
		caseDO.setGmtCreate(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
		caseDO.setGmtFinish("");
		caseDO.setUpdateInfo("");
		boolean success = caseService.createCase(caseDO);
		if(success) {
			if(StringUtils.isNotBlank(to)) {
				String[] rs = to.split(",");
				if(null != rs) {
					for(String r : rs) {
						MailDO mail = new MailDO();
						mail.setSender(caseDO.getSubmiter() + "@cisco.com");
						String email = r.trim() + "@cisco.com";
						mail.setRecipient(email);
						mail.setSubject(caseDO.getName() + " needs to be confirmed");
						String content = "<html><body>" +
								"Hi, " + to + "<br/><br/>" +
								caseDO.getSubmiter() + " opened an case: " + caseDO.getName() +", please take a look and confirm it.<br/><br/>" +
								"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
								"</body></html>";
						mail.setContent(content);
						mailService.sendMail(mail);
					}
				}
			}
			else {
				MailDO mail = new MailDO();
				mail.setSender(caseDO.getSubmiter() + "@cisco.com");
				List<UserDO> admins = userService.findUserByRole(Constants.ADMIN_ROLE);
				mail.setRecipient(admins.get(0).getEmail());
				mail.setSubject(caseDO.getName() + " needs to be confirmed");
				String content = "<html><body>" +
						"Hi, " + admins.get(0).getUsername() + "<br/><br/>" +
						caseDO.getSubmiter() + " opened an case: " + caseDO.getName() +", please take a look and confirm it.<br/><br/>" +
						"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +
						"</body></html>";
				mail.setContent(content);
				mailService.sendMail(mail);
			}
			
		}
		String queryString = "?title=&type=-1&status=0&startTime=&endTime=";
		return new ModelAndView("case/case_ajax", "queryString", queryString);
	}
	public void setCaseTypeService(CaseTypeService caseTypeService) {
		this.caseTypeService = caseTypeService;
	}
	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

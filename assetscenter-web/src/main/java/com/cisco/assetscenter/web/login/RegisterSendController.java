package com.cisco.assetscenter.web.login;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.dao.dataobject.verify.VerifyDO;
import com.cisco.assetscenter.service.asset.MailService;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.service.asset.VerifyService;

public class RegisterSendController implements Controller {

	protected final Logger logger = Logger.getLogger(RegisterSendController.class);
	private UserService userService;
	private MailService mailService;
	private VerifyService verifyService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String name = request.getParameter("name");
		String role = request.getParameter("role");
		String fullname = request.getParameter("fullname");
		String email = name.trim() + "@cisco.com";
		if (StringUtils.isBlank(name)){
			return new ModelAndView("login/login");
		}
	    UserDO userDO = userService.findUserByUserName(name.trim());
	    if(null != userDO){
	    	return new ModelAndView("login/login");
	    }	 
		String verifyString = UUID.randomUUID().toString();
		VerifyDO verify = new VerifyDO();
	    verify.setVerifyString(verifyString);
		verify.setStatus(Constants.PENDING_VERIFY_STATUS);
		verify.setType(Constants.ACCOUNT_VERIFY_TYPE);
		verify.setUserId(0);
		verify.setStartTime(System.currentTimeMillis());
		int rs = verifyService.insert(verify);
					
					//if verify information generate success.
					//send the email.
		if(rs > 0) {
			final String VERIFY_URL = Constants.VERIFY_BASE_URL + 
					"?uid=" + 0 + "&s=" + verify.getStatus()
					+ "&t=" + verify.getType() + "&st=" + verify.getStartTime() 
					+"&oid=" + role + "&vs=" + verify.getVerifyString() + "&un=" + name + "&fn=" + fullname;
			List<UserDO> admins = userService.findUserByRole(Constants.ADMIN_ROLE);						
			if (null != admins){
				MailDO mail = new MailDO();
				mail.setSender(email);
				mail.setRecipient(admins.get(0).getEmail());
				String roleStr = "";
				if(Integer.parseInt(role) == Constants.VIEWER_ROLE) {
					roleStr = "Viewer";
				}
				if(Integer.parseInt(role) == Constants.USER_ROLE) {
					roleStr = "User";
				}
			    if(Integer.parseInt(role) == Constants.MANAGER_ROLE) {
					roleStr = "Manager";
				 }
				if(Integer.parseInt(role) == Constants.ADMIN_ROLE) {
					 roleStr = "Admin";
				}
			    mail.setSubject( name + " apply to join eAssets System ");
			    String content = "<html><body>" +
					"Hi, " + admins.get(0).getUsername() + "<br/><br/>" +
					name + " want to join eAssets System  as " + roleStr + ", please confirm it.<br/><br/>" +
					"<a href=" + VERIFY_URL + ">Approved Request</a><br/><br/>"
					    +"<a href=" + Constants.EAASETS_URL + ">eAssets System</a><br/><br/>" +"</body></html>";
				 mail.setContent(content);
				 mailService.sendMail(mail);
				 }
			}
	else{
		return new ModelAndView("main");
	}
	return new ModelAndView("main");
}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	public void setVerifyService(VerifyService veryfiService){
		this.verifyService = veryfiService;
	}
}
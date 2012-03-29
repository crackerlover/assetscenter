package com.cisco.assetscenter.web.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class RegisterController implements Controller{
	
	protected final Logger logger = Logger.getLogger(RegisterController.class);


	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		return new ModelAndView("login/register");
	}
	
}
package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.UserDAO;

public class UserTest {

	private ApplicationContext context;
	private UserDAO userDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		userDAO = (UserDAO) context.getBean("userDAO");
	}
	
	@Test
	public void testLoadAllUsers() {
		System.out.println(userDAO.loadAllUsers());
	}
}

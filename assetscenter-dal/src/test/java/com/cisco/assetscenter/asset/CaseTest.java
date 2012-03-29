package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.CaseDAO;

public class CaseTest {

	private ApplicationContext context;
	private CaseDAO caseDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		caseDAO = (CaseDAO)context.getBean("caseDAO");
	}
	
	@Test
	public void testLoadAllCases() {
		System.out.println(caseDAO.loadAllCases());
	}

}

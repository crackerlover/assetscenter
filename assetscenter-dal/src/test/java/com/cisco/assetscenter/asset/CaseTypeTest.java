package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.impl.cache.CacheCaseTypeDAO;

public class CaseTypeTest {

	private ApplicationContext context;
//	private CaseTypeDAO caseTypeDAO;
	private CacheCaseTypeDAO cacheCaseTypeDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
//		caseTypeDAO = (CaseTypeDAO)context.getBean("caseTypeDAO");
		cacheCaseTypeDAO = (CacheCaseTypeDAO)context.getBean("cacheCaseTypeDAO");
	}

	@Test
	public void testLoadCaseTypes() {
		System.out.println(cacheCaseTypeDAO.loadCaseTypes());
	}

}

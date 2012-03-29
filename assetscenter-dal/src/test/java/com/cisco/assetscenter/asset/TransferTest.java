package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.TransferDAO;

public class TransferTest {

	private ApplicationContext context;
	private TransferDAO transferDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		transferDAO = (TransferDAO) context.getBean("transferDAO");
	}
	
	@Test
	public void testLoadAllTransfers() {
		System.out.println(transferDAO.loadAllTransfers());
	}
}

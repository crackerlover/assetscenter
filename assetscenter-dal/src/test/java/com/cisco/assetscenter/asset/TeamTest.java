package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.impl.cache.CacheTeamDAO;

public class TeamTest {

	private ApplicationContext context;
	private CacheTeamDAO cacheTeamDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		cacheTeamDAO = (CacheTeamDAO)context.getBean("cacheTeamDAO");
	}

	@Test
	public void testLoadAllTeams() {
		System.out.println(cacheTeamDAO.loadAllTeams());
	}

}

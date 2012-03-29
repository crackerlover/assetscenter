package com.cisco.assetscenter.asset;


import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.impl.cache.CacheAssetTypeDAO;

public class AssetTypeTest {

	private ApplicationContext context;
//	private AssetTypeDAO assetTypeDAO;
	private CacheAssetTypeDAO cacheAssetTypeDAO;
	
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
//		assetTypeDAO = (AssetTypeDAO) context.getBean("assetTypeDAO");
		cacheAssetTypeDAO = (CacheAssetTypeDAO) context.getBean("cacheAssetTypeDAO");
	}
	
	@Test
	public void testLoadAssetTypes() {
		System.out.println(cacheAssetTypeDAO.loadAssetTypes());
	}
	
	@Test
	public void testInsert() {
		AssetTypeDO assetTypeDO = new AssetTypeDO();
		assetTypeDO.setName("XENPAK-10GB-LR+=");
		assetTypeDO.setDescription("2 Ethernet 2 WAN Card Slot Network Module");
		System.out.println(cacheAssetTypeDAO.insert(assetTypeDO));
	}
	
	@Test
	public void testFindAssetTypeById() {
		System.out.println(cacheAssetTypeDAO.findAssetTypeById(1));
	}

}

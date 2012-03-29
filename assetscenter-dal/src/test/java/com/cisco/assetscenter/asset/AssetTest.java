package com.cisco.assetscenter.asset;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.AssetDAO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.AssetQuery;

public class AssetTest {

	private ApplicationContext context;
	private AssetDAO assetDAO;
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		assetDAO = (AssetDAO) context.getBean("assetDAO");
	}

	@Test
	public void testLoadAllAssets() {
		System.out.println(assetDAO.loadAllAssets());
	}
	
	@Test
	public void testGetAssetTotalNums() {
		System.out.println(assetDAO.getAssetTotalNums());
	}
	
	@Test
	public void testInsert() {
		AssetDO asset = new AssetDO();
		asset.setSn("19751167");
		asset.setDescription("2 Ethernet 2 WAN Card Slot Network Module");
		asset.setEltms("ITM02381056");
		asset.setStatus(1);
		asset.setLocation("B-03-03-03");
		asset.setWarehouseTime(new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
		asset.setOrderName("WWRL#462224");
		asset.setTypeId(1);
		asset.setOrderName("shuaizha");
		asset.setPrice(100000);
		System.out.println(assetDAO.insert(asset));
	}
	
	@Test
	public void testLoadAssetByQuery() {
		AssetQuery  query = new AssetQuery();
		query.setType(1);
		System.out.println(assetDAO.loadAssetByQuery(query));
	}
	
	@Test
	public void testLoadAssetById() {
		System.out.println(assetDAO.loadAssetById(1));
	}

}

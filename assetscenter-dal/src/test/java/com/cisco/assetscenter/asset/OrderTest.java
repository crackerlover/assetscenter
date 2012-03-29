package com.cisco.assetscenter.asset;


import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cisco.assetscenter.dao.OrderDAO;
import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;

public class OrderTest{

	private ApplicationContext context;
	private OrderDAO orderDAO;
	
	@Before
	public void setUp() throws Exception {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		orderDAO = (OrderDAO) context.getBean("orderDAO");
	}
	@Test
	public void testGetOrderList() {
		System.out.println(orderDAO.loadOrderList().get(0).getDescription());
	}
	
	@Test
	public void testInsertOrder() {
		OrderAssetDO orderAssetDO = new OrderAssetDO();
		orderAssetDO.setQuantity(54);
		orderAssetDO.setTypeName("TTTTT/CPE");
		orderAssetDO.setExpectTime(new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
		OrderAssetDO orderAssetDO1 = new OrderAssetDO();
		orderAssetDO1.setQuantity(32);
		orderAssetDO1.setTypeName("FFFFFF/BBBBBB");
		orderAssetDO1.setExpectTime(new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
		List<OrderAssetDO> assetList = new ArrayList<OrderAssetDO>();
		assetList.add(orderAssetDO);
		assetList.add(orderAssetDO1);
		
		OrderDO orderDO = new OrderDO();
		orderDO.setAssetList(assetList);
		orderDO.setGmtCreate(new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
		orderDO.setGmtModified(new SimpleDateFormat("MM/dd/yyyy").format(new Date()));
		orderDO.setDescription("FFFFFFFFFF : 5");
		orderDO.setName("FFFFFFFFF");
		orderDO.setStatus(Constants.FINISHED_ORDER_STATUS);
		orderDO.setRequestName("shuaizha");
		
		System.out.println(orderDAO.insert(orderDO));
	}
	
	@Test
	public void testGetOrderTotalNums() {
		System.out.println(orderDAO.getOrderTotalNums());
	}
	
	@Test
	public void testLoadOrderList() {
		System.out.println(orderDAO.loadOrderList(new OrderDO()));;
	}
	
	@Test
	public void testDelete() {
		System.out.println(orderDAO.deleteOrderById(1));
	}
	
	@Test
	public void testFindOrderById() {
		System.out.println((orderDAO.findOrderById(22)).getName());
	}
	
	@Test
	public void testDeleteOrderAssetsByIds() {
		System.out.println(orderDAO.deleteOrderAssetByIds(new Integer[]{53}));
	}
}

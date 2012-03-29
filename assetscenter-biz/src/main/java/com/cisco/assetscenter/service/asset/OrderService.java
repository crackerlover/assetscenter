package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;

/**
 * provide the service for order management.
 * @author shuaizha
 * @date 2011-8-23
 */
public interface OrderService {

	/**
	 * create a new order.
	 * @param orderDO
	 * @return
	 */
	public boolean createOrder(OrderDO orderDO);
	
	/**
	 * retrieve all the order list.
	 * @return
	 */
	public List<OrderDO> viewAllOrders();
	
	public List<OrderDO> viewOrders(OrderDO orderDO);
	
	public List<OrderAssetDO> viewOrderDetailByOrderId(int orderId);
	
	public int viewOrderTotalNums();
	
	public int viewRetrieveReccordNums(OrderDO orderDO);
	
	public boolean deleteOrderById(int id);
	
	public OrderDO viewOrderById(int id);
	
	public boolean updateOrder(OrderDO orderDO);
	
	public boolean createOrderAssetBatch(List<OrderAssetDO> orderAssetList);
	
	public boolean deleteOrderAssetBatch(Integer[] ids);
}

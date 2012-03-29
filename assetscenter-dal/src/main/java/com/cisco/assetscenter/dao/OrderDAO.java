package com.cisco.assetscenter.dao;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;

/**
 * order database access class.
 * @author shuaizha
 *
 */
public interface OrderDAO {

	/**
	 * New a order.
	 * @param orderDO
	 * @return
	 */
	public int insert(final OrderDO orderDO);
	
	/**
	 * Retrieve all the order list.
	 * @return
	 */
	public List<OrderDO> loadOrderList();
	
	/**
	 * Retrieve the special order list.
	 * @param orderDO
	 * @return
	 */
	public List<OrderDO> loadOrderList(OrderDO orderDO);
	
	/**
	 * retrieve the assets of a order by order id.
	 * @param orderId
	 * @return
	 */
	public List<OrderAssetDO> findOrderAssetByOrderId(int orderId);
	
	/**
	 * get the total number of the orders.
	 * @return
	 */
	public int getOrderTotalNums();
	
	
	/**
	 * the num of retrieve records
	 * @param orderDO
	 * @return
	 */
	public int retrieveRecordNums(OrderDO orderDO);
	
	/**
	 * delte the order record.
	 * @param id
	 * @return
	 */
	public int deleteOrderById(int id);
	
	/**
	 * retrieve the Order by order id.
	 * @param id
	 * @return
	 */
	public OrderDO findOrderById(int id);
	
	/**
	 * update order.
	 * @param orderDO
	 * @return
	 */
	public int update(final OrderDO orderDO);
	
	/**
	 * insert order assets batch.
	 * @param orderAssetList
	 * @return
	 */
	public int[] insertOrderAssets(List<OrderAssetDO> orderAssetList);
	
	/**
	 * delete order asset by ids.
	 * @param ids
	 * @return
	 */
	public int[] deleteOrderAssetByIds(Integer[] ids);
	
}

package com.cisco.assetscenter.service.asset.impl;

import java.util.List;

import com.cisco.assetscenter.dao.OrderDAO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;
import com.cisco.assetscenter.service.asset.OrderService;

public class DefaultOrderService implements OrderService{

	private OrderDAO orderDAO;
	@Override
	public boolean createOrder(OrderDO orderDO) {
		if(null == orderDO) {
			return false;
		}
		return 0 != orderDAO.insert(orderDO);
	}

	@Override
	public List<OrderDO> viewAllOrders() {
		return orderDAO.loadOrderList();
	}

	public void setOrderDAO(OrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	@Override
	public List<OrderDO> viewOrders(OrderDO orderDO) {
		if(null == orderDO) {
			return null;
		}
		return orderDAO.loadOrderList(orderDO);
	}

	@Override
	public List<OrderAssetDO> viewOrderDetailByOrderId(int orderId) {
		if(0 == orderId) {
			return null;
		}
		return orderDAO.findOrderAssetByOrderId(orderId);
	}

	@Override
	public int viewOrderTotalNums() {
		return orderDAO.getOrderTotalNums();
	}

	@Override
	public int viewRetrieveReccordNums(OrderDO orderDO) {
		if(null == orderDO) {
			return 0;
		}
		return orderDAO.retrieveRecordNums(orderDO);
	}

	@Override
	public boolean deleteOrderById(int id) {
		if(0 == id) {
			return false;
		}
		return orderDAO.deleteOrderById(id) > 0;
	}

	@Override
	public OrderDO viewOrderById(int id) {
		if(0 == id) {
			return null;
		}
		return orderDAO.findOrderById(id);
	}

	@Override
	public boolean updateOrder(OrderDO orderDO) {
		if(null == orderDO) {
			return false;
		}
		return orderDAO.update(orderDO) > 0;
	}

	@Override
	public boolean createOrderAssetBatch(List<OrderAssetDO> orderAssetList) {
		if(null == orderAssetList || orderAssetList.size() == 0) {
			return false;
		}
		int[] ids = orderDAO.insertOrderAssets(orderAssetList);
		return null != ids && ids.length > 0;
	}

	@Override
	public boolean deleteOrderAssetBatch(Integer[] ids) {
		if(null == ids || ids.length == 0) {
			return false;
		}
		int[] rs = orderDAO.deleteOrderAssetByIds(ids);
		return null != rs && rs.length > 0;
	}

}

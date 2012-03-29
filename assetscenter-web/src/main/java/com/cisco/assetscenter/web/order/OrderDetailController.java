package com.cisco.assetscenter.web.order;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.service.asset.OrderService;

public class OrderDetailController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderDetailController.class);
	private OrderService orderService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderId = request.getParameter("orderId");
		if(StringUtils.isEmpty(orderId)) {
			logger.error("OrderDetailController.orderId is null.");
			return null;
		}
		List<OrderAssetDO> list = orderService.viewOrderDetailByOrderId(Integer.parseInt(orderId));
		if(null == list) {
			list = new ArrayList<OrderAssetDO>();
		}
		return new ModelAndView("order/order_detail", "list", list);
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

}

package com.cisco.assetscenter.web.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;
import com.cisco.assetscenter.service.asset.OrderService;

public class OrderInitialController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderInitialController.class);
	private OrderService orderService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(method)) {
			if("add".equalsIgnoreCase(method)) {
				return new ModelAndView("order/add_order");
			}
			if("edit".equalsIgnoreCase(method)) {
				if(StringUtils.isEmpty(id)) {
					logger.error("OrderInitialController.handleRequest edit id is null");
					return new ModelAndView("main");
				}
				OrderDO orderDO = orderService.viewOrderById(Integer.parseInt(id));
				List<AssetTypeDO> assetTypeList = assetTypeService.viewAllAssetTypes();
				if(null == orderDO || null == assetTypeList) {
					return new ModelAndView("main");
				}
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("order", orderDO);
				map.put("assetTypeList", assetTypeList);
				return new ModelAndView("order/edit_order", "map", map);
			}
		}
		return new ModelAndView("order/add_order");
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

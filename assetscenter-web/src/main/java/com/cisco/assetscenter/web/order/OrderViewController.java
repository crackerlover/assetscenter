package com.cisco.assetscenter.web.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;
import com.cisco.assetscenter.service.asset.OrderService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class OrderViewController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderViewController.class);
	private OrderService orderService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sort = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String order = request.getParameter("order");
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		OrderDO orderDO = new OrderDO();
		if(StringUtils.isNotBlank(order)) {
			orderDO.setOrder(order);
		}
		if(StringUtils.isNotBlank(sort)) {
			orderDO.setSort(sort);
		}
		if(StringUtils.isNotBlank(pageNo)) {
			orderDO.setPageNo(Integer.parseInt(pageNo));
		}
		if(StringUtils.isNotBlank(pageSize)) {
			orderDO.setPageSize(Integer.parseInt(pageSize));
		}
		if(StringUtils.isNotBlank(startTime)) {
			orderDO.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			orderDO.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(name)) {
			orderDO.setName(name.trim());
		}
		if(StringUtils.isNotBlank(status)) {
			orderDO.setStatus(Integer.parseInt(status));
		}
		
		List<OrderDO> orderList = orderService.viewOrders(orderDO);
		Map<String, Object> map = new HashMap<String, Object>();
		int total = orderService.viewRetrieveReccordNums(orderDO);
		map.put("data", echoJsonData(orderList, total));
		return new ModelAndView("order/order_json_data", "map", map);
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	
	private String echoJsonData(List<OrderDO> orderList, int total) {
		if(null == orderList) {
			orderList = new ArrayList<OrderDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < orderList.size(); i ++) {
			OrderDO orderDO = orderList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(orderDO.getId()).append("\"").append(",");
			buffer.append("\"name\":\"").append(orderDO.getName()).append("\"").append(",");
			buffer.append("\"description\":\"").append(JsonUtils.skipChar(orderDO.getDescription())).append("\"").append(",");
			int status = orderDO.getStatus();
			if(status == Constants.UNFINISHED_ORDER_STATUS) {
				buffer.append("\"status\":\"").append("Not Arrived").append("\"").append(",");
			}
			if(status == Constants.PARTFINISHED_ORDER_STATUS) {
				buffer.append("\"status\":\"").append("Part Arrived").append("\"").append(",");
			}
			if(status == Constants.FINISHED_ORDER_STATUS) {
				buffer.append("\"status\":\"").append("Arrived").append("\"").append(",");
			}
			buffer.append("\"requester\":\"").append(orderDO.getRequestName()).append("\"").append(",");
			buffer.append("\"GMT_MODIFIED\":\"").append(orderDO.getGmtModified()).append("\"");
			buffer.append("}");
			if(i != orderList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}
}

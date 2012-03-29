package com.cisco.assetscenter.web.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.OrderService;
import com.cisco.assetscenter.web.util.JsonUtils;

public class OrderDeleteController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderDeleteController.class);
	private OrderService orderService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String method = request.getParameter("method");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		if(StringUtils.isEmpty(name)) {
			name = "";
		}
		if(StringUtils.isEmpty(status)) {
			status = "-1";
		}
		if(StringUtils.isEmpty(startTime)) {
			startTime = "";
		}
		if(StringUtils.isEmpty(endTime)) {
			endTime = "";
		}
		String queryString = "?name=&status=-1&startTime=&endTime=";
		if(StringUtils.isNotBlank(method)) {
			if("delete".equalsIgnoreCase(method)) {
				if(StringUtils.isNotBlank(id)) {
					orderService.deleteOrderById(Integer.parseInt(id));
					HttpSession session = request.getSession();
					UserDO user  = (UserDO) session.getAttribute("user");
					if(null != user)
						logger.warn("The user [ " + user.getUsername() + " ]" + " delete order id : " + id);
					queryString = "?name=" + name + "&status=" + status + "&startTime=" + startTime + "&endTime=" + endTime;
				}
			}
		}
		return new ModelAndView("order/order_ajax", "queryString", JsonUtils.convertHtmlChar(queryString));
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

}

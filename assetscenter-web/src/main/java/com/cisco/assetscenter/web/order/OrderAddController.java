package com.cisco.assetscenter.web.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderAssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.OrderDO;
import com.cisco.assetscenter.service.asset.AssetTypeService;
import com.cisco.assetscenter.service.asset.OrderService;
import com.cisco.assetscenter.web.util.DateUtils;
import com.cisco.assetscenter.web.util.JsonUtils;

public class OrderAddController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderAddController.class);
	private OrderService orderService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		String requester = request.getParameter("requester");
		String description = request.getParameter("description");
		String[] types = request.getParameterValues("type");
		String[] expectTimes = request.getParameterValues("expectTime");
		String[] quantities = request.getParameterValues("quantity");
		OrderDO orderDO = new OrderDO();
		List<OrderAssetDO> assetList = new ArrayList<OrderAssetDO>();
		if(null != types) {
			for(int i = 0;i < types.length; i++) {
				OrderAssetDO orderAssetDO = new OrderAssetDO();
				AssetTypeDO assetType = assetTypeService.findAssetTypeByName(types[i]);
				/**
				 * If the asset type is not exist, we will create a new type.
				 */
				if(null == assetType) {
					assetType = new AssetTypeDO();
					assetType.setName(types[i]);
					assetType.setDescription(types[i]);
					assetTypeService.createAssetType(assetType);
				}
				orderAssetDO.setTypeName(types[i]);
				orderAssetDO.setExpectTime(DateUtils.convertStr2Str(expectTimes[i], DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
				orderAssetDO.setQuantity(Integer.parseInt(quantities[i]));
				assetList.add(orderAssetDO);
			}
		}
		orderDO.setName(name.trim());
		orderDO.setStatus(Integer.parseInt(status));
		orderDO.setDescription(description);
		orderDO.setAssetList(assetList);
		Date date = new Date();
		orderDO.setGmtCreate(DateUtils.convertDate2Str(date, DateUtils.DATABASE_ASSET_FORMAT));
		orderDO.setGmtModified(DateUtils.convertDate2Str(date, DateUtils.DATABASE_ASSET_FORMAT));
		orderDO.setRequestName(requester);
		orderService.createOrder(orderDO);
		//refresh the page.
		String queryString = "?name=&status=-1&startTime=&endTime=";
		return new ModelAndView("order/order_ajax", "queryString", JsonUtils.convertHtmlChar(queryString));
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	public void setAssetTypeService(AssetTypeService assetTypeService) {
		this.assetTypeService = assetTypeService;
	}

}

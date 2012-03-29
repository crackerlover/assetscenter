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

public class OrderEditController implements Controller {

	protected final Logger logger = Logger.getLogger(OrderAddController.class);
	private OrderService orderService;
	private AssetTypeService assetTypeService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderId = request.getParameter("orderId");
		String name = request.getParameter("name");
		String requester = request.getParameter("requester");
		String status = request.getParameter("status");
		String description = request.getParameter("description");
		String[] types = request.getParameterValues("type");
		String[] expectTimes = request.getParameterValues("expectTime");
		String[] quantities = request.getParameterValues("quantity");
		String[] orderAssetIds = request.getParameterValues("oai");
		String[] typeNews = request.getParameterValues("typeNew");
		String[] expectTimeNews = request.getParameterValues("expectTimeNew");
		String[] quantitiyNews = request.getParameterValues("quantityNew");
		OrderDO orderDO = new OrderDO();
		List<OrderAssetDO> assetList = new ArrayList<OrderAssetDO>();
		List<OrderAssetDO> assetListNew = new ArrayList<OrderAssetDO>();
		if(null != types && types.length > 0) {
			for(int i = 0;i < types.length; i++) {
				OrderAssetDO orderAssetDO = new OrderAssetDO();
				orderAssetDO.setId(Integer.parseInt(orderAssetIds[i]));
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
		if(null != typeNews && typeNews.length > 0) {
			for(int j = 0; j < typeNews.length; j ++) {
				OrderAssetDO orderAssetDO = new OrderAssetDO();
				orderAssetDO.setOrderId(Integer.parseInt(orderId));
				AssetTypeDO assetType = assetTypeService.findAssetTypeByName(typeNews[j]);
				/**
				 * If the asset type is not exist, we will create a new type.
				 */
				if(null == assetType) {
					assetType = new AssetTypeDO();
					assetType.setName(typeNews[j]);
					assetType.setDescription(typeNews[j]);
					assetTypeService.createAssetType(assetType);
				}
				orderAssetDO.setTypeName(typeNews[j]);
				orderAssetDO.setExpectTime(DateUtils.convertStr2Str(expectTimeNews[j], DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
				orderAssetDO.setQuantity(Integer.parseInt(quantitiyNews[j]));
				assetListNew.add(orderAssetDO);
			}
		}
		orderDO.setId(Integer.parseInt(orderId));
		orderDO.setName(name);
		orderDO.setStatus(Integer.parseInt(status));
		orderDO.setRequestName(requester);
		orderDO.setDescription(description);
		orderDO.setAssetList(assetList);
		Date date = new Date();
		orderDO.setGmtModified(DateUtils.convertDate2Str(date, DateUtils.DATABASE_ASSET_FORMAT));
		orderService.updateOrder(orderDO);
		orderService.createOrderAssetBatch(assetListNew);//create new order asset
		/**
		 * retrieve the database, find that whether we have remove some assets of the special order.
		 * If so, we will delete them from the database.
		 */
		OrderDO order = orderService.viewOrderById(Integer.parseInt(orderId));
		if(null != order) {
			List<OrderAssetDO> list = order.getAssetList();
			if(null != list) {
				List<Integer> ids = new ArrayList<Integer>();
				if(list.size() > assetList.size()) {
					list.removeAll(assetList);
					if(null != assetListNew && assetListNew.size() > 0) {
						for(OrderAssetDO temp : assetListNew) {
							for(OrderAssetDO orderAssetDO : list) {
								if(orderAssetDO.getOrderId() == temp.getOrderId()) {
									list.remove(orderAssetDO);
								}
							}
						}
					}
					for(OrderAssetDO orderAssetDO : list) {
						ids.add(orderAssetDO.getId());
					}
				} 
				if(null != ids && ids.size() > 0) {
					orderService.deleteOrderAssetBatch(ids.toArray(new Integer[]{}));
				}
			}
		}
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

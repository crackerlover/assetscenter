package com.cisco.assetscenter.web.transfer;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.query.TransferQuery;
import com.cisco.assetscenter.dao.dataobject.transfer.TransferDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.TransferService;
import com.cisco.assetscenter.web.util.DateUtils;

public class TransferViewController implements Controller {

	protected final Logger logger = Logger.getLogger(TransferViewController.class);
	private TransferService transferService;
	private AssetService assetService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String receive = request.getParameter("receive");
		String transfer = request.getParameter("transfer");
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		TransferQuery query = new TransferQuery();
		if(StringUtils.isNotBlank(orderBy)) {
			query.setOrderBy(orderBy);
		}
		if(StringUtils.isNotBlank(pageNo)) {
			query.setPageNO(Integer.parseInt(pageNo));
		}
		if(StringUtils.isNotBlank(pageSize)) {
			query.setPageSize(Integer.parseInt(pageSize));
		}
		if(StringUtils.isNotBlank(sort)) {
			query.setSort(sort);
		}
		if(StringUtils.isNotBlank(receive)) {
			query.setReceive(receive.trim());
		}
		if(StringUtils.isNotBlank(transfer)) {
			query.setTransfer(transfer.trim());
		}
		if(StringUtils.isNotBlank(type)) {
			query.setType(Integer.parseInt(type));
		}
		if(StringUtils.isNotBlank(status)) {
			query.setStatus(Integer.parseInt(status));
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<TransferDO> transferList = transferService.viewTransfersByQuery(query);
		int total = transferService.viewTransferQuantityByQuery(query);
		return new ModelAndView("transfer/transfer_view_json_data", "json_data", echoJsonData(transferList, total));
	}
	public void setTransferService(TransferService transferService) {
		this.transferService = transferService;
	}
	private String echoJsonData(List<TransferDO> transferList, int total) {
		if(null == transferList) {
			transferList = new ArrayList<TransferDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < transferList.size(); i ++) {
			TransferDO transfer = transferList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(transfer.getId()).append("\"").append(",");
			buffer.append("\"transfer\":\"").append(transfer.getTransfer()).append("\"").append(",");
			buffer.append("\"receive\":\"").append(transfer.getReceive()).append("\"").append(",");
			int status = transfer.getStatus();
			if(status == Constants.PENDING_TRANSFER_STATUS) {
				buffer.append("\"status\":\"").append("Pending").append("\"").append(",");
			}
			if(status == Constants.APPROVED_TRANSFER_STATUS) {
				buffer.append("\"status\":\"").append("Approved").append("\"").append(",");
			}
			int type = transfer.getType();
			if(type == Constants.E2E_TYPE) {
				buffer.append("\"type\":\"").append("Borrow").append("\"").append(",");
			}
			if(type == Constants.E2A_TYPE) {
				buffer.append("\"type\":\"").append("Transfer").append("\"").append(",");
			}
			AssetDO asset = assetService.viewAssetById(transfer.getMaterialId());
			if(null == asset) {
				buffer.append("\"sn\":\"").append("").append("\"").append(",");
			}
			else {
				buffer.append("\"sn\":\"").append(asset.getSn()).append("\"").append(",");
			}
			buffer.append("\"EXPECT_TIME\":\"").append(transfer.getExpectTime()).append("\"").append(",");
			buffer.append("\"TRANSFER_TIME\":\"").append(transfer.getTransferTime()).append("\"");
			buffer.append("}");
			if(i != transferList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}

}

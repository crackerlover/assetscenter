package com.cisco.assetscenter.service.asset.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.AssetDAO;
import com.cisco.assetscenter.dao.AssetTypeDAO;
import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.asset.AssetTypeDO;
import com.cisco.assetscenter.service.asset.ReportService;
import com.cisco.assetscenter.service.asset.util.ExcelUtils;

public class DefaultReportService implements ReportService {

	private AssetDAO assetDAO;
	private AssetTypeDAO cacheAssetTypeDAO;
	@Override
	public boolean batchImport(String file) {
		if(StringUtils.isEmpty(file)) {
			return false;
		}
		Map<String, List<String>> data = ExcelUtils.readExcel(file);
		if(null == data || data.size() < 1) {
			return false;
		}
		List<String> ELTMS_LIST = data.get(ExcelUtils.ELTMS);
		List<String> SN_LIST = data.get(ExcelUtils.SN);
		List<String> TYPE_LIST = data.get(ExcelUtils.TYPE);
		List<String> DESCRIPTION_LIST = data.get(ExcelUtils.DESCRIPTION);
		List<String> OWNER_LIST = data.get(ExcelUtils.OWNER);
		List<String> LOCATION_LIST = data.get(ExcelUtils.LOCATION);
		List<String> WAREHOUSE_TIME_LIST = data.get(ExcelUtils.WAREHOUSE_TIME);
		List<String> PRICE_RMB_LIST = data.get(ExcelUtils.PRICE_RMB);
		List<AssetDO> list = new ArrayList<AssetDO>();
		if(null == ELTMS_LIST || ELTMS_LIST.size() < 1) {
			return false;
		}
		for(int i = 0; i < ELTMS_LIST.size(); i ++) {
			AssetDO asset = new AssetDO();
			asset.setStatus(Constants.USED_ASSET_STATUS);
			asset.setEltms(trimNull(ELTMS_LIST.get(i)));
			asset.setOrderName("");
			asset.setPrice(0);
			if(null == SN_LIST || SN_LIST.size() < 1) {
				asset.setSn("");
			}
			else {
				String sn = trimNull(SN_LIST.get(i));
				//if the data exists in the database, we will continue.
				AssetDO tmp = assetDAO.loadAssetBySN(sn);
				if(null != tmp) {
					continue;
				}
				asset.setSn(trimNull(SN_LIST.get(i)));
			}
			if(null == TYPE_LIST || TYPE_LIST.size() < 1) {
				asset.setTypeId(0);
			}
			else {
				if("".equals(trimNull(TYPE_LIST.get(i)).trim())) {
					asset.setTypeId(0);
				}
				AssetTypeDO type = cacheAssetTypeDAO.findAssetTypeByName(trimNull(TYPE_LIST.get(i)));
				if(null == type) {
					type = new AssetTypeDO();
					type.setName(trimNull(TYPE_LIST.get(i)));
					type.setDescription(trimNull(TYPE_LIST.get(i)));
					asset.setTypeId(cacheAssetTypeDAO.insert(type));
				}
				else {
					asset.setTypeId(cacheAssetTypeDAO.findAssetTypeByName(trimNull(TYPE_LIST.get(i))).getId());
				}
			}
			if(null == DESCRIPTION_LIST || DESCRIPTION_LIST.size() < 1) {
				asset.setDescription("");
			}
			else {
				asset.setDescription(trimNull(DESCRIPTION_LIST.get(i)));
			}
			if(null == OWNER_LIST || OWNER_LIST.size() < 1) {
				asset.setOwnerName("");
			}
			else {
				asset.setOwnerName(trimNull(OWNER_LIST.get(i)));
				asset.setUserName(trimNull(OWNER_LIST.get(i)));
			}
			if(null == LOCATION_LIST || LOCATION_LIST.size() < 1) {
				asset.setLocation("");
			}
			else {
				asset.setLocation(trimNull(LOCATION_LIST.get(i)));
			}
			if(null == WAREHOUSE_TIME_LIST || WAREHOUSE_TIME_LIST.size() < 1) {
				asset.setWarehouseTime("");
			}
			else {
				asset.setWarehouseTime(trimNull(WAREHOUSE_TIME_LIST.get(i)));
			}
			if(null != PRICE_RMB_LIST && PRICE_RMB_LIST.size() > 0) {
				String price = trimNull(PRICE_RMB_LIST.get(i));
				if(!"".equals(price)) {
					price = price.replaceAll(",", "");
					asset.setPrice(Double.parseDouble(price));
				}
			}
			list.add(asset);
		}
		return null != assetDAO.batchInsert(list);
	}
	public void setAssetDAO(AssetDAO assetDAO) {
		this.assetDAO = assetDAO;
	}
	public void setCacheAssetTypeDAO(AssetTypeDAO cacheAssetTypeDAO) {
		this.cacheAssetTypeDAO = cacheAssetTypeDAO;
	}
	
	private String trimNull(String source) {
		if(null == source) {
			source = "";
		}
		return source;
	}
	
}

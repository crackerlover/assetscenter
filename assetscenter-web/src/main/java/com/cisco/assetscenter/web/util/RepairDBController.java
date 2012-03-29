package com.cisco.assetscenter.web.util;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.asset.AssetDO;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.AssetService;
import com.cisco.assetscenter.service.asset.UserService;

public class RepairDBController implements Controller {

	private AssetService assetService;
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String type = request.getParameter("type");
		if("1".equalsIgnoreCase(type)) {
			List<AssetDO> list = assetService.loadAllAssets();
			if(null != list) {
				for(AssetDO asset: list) {
					AssetDO tmp = new AssetDO();
					tmp.setId(asset.getId());
					tmp.setTypeId(asset.getTypeId());
					tmp.setStatus(asset.getStatus());
					tmp.setSn(trimStr(asset.getSn()));
					tmp.setDescription(trimStr(asset.getDescription()));
					tmp.setEltms(trimStr(asset.getEltms()));
					tmp.setOrderName(trimStr(asset.getOrderName()));
					tmp.setOwnerName(trimStr(asset.getOwnerName()));
					tmp.setWarehouseTime(trimStr(asset.getWarehouseTime()));
					tmp.setLocation(trimStr(asset.getLocation()));
					tmp.setPrice(asset.getPrice());
					tmp.setUserName(trimStr(asset.getOwnerName()));
					boolean rs = assetService.updateAsset(tmp);
					if(!rs) {
						return new ModelAndView("message/rep_msg", "success", false);
					}
				}
			}
		}
		if("2".equals(type)) {
			List<AssetDO> list = assetService.loadAllAssets();
			Set<String> nameSet = new HashSet<String>();
			if(null != list) {
				for(AssetDO asset: list) {
					nameSet.add(asset.getUserName().trim());
				}
			}
			if(nameSet.size() > 0) {
				for(Iterator<String> it = nameSet.iterator();it.hasNext();) {
					String name = it.next();
					UserDO user = new UserDO();
					user.setUsername(name.trim());
					user.setFullName(name.trim());
					user.setPassword("");
					user.setRole(Constants.USER_ROLE);
					user.setEmail(name.trim() + "@cisco.com");
					user.setGmtCreate(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
					user.setGmtModified(DateUtils.convertDate2Str(new Date(), DateUtils.DATABASE_ASSET_FORMAT));
					UserDO tmp = userService.findUserByUserName(name.trim());
					if(null == tmp) {
						boolean rs = userService.createUser(user);
						if(!rs) {
							return new ModelAndView("message/rep_msg", "success", false);
						}
					}
				}
			}
		}
		return new ModelAndView("message/rep_msg", "success", true);
	}
	public void setAssetService(AssetService assetService) {
		this.assetService = assetService;
	}
	
	private String trimStr(String source) {
		if(StringUtils.isEmpty(source)) {
			source = "";
		}
		if("null".equalsIgnoreCase(source)) {
			source = "";
		}
		return source.trim();
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}

package com.cisco.assetscenter.web.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.dao.dataobject.query.UserQuery;
import com.cisco.assetscenter.dao.dataobject.user.UserDO;
import com.cisco.assetscenter.service.asset.UserService;
import com.cisco.assetscenter.web.util.DateUtils;

public class UserViewController implements Controller {

	protected final Logger logger = Logger.getLogger(UserViewController.class);
	private UserService userService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String orderBy = request.getParameter("sort");
		String pageNo = request.getParameter("page");
		String pageSize = request.getParameter("rows");
		String sort = request.getParameter("order");
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		UserQuery query = new UserQuery();
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
		if(StringUtils.isNotBlank(username)) {
			query.setUsername(username.trim());
		}
		if(StringUtils.isNotBlank(role)) {
			query.setRole(Integer.parseInt(role));
		}
		if(StringUtils.isNotBlank(startTime)) {
			query.setStartTime(DateUtils.convertStr2Str(startTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		if(StringUtils.isNotBlank(endTime)) {
			query.setEndTime(DateUtils.convertStr2Str(endTime, DateUtils.EASYUI_FORMAT, DateUtils.DATABASE_ASSET_FORMAT));
		}
		List<UserDO> userList = userService.viewUsersByQuery(query);
		int total  = userService.viewUserTotalQuantityByQuery(query);
		return new ModelAndView("user/user_view_json_data", "json_data", echoJsonData(userList, total));
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private String echoJsonData(List<UserDO> userList, int total) {
		if(null == userList) {
			userList = new ArrayList<UserDO>();
		} 
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"total\":").append(total);
		buffer.append(",").append("\"rows\":[");
		for(int i = 0; i < userList.size(); i ++) {
			UserDO userDO = userList.get(i);
			buffer.append("{");
			buffer.append("\"id\":\"").append(userDO.getId()).append("\"").append(",");
			buffer.append("\"USERNAME\":\"").append(userDO.getUsername()).append("\"").append(",");
			buffer.append("\"fullname\":\"").append(userDO.getFullName()).append("\"").append(",");
			String roleStr = "";
			switch(userDO.getRole()) {
			case 1:
				roleStr = "Viewer";
				break;
			case 2:
				roleStr = "User";
				break;
			case 3:
				roleStr = "Manager";
				break;
			case 4:
				roleStr = "Admin";
				break;
			}
			buffer.append("\"role\":\"").append(roleStr).append("\"").append(",");
			buffer.append("\"time\":\"").append(userDO.getGmtModified()).append("\"");
			buffer.append("}");
			if(i != userList.size() - 1) {
				buffer.append(",");
			}
		}
		buffer.append("]}");
		return buffer.toString();
	}

}

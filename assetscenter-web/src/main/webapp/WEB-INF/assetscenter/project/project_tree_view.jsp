<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cisco.assetscenter.dao.dataobject.user.*,com.cisco.assetscenter.dao.dataobject.*" %>
<%
	UserDO user = (UserDO)session.getAttribute("user");	
	if(null == user) {
		response.sendRedirect("requestDispatcher.do?url=login/login");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AssetsCenter</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/datagrid-detailview.js"></script>
	<script type="text/javascript">
	function initDataGrid(queryString){
		if(null == queryString) {
			queryString='?selectKey=&selectValue=&owner=&user=&tp=projects&type=-1&status=1&startTime=&endTime=&projectId=<%=request.getAttribute("id")%>';
		}
		queryString = queryString.replace(/&amp;/g, '&');
		$('#projectTreeView').datagrid({
			title:'Asset List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:false,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'assetView.do' + queryString,
		    sortName: 'WAREHOUSE_TIME',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'sn',title:'SN',width:120,rowspan:2,resizable:false},
				{field:'eltms',title:'elTMS',width:120,rowspan:2,resizable:false},
				{field:'type',title:'Type',width:120,rowspan:2,resizable:false},
				{field:'description',title:'Description',width:250,rowspan:2,resizable:false},
				{field:'user',title:'User',width:60,rowspan:2,resizable:false},
				{field:'WAREHOUSE_TIME',title:'Time',width:150,rowspan:2,resizable:false},
				{field:'status',title:'status',width:60,rowspan:2,resizable:false},
				{field:'location',title:'Location',width:150,rowspan:4,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#projectTreeView').datagrid('clearSelections');
            }  
		});
	}
	$(function() {
		$('#type').combobox({
			url:'assetTypeView.do?method=all',
			valueField:'id',
			textField:'text'
		});
		$('#search').linkbutton({  
			 plain:false  
		});  
		$('#search').linkbutton('enable');
	});
	function submitQuery(){
		$('#projectTreeForm').form('submit',{
			url:'assetAjaxRequest.do',
			success:function(queryString){
				initDataGrid(queryString);
			}
		});
	}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
			<form id="projectTreeForm" method="post">
			<input type="hidden" id="projectId" name="projectId" value="<%=request.getAttribute("id")%>">
			<input type="hidden" id="tp" name="tp" value="projects">
					<table align="center">
						<tr>
							<td>
								<select id="selectKey" class="easyui-combobox" name="selectKey" style="width:65px;" required="true">
									<option value="sn" selected="selected">SN</option>
									<option value="eltms">ELTMS</option>
								</select>
							</td>
							<td><input type="text" id="selectValue" name="selectValue" style="width:200px;"></td>
							<td><label>User:</label></td>
							<td><input type="text" id="user" name="user" style="width:200px;"></td>
						</tr>
						<tr>
							<td><label>Start Time:</label></td>
							<td><input id="startTime" name="startTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
							<td><label>End Time:</label></td>
							<td><input id="endTime" name="endTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
						</tr>
						<tr>
							<td><label>Status:</label></td>
							<td>
								<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
									<option value="1">Available</option>
									<option value="0">Not Available</option>
								</select>
							</td>
							<td><label>Type:</label></td>
							<td>
								<select id="type" class="easyui-combobox" name="type" style="width:207px;" required="true"/>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td><a href="#" id="search" iconCls="icon-search" onclick="javascript:submitQuery();">Search</a></td>
						</tr>
					</table>
					</form>
			</div>
			<div region="center" border="false">
				<table id="projectTreeView" toolbar="#toolbar"></table>
			</div>
		</div>
	</div>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
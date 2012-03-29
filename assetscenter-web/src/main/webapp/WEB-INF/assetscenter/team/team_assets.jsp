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
			queryString='?selectKey=&selectValue=&team=&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#teamAssets').datagrid({
			title:'Team Asset Setting',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'teamAsset.do' + queryString,  
		    sortName: 'SET_TIME',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'sn',title:'SN',width:120,rowspan:2,resizable:false},
				{field:'eltms',title:'elTMS',width:120,rowspan:2,resizable:false},
				{field:'owner',title:'User',width:60,rowspan:2,resizable:false},
				{field:'team',title:'Team',width:120,rowspan:2,resizable:false},
				{field:'SET_TIME',title:'Set Time',width:150,rowspan:2,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#teamAssets').datagrid('clearSelections');
            }  
		});
	}
	$(function(){
		$('#search').linkbutton({  
			 plain:false  
		});  
		$('#search').linkbutton('enable'); 
	});
	</script>
	<script type="text/javascript">
		function submitQuery(){
			$('#applyForm').form('submit',{
				url:'teamAssetsAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function setTeam() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 1) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#teamAssets').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#setTeam').window({
		            title:'Select the special team',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'setTeamInitial.do?id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="applyForm" method="post">
					<table align="center">
						<tr>
							<td>
								<select id="selectKey" class="easyui-combobox" name="selectKey" style="width:65px;" required="true">
									<option value="sn" selected="selected">SN</option>
									<option value="eltms">ELTMS</option>
								</select>
							</td>
							<td><input type="text" id="selectValue" name="selectValue" style="width:200px;"></td>
							<td><label>Team:</label></td>
							<td><input type="text" id="team" name="team" style="width:200px;"></td>
						</tr>
						<tr>
							<td><label>Start Time:</label></td>
							<td><input id="startTime" name="startTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
							<td><label>End Time:</label></td>
							<td><input id="endTime" name="endTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
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
					<div id="toolbar">  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:setTeam();">Set Team</a>  
					</div>
			</div>
			<div region="center" border="false">
				<table id="teamAssets" toolbar="#toolbar"></table>
			</div>
		</div>
	</div>
	<div id="setTeam" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
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
			queryString='?username=&role=2&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#userView').datagrid({
			title:'User List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'userView.do' + queryString,  
		    sortName: 'USERNAME',
			sortOrder: 'asc',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'USERNAME',title:'User ID',width:200,rowspan:2,resizable:false},
				{field:'fullname',title:'Full Name',width:200,rowspan:2,resizable:false},
				{field:'role',title:'Role Type',width:200,rowspan:2,resizable:false},
				{field:'time',title:'Time',width:200,rowspan:2,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#userView').datagrid('clearSelections');
            }  
		});
	}
	function delOrder() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || privilege != 'true') {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var row = $('#userView').datagrid('getSelected'); 
		if(null==row) {
			$.messager.alert('Warning','You must select a row firstly.'); 
			return;
		}
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to delete the [' + row.id + '] '+ row.USERNAME + ' user?',function(f){  
			    if (f){  
			    	$('#userForm').form('submit',{
						url:'userDelete.do?id='+row.id,
						success:function(queryString){
							initDataGrid(queryString);
						}
					}); 
			    }  
			});
		}  
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
			$('#userForm').form('submit',{
				url:'userAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function newWindow() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != 'true') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#userAdd').window({
		            title:'Add a new user',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'userInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != 'true') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#userView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#userEdit').window({
		            title:'Edit user information',
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
				    href:'userInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="userForm" method="post">
					<table align="center">
						<tr>
							<td><label>User:</label></td>
							<td><input id="username" name="username" style="width:200px;"/></td>
						</tr>
						<tr>
							<td><label>Role:</label></td>
							<td>
								<select id="role" class="easyui-combobox" name="role" style="width:207px;" required="true">
									<option value="2" selected="selected">User</option>
									<option value="1">Viewer</option>
									<option value="3">Manager</option>
									<option value="4">Admin</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><label>Start Time:</label></td>
							<td><input id="startTime" name="startTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
						</tr>
						<tr>
							<td><label>End Time:</label></td>
							<td><input id="endTime" name="endTime" class="easyui-datebox" required="false" style="width:207px;"></input></td>
						</tr>
						<tr>
							<td></td>
							<td><a href="#" id="search" iconCls="icon-search" onclick="javascript:submitQuery();">Search</a></td>
						</tr>
					</table>
					</form>
					<div id="toolbar">  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:newWindow();">New</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:editOrder();">Edit</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:delOrder();">Delete</a>  
					</div>
			</div>
			<div region="center" border="false">
				<table id="userView" toolbar="#toolbar"></table>
			</div>
			<form id="userInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="userAdd" class="easyui-window" style="width:400px;height:200px;padding:5px;" closed="true"></div>
	<div id="userEdit" class="easyui-window" style="width:400px;height:200px;padding:5px;" closed="true"></div>
	<input type="hidden" id="privilege" name="privilege" value="<%if(user.getRole() == Constants.ADMIN_ROLE){%>true<%}%>"/>
	<input type="hidden" id="editId" name="editId"/>
</body>
</html>
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
			queryString='?name=&status=-1&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#orderview').datagrid({
			title:'Order List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'orderView.do'+queryString,  
		    sortName: 'GMT_MODIFIED',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'Id',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'name',title:'Name',width:250,rowspan:2,resizable:false},
				{field:'status',title:'Status',width:120,rowspan:2,resizable:false},
				{field:'requester',title:'Requester',width:120,rowspan:2,resizable:false},
				{field:'GMT_MODIFIED',title:'Time',width:120,rowspan:2,resizable:false},
				{field:'description',title:'Description',width:300,rowspan:4,resizable:false}
			]],
		     view: detailview,  
		     detailFormatter: function(index,row){  
		    	 return '<div id="ddv-' + index + '" style="padding:5px 0"></div>';  
		     },  
		     onExpandRow: function(index,row){
					$('#ddv-'+index).panel({
						border:false,
						cache:false,
						href:'orderDetail.do?orderId='+row.id,
						onLoad:function(){
							$('#orderview').datagrid('fixDetailRowHeight',index);
						}
					});
					$('#orderview').datagrid('fixDetailRowHeight',index);
			},
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#orderview').datagrid('clearSelections');
            } 
		});
	}
	function delOrder() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || privilege < 3) {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var row = $('#orderview').datagrid('getSelected'); 
		if(null==row) {
			$.messager.alert('Warning','You must select a row firstly.'); 
			return;
		}
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to delete the [' + row.id + '] '+ row.name + ' order?',function(f){  
			    if (f){  
			    	$('#orderForm').form('submit',{
						url:'orderDelete.do?method=delete&id='+row.id,
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
			$('#orderForm').form('submit',{
				url:'orderAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function newWindow() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 3) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#orderAdd').window({
		            title:'Create a new order',
		            width: 850,
		            height: 400,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'orderInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 3) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#orderview').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#orderEdit').window({
		            title:'Edit order information',
		            width: 850,
		            height: 400,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'orderInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="orderForm" method="post">
					<table align="center">
						<tr>
							<td><label>Name:</label></td>
							<td><input type="text" id="name" name="name" style="width:200px;"></td>
						</tr>
						<tr>
							<td><label>Status:</label></td>
							<td>
								<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
									<option value="-1" selected="selected">All</option>
									<option value="1">Arrived</option>
									<option value="2">Part Arrived</option>
									<option value="0">Not Arrived</option>
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
				<table id="orderview" toolbar="#toolbar"></table>
			</div>
			<form id="orderInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="orderAdd" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="orderEdit" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
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
			queryString='?title=&type=-1&status=0&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#caseView').datagrid({
			title:'Case List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'caseView.do' + queryString,  
		    sortName: 'EXPECT_TIME',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'title',title:'Title',width:250,rowspan:2,resizable:false},
				{field:'type',title:'Type',width:80,rowspan:2,resizable:false},
				{field:'requester',title:'Requester',width:80,rowspan:2,resizable:false},
				{field:'tos',title:'operator(s)',width:150,rowspan:2,resizable:false},
				{field:'status',title:'status',width:80,rowspan:2,resizable:false},
				{field:'EXPECT_TIME',title:'Expect Time',width:150,rowspan:2,resizable:false},
				{field:'GMT_CREATE',title:'Create Time',width:120,rowspan:2,resizable:false},
				{field:'GMT_FINISH',title:'Close Time',width:120,rowspan:2,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#caseView').datagrid('clearSelections');
            }  
		});
	}
	function delOrder() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || privilege != '4') {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var row = $('#caseView').datagrid('getSelected'); 
		if(null==row) {
			$.messager.alert('Warning','You must select a row firstly.'); 
			return;
		}
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to delete the [' + row.id + '] '+ row.title + ' case?',function(f){  
			    if (f){  
			    	$('#caseForm').form('submit',{
						url:'caseDelete.do?id='+row.id,
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
	$(function() {
		$('#type').combobox({
			url:'caseTypeView.do?method=all',
			valueField:'id',
			textField:'text'
		});
	});
	</script>
	<script type="text/javascript">
		function submitQuery(){
			$('#caseForm').form('submit',{
				url:'caseAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function newWindow() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 2) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#caseAdd').window({
		            title:'Add a new case',
		            width: 600,
		            height: 350,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'caseInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 2) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#caseView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#caseEdit').window({
		            title:'Edit case information',
		            width: 600,
		            height: 500,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'caseInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
	<script type="text/javascript">
		function confirmCase() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != '4') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#caseView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#confirmCase').window({
		            title:'Confirm the case operation',
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
				    href:'caseInitial.do?method=confirm&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="caseForm" method="post">
					<table align="center">
						<tr>
							<td><label>Type:</label></td>
							<td><input id="type" name="type" style="width:200px;"/></td>
						</tr>
						<tr>
							<td><label>Title:</label></td>
							<td><input type="text" id="title" name="title" style="width:200px;"></td>
						</tr>
						<tr>
							<td><label>Status:</label></td>
							<td>
								<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
									<option value="0" selected="selected">Pending</option>
									<option value="1">Closed</option>
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
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:editOrder();">View</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:delOrder();">Delete</a> 
					    <!-- <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:confirmCase();">Confirm</a> --> 
					</div>
			</div>
			<div region="center" border="false">
				<table id="caseView" toolbar="#toolbar"></table>
			</div>
			<form id="caseInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="caseAdd" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="caseEdit" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
	<div id="confirmCase" class="easyui-window" closed="true"></div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cisco.assetscenter.dao.dataobject.user.*,com.cisco.assetscenter.dao.dataobject.*" %>
<%
	UserDO user = (UserDO)session.getAttribute("user");	
%>
<%
	if(null != user) {
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
			queryString='?selectKey=&selectValue=&owner=&user=&tp=&type=-1&status=1&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#assetView').datagrid({
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
				{field:'type',title:'Type',width:120,rowspan:2,resizable:false},
				{field:'sn',title:'SN',width:120,rowspan:2,resizable:false},
				{field:'eltms',title:'elTMS',width:120,rowspan:2,resizable:false},
				{field:'description',title:'Description',width:250,rowspan:2,resizable:false},
				{field:'owner',title:'Owner',width:100,rowspan:2,resizable:false},
				{field:'user',title:'User',width:100,rowspan:2,resizable:false},
				{field:'WAREHOUSE_TIME',title:'Time',width:120,rowspan:2,resizable:false},
				{field:'status',title:'Status',width:60,rowspan:2,resizable:false},
				{field:'price',title:'Price(RMB)',width:100,rowspan:2,resizable:false},
				{field:'location',title:'Location',width:150,rowspan:4,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#assetView').datagrid('clearSelections');
            }  
		});
		$('#type').combobox({
			url:'assetTypeView.do?method=all',
			valueField:'id',
			textField:'text'
		});
	}
	function delOrder() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || privilege != '4') {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var rows = $('#assetView').datagrid('getSelections');
		if(0 == rows.length) {
			$.messager.alert('Warning','You must select an asset.'); 
			return;
		}
		var ids = '';
		for(var i = 0; i < rows.length; i ++) {
			ids += rows[i].id;
			if(i != rows.length - 1) {
				ids += ',';
			}
		}
		if (rows){
			$.messager.confirm('Confirm','Are you sure you want to delete the selected assets?',function(f){  
			    if (f){  
			    	$('#assetForm').form('submit',{
						url:'assetDelete.do?id='+ids,
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
			$('#assetForm').form('submit',{
				url:'assetAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function newWindow() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != '4') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#assetAdd').window({
		            title:'Add a new asset',
		            width: 620,
		            height: 450,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'assetInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != '4') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#assetView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#assetEdit').window({
		            title:'Edit asset information',
		            width: 620,
		            height: 450,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'assetInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
		function borrowOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 2) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#assetView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select an asset.'); 
				return;
			}
			var $win;
		    $win = $('#assetTransfer').window({
		            title:'Transfer information',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-back',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'assetInitial.do?method=transfer&id='+row.id
		         });
		   
		    $win.window('open');
		}
		
		function batchImport() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 4) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#batchImport').window({
		            title:'Batch Import Asset Datas',
		            width: 400,
		            height: 250,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-redo',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'assetInitial.do?method=import'
		         });
		   
		    $win.window('open');
		}
		
		function batchStatus() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege < 4) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var rows = $('#assetView').datagrid('getSelections');
			if(0 == rows.length) {
				$.messager.alert('Warning','You must select an asset.'); 
				return;
			}
			var ids = '';
			for(var i = 0; i < rows.length; i ++) {
				ids += rows[i].id;
				if(i != rows.length - 1) {
					ids += ',';
				}
			}
			var $win;
		    $win = $('#batchStatus').window({
		            title:'Batch info modify',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-ok',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'assetInitial.do?method=status&ids='+ids
		         });
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="assetForm" method="post">
					<input type="hidden" id="tp" name="tp" value="teams">
					<table align="center">
						<tr>
							<td>
								<select id="selectKey" class="easyui-combobox" name="selectKey" style="width:65px;" required="true">
									<option value="sn" selected="selected">SN</option>
									<option value="eltms">ELTMS</option>
								</select>
							</td>
							<td><input type="text" id="selectValue" name="selectValue" style="width:200px;"></td>
							<td><label>Owner:</label></td>
							<td><input type="text" id="owner" name="owner" style="width:200px;"></td>
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
							<td><label>User:</label></td>
							<td><input type="text" id="user" name="user" style="width:200px;"></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td><a href="#" id="search" iconCls="icon-search" onclick="javascript:submitQuery();">Search</a></td>
						</tr>
					</table>
					</form>
					<div id="toolbar">  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:newWindow();">New</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:editOrder();">Edit</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:delOrder();">Delete</a>  
						<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-back" onClick="javascript:borrowOrder();">Borrow</a>
						<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-redo" onClick="javascript:batchImport();">Import</a>
						<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-ok" onClick="javascript:batchStatus();">Info</a>
					</div>
			</div>
			<div region="center" border="false">
				<table id="assetView" toolbar="#toolbar"></table>
			</div>
			<form id="orderInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="assetAdd" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="assetEdit" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="assetTransfer" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="batchImport" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="batchStatus" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
<% }%>
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
			queryString='?name=&description=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#caseTypeView').datagrid({
			title:'Casetype List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'viewCaseType.do'+queryString,  
		    sortName: 'NAME',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'Id',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'name',title:'Name',width:250,rowspan:2,resizable:false},
				{field:'description',title:'Description',width:300,rowspan:4,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#caseTypeView').datagrid('clearSelections');
            }  
		});
	}
	function delOrder() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || privilege != '4') {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var row = $('#caseTypeView').datagrid('getSelected'); 
		if(null==row) {
			$.messager.alert('Warning','You must select a row firstly.'); 
			return;
		}
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to delete the [' + row.id + '] '+ row.name + ' case type?',function(f){  
			    if (f){  
			    	$('#caseTypeForm').form('submit',{
						url:'casetypeDelete.do?method=delete&id='+row.id,
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
			$('#caseTypeForm').form('submit',{
				url:'casetypeAjaxRequest.do',
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
		    $win = $('#caseTypeAdd').window({
		            title:'Create a new Casetype',
		            width: 650,
		            height: 250,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'casetypeInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editOrder() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != '4') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#caseTypeView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#caseTypeEdit').window({
		            title:'Edit Case Type',
		            width: 650,
		            height: 250,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'casetypeInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="caseTypeForm" method="post">
					<table align="center">
						<tr>
							<td><label>Name:</label></td>
							<td><input type="text" id="name" name="name" style="width:200px"></td>
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
				<table id="caseTypeView" toolbar="#toolbar"></table>
			</div>
			<form id="orderInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="caseTypeAdd" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="caseTypeEdit" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
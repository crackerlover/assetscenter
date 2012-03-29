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
			queryString='?transfer=&receive=&type=-1&status=&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#transferView').datagrid({
			title:'Transfer History',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'transferView.do' + queryString,  
		    sortName: 'EXPECT_TIME',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'transfer',title:'Transferer',width:120,rowspan:2,resizable:false},
				{field:'receive',title:'Receiver',width:120,rowspan:2,resizable:false},
				{field:'status',title:'Status',width:100,rowspan:2,resizable:false},
				{field:'type',title:'Type',width:100,rowspan:2,resizable:false},
				{field:'sn',title:'Asset(SN)',width:120,rowspan:2,resizable:false},
				{field:'EXPECT_TIME',title:'Expect Time',width:150,rowspan:2,resizable:false},
				{field:'TRANSFER_TIME',title:'Transfer Time',width:150,rowspan:2,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#transferView').datagrid('clearSelections');
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
			$('#transferForm').form('submit',{
				url:'transferAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function confirmTransfer() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || privilege != '4') {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#transferView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#confirmTransfer').window({
		            title:'Confirm the transfer operation',
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
				    href:'transferInitial.do?method=confirm&id='+row.id
		         });
		   
		    $win.window('open');
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="transferForm" method="post">
					<table align="center">
						<tr>
							<td><label>Transferer:</label></td>
							<td><input type="text" id="transfer" name="transfer" style="width:200px;"></td>
							<td><label>Receiver:</label></td>
							<td><input type="text" id="receive" name="receive" style="width:200px;"></td>
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
									<option value="0" selected="selected">Pending</option>
									<option value="1">Approved</option>
								</select>
							</td>
							<td><label>Type:</label></td>
							<td>
								<select id="type" class="easyui-combobox" name="type" style="width:207px;" required="true">
									<option value="-1" selected="selected">All</option>
									<option value="0" selected="selected">Transfer</option>
									<option value="1">Borrow</option>
								</select>
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
					<div id="toolbar">  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:confirmTransfer();">Confirm</a>  
					</div>
			</div>
			<div region="center" border="false">
				<table id="transferView" toolbar="#toolbar"></table>
			</div>
			<form id="orderInitialForm" method="post">
				<input id="init" name="init" type="hidden">
			</form>
		</div>
	</div>
	<div id="confirmTransfer" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
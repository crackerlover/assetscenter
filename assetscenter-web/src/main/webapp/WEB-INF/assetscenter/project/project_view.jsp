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
			queryString='?name=&startTime=&endTime=';
		}
		queryString = queryString.replace(/&amp;/g, '&')
		$('#projectView').datagrid({
			title:'Project List',  
		    width:'auto',  
		    height:'auto',  
		    remoteSort:false,  
		    singleSelect:true,  
		    nowrap:false,  
		    fitColumns:false, 
		    pageList:[10, 15, 20],
		    url:'viewProject.do' + queryString,  
		    sortName: 'GMT_CREATE',
			sortOrder: 'desc',
			idField:'id',
			frozenColumns:[[
				{field:'ck',checkbox:true},
				{title:'ID',field:'id',width:50,sortable:true,hidden:true}
			]],
			columns:[[
				{field:'name',title:'Name',width:120,rowspan:2,resizable:false},
				{field:'managers',title:'Manager(s)',width:120,rowspan:2,resizable:false},
				{field:'START_TIME',title:'Expect Time',width:150,rowspan:2,resizable:false},
				{field:'END_TIME',title:'End Time',width:150,rowspan:2,resizable:false},
				{field:'GMT_CREATE',title:'Create Time',width:150,rowspan:2,resizable:false},
				{field:'description',title:'Description',width:300,rowspan:2,resizable:false}
			]],
			pagination:true,
			rownumbers:true,
			onLoadSuccess:function(){  
                $('#projectView').datagrid('clearSelections');
            }  
		});
	}
	function delProject() {
		var privilege = document.getElementById('privilege').value;
		if(null == privilege || privilege == '' || parseInt(privilege) < 3) {
			$.messager.alert('Warning','You don\'t have privilege to do this.'); 
			return;
		}
		var row = $('#projectView').datagrid('getSelected'); 
		if(null==row) {
			$.messager.alert('Warning','You must select a row firstly.'); 
			return;
		}
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to delete the [' + row.id + '] '+ row.name + ' project?',function(f){  
			    if (f){  
			    	$('#projectForm').form('submit',{
						url:'projectDelete.do?id='+row.id,
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
			$('#projectForm').form('submit',{
				url:'projectAjaxRequest.do',
				success:function(queryString){
					initDataGrid(queryString);
				}
			});
		}
	</script>
	<script type="text/javascript">
		function newWindow() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 3) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var $win;
		    $win = $('#projectAdd').window({
		            title:'Add a new project',
		            width: 630,
		            height: 330,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    cache:false,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    href:'projectInitial.do?method=add'
		         });
		   
		    $win.window('open');
		}
		function editProject() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 3) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#projectView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			document.getElementById('editId').value = row.id;
			var $win;
		    $win = $('#projectEdit').window({
		            title:'Edit project information',
		            width: 630,
		            height: 330,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-edit',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'projectInitial.do?method=edit&id='+row.id
		         });
		   
		    $win.window('open');
		}
		function apply() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 2) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#projectView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			var $win;
		    $win = $('#applyProject').window({
		            title:'Join a Project',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'projectInitial.do?method=apply&id='+row.id
		         });
		   
		    $win.window('open');
			
		}
		
		function addMember() {
			var privilege = document.getElementById('privilege').value;
			if(null == privilege || privilege == '' || parseInt(privilege) < 3) {
				$.messager.alert('Warning','You don\'t have privilege to do this.'); 
				return;
			}
			var row = $('#projectView').datagrid('getSelected');
			if(null==row) {
				$.messager.alert('Warning','You must select a row firstly.'); 
				return;
			}
			var $win;
		    $win = $('#addMember').window({
		            title:'Add members for a Project',
		            width: 400,
		            height: 200,
		            shadow: true,
		            modal:true,
		            iconCls:'icon-add',
				    closed:true,
				    minimizable:false,
				    maximizable:false,
				    collapsible:false,
				    cache:false,
				    href:'projectInitial.do?method=addMember&id='+row.id
		         });
		   
		    $win.window('open');
			
		}
	</script>
</head>
<body class="easyui-layout" onload="initDataGrid()">
		<div region="center" border="false">
		<div class="easyui-layout" fit="true">
			<div region="north" split="true" border="false" style="height:200px">
					<form id="projectForm" method="post">
					<table align="center">
						<tr>
							<td><label>Name:</label></td>
							<td><input id="name" name="name" style="width:200px;"/></td>
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
					    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="javascript:editProject();">Edit</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:delProject();">Delete</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="javascript:apply();">Join</a>  
					    <a href="#" class="easyui-linkbutton" iconCls="icon-sum" plain="true" onclick="javascript:addMember();">Add Member</a>
					</div>
			</div>
			<div region="center" border="false">
				<table id="projectView" toolbar="#toolbar"></table>
			</div>
		</div>
	</div>
	<div id="projectAdd" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="projectEdit" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="applyProject" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<div id="addMember" class="easyui-window" style="width:800px;height:400px;padding:5px;" closed="true"></div>
	<input type="hidden" id="editId" name="editId"/>
	<input type="hidden" id="privilege" name="privilege" value="<%=user.getRole()%>"/>
</body>
</html>
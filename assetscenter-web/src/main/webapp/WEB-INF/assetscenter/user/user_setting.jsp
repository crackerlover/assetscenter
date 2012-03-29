<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AssetsCenter</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#team').combobox({
				url:'teamView.do',
				valueField:'text',
				textField:'text',
				multiple:"true",
				panelHeight:"auto",
				width:283
			});
			$('#project').combobox({
				url:'projectView.do',
				valueField:'text',
				textField:'text',
				multiple:"true",
				panelHeight:"auto",
				width:283
			});
		});
		function saveUser() {
			$('#userForm').form('submit',{
				url:'userSet.do',
				onSubmit: function(){ 
					//alert('Do some checking...');
				},
				success:function(queryString){
					if(queryString == 'true') {
						$.messager.alert('Info','Congratulations, Saving success...'); 
						return;
					}
				}
			});
		}
	</script>
</head>
<body>
	<form id="userForm" method="post">
	<br/>
	<br/>
	<table>
		<tr>
			<td><label style="width:150;font-size:13px">&nbsp;&nbsp;&nbsp;&nbsp;Select Team(s):</label></td>
			<td><input class="easyui-combobox" id="team" name="teams"/></td>
		</tr>
		<tr>
			<td><label style="width:150;font-size:13px">&nbsp;&nbsp;&nbsp;&nbsp;Select Project(s):</label></td>
			<td><input class="easyui-combobox" id="project" name="projects"/></td>
		</tr>
		<tr>
			<td></td>
			<td><a href="#" class="easyui-linkbutton" plain="false" iconCls="icon-save" onclick="javascript:saveUser();">&nbsp;Save&nbsp;</a></td>
		</tr>
	</table>
	</form>
</body>
</html>
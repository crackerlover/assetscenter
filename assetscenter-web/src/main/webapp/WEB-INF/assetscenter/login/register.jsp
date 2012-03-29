<%@page import="com.cisco.assetscenter.dao.dataobject.team.*, java.util.*,com.cisco.assetscenter.web.util.*,
               com.cisco.assetscenter.dao.dataobject.project.* " %>

<script type="text/javascript">
function submitReg(){
	$('#registerForm').form('submit',{
		url:'register.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(){
			$.messager.alert('Info','Your register is success, waiting for the admin confirm!');
			$('#registerwin').window('close');
		}
	});
}
</script>

<script type="text/javascript">
function closeW() {
	$('#registerwin').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="registerForm" method="post">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td><input class="easyui-validatebox" type="text" name="name" style="width:200px;" required="true"></input></td>
				</tr>
				<tr>  
					<td><label for="fullname">FullName:</label></td>
					<td><input id="fullname" name="fullname" style="width:200px;" required="true"></input></td>
				</tr>
				<tr>
				    <td><label for="role">Role:</label></td>
				    <td>
						<select id="role" class="easyui-combobox" name="role" style="width:207px;" required="true">
							<option value="2" selected="selected">User</option>
  					        <option value="1">Viewer</option>
							<option value="3">Manager</option>
							<option value="4">Admin</option>
						</select>
					</td>
			   </tr>															
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitReg();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeW();">Cancel</a>
		</div>
</div>

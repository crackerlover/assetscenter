<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#userAddForm').form('submit',{
		url:'userAdd.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#userAdd').window('close');
		}
	});
}
function closeAddW() {
	$('#userAdd').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="userAddForm" method="post">
			<table>
				<tr>
					<td><label for="name">User ID:</label></td>
					<td>
						<input id="usernameAdd" name="username" required="true" style="width:200px;">
					</td>
				</tr>
				<tr>
					<td><label for="name">Full Name:</label></td>
					<td>
						<input id="fullnameAdd" name="fullname" required="true" style="width:200px;">
					</td>
				</tr>
				<tr>
					<td><label>Role Type:</label></td>
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
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
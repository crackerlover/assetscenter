<script type="text/javascript">
function submitTransfer(){
	$('#confirmForm').form('submit',{
		url:'status.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','The batch operation is success!'); 
			initDataGrid(queryString);
			$('#batchStatus').window('close');
		}
	});
}
function closeTransferW() {
	$('#batchStatus').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="confirmForm" method="post">
			<input type="hidden" id="ids" name="ids" value="<%=request.getAttribute("ids") %>">
			<table>
				<tr>
					<td><label>Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="1" selected="selected">Avaliable</option>
							<option value="0" >Not Avaliable</option>
						</select>
					</td>
					<tr>
						<td><label for="name">Owner:</label></td>
						<td><input class="easyui-validatebox" type="text" name="owner" required="true" style="width:200px;"></input></td>
					</tr>
					<tr>
						<td><label for="name">User:</label></td>
						<td><input class="easyui-validatebox" type="text" name="user" required="true" style="width:200px;"></input></td>
					</tr>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitTransfer();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeTransferW();">Cancel</a>
		</div>
</div>
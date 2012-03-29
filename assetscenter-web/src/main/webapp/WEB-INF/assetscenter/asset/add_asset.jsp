<script type="text/javascript">
$(function(){
	$('#typeAdd').combobox({
		url:'assetTypeView.do',
		valueField:'text',
		textField:'text'
	});
});
</script>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#asetAddForm').form('submit',{
		url:'assetAdd.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#assetAdd').window('close');
		}
	});
}
function closeAddW() {
	$('#assetAdd').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="asetAddForm" method="post">
			<table>
				<tr>
					<td><label for="name">SN:</label></td>
					<td><input class="easyui-validatebox" type="text" name="sn" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">ELTMS:</label></td>
					<td><input class="easyui-validatebox" type="text" name="eltms" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="1">Available</option>
							<option value="0">Not Available</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">Type:</label></td>
					<td>
						<!-- <select id="typeAdd" class="easyui-combobox" name="type" style="width:140px;" required="true"/> -->
						<input id="typeAdd" name="type" style="width:207px;">
					</td>
				</tr>
				<tr>
					<td><label for="name">Warehouse Time:</label></td>
					<td><input id="WAREHOUSE_TIME_ADD" name="WAREHOUSE_TIME" class="easyui-datebox" style="width:207px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Owner:</label></td>
					<td><input class="easyui-validatebox" type="text" name="owner" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">User:</label></td>
					<td><input class="easyui-validatebox" type="text" name="user" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Order:</label></td>
					<td><input class="easyui-validatebox" type="text" name="order" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Price(RMB):</label></td>
					<td><input class="easyui-validatebox" type="text" name="price" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Location:</label></td>
					<td><input class="easyui-validatebox" type="text" name="location" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="2" cols="40" id="description" name="description"></textarea> </td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
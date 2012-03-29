<script type="text/javascript">
function submitTransfer(){
	$('#transferAssetForm').form('submit',{
		url:'transfer.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','The transfer operation is success, please wait the reply!'); 
			initDataGrid(queryString);
			$('#assetTransfer').window('close');
		}
	});
}
function closeTransferW() {
	$('#assetTransfer').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="transferAssetForm" method="post">
			<input type="hidden" id="id" name="id" value="<%=(String)request.getAttribute("id")%>">
			<table>
				<tr>
					<td><label for="name">Back Time:</label></td>
					<td><input id="expectTime" name="expectTime" class="easyui-datebox" required="true" style="width:207px;"></input></td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitTransfer();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeTransferW();">Cancel</a>
		</div>
</div>
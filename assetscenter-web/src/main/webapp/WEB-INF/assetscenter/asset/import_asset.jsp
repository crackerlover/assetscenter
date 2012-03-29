<script type="text/javascript">
function submitTransfer(){
	$('#batchImportForm').form('submit',{
		url:'batchImport.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#batchImport').window('close');
			$.messager.alert('Info','The batch import operation is success!'); 
		}
	});
}
function closeTransferW() {
	$('#batchImport').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="batchImportForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td><label for="name">Select a file:</label></td>
					<td><input type="file" id="file" name="file"/></td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitTransfer();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeTransferW();">Cancel</a>
		</div>
</div>
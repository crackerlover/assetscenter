<script type="text/javascript">
function submitTransfer(){
	$('#applyForm').form('submit',{
		url:'applyTeam.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','Waiting for confirming!'); 
			initDataGrid(queryString);
			$('#applyTeam').window('close');
			//parent.location.href='requestDispatcher.do?url=main';
		}
	});
}
function closeTransferW() {
	$('#applyTeam').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="applyForm" method="post">
			<input type="hidden" id="id" name="id" value="<%=(String)request.getAttribute("id")%>">
			<table>
				<tr>
					<td><label for="name">Team Role:</label></td>
					<td>
						<select id="role" class="easyui-combobox" name="role" style="width:140px;" required="true">
							<option value="1" selected="selected">Engineer</option>
							<option value="2">Manager</option>
						</select>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitTransfer();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeTransferW();">Cancel</a>
		</div>
</div>
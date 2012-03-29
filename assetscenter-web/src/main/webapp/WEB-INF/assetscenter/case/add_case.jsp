<script type="text/javascript">
$(function(){
	$('#typeAdd').combobox({
		url:'caseTypeView.do',
		valueField:'text',
		textField:'text'
	});
});
</script>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#caseAddForm').form('submit',{
		url:'caseAdd.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#caseAdd').window('close');
		}
	});
}
function closeAddW() {
	$('#caseAdd').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="caseAddForm" method="post">
			<table>
				<tr>
					<td><label for="name">Type:</label></td>
					<td>
						<input id="typeAdd" name="type" required="true" style="width:207px;">
					</td>
				</tr>
				<tr>
					<td><label for="name">To(s):</label></td>
					<td><input class="easyui-validatebox" type="to" name="to" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Title:</label></td>
					<td><input class="easyui-validatebox" type="text" name="title" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Expect Time:</label></td>
					<td><input id="EXPECT_TIME_ADD" name="EXPECT_TIME" class="easyui-datebox" style="width:207px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Requester:</label></td>
					<td><input class="easyui-validatebox" type="text" name="requester" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="4" cols="55" id="description" name="description"></textarea> </td>
				</tr>
				<tr>
					<td><label style="color:red">Note:</label></label></td>
					<td><label style="color:red">To(s) splits by comma.[User1,User2,User3...]</label></label></td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
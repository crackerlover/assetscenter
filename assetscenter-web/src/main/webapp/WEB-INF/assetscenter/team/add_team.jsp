<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#teamAddForm').form('submit',{
		url:'teamAdd.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#teamAdd').window('close');
		}
	});
}
function closeAddW() {
	$('#teamAdd').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="teamAddForm" method="post">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td>
						<input id="name" name="name" required="true" style="width:200px;">
					</td>
				</tr>
				<tr>
					<td><label for="name">Manager(s):</label></td>
					<td>
						<input id="manager" name="manager" required="true" style="width:200px;">
					</td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="4" cols="55" id="description" name="description"></textarea> </td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
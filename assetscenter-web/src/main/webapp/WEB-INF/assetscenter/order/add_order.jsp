<script type="text/javascript">
$(function(){
	$('#type').combobox({
		url:'assetTypeView.do',
		valueField:'text',
		textField:'text'
	});
});
function dynamicAdd() {
	var myTable = document.getElementById('dynamicTable').insertRow(0);
	var col0 = myTable.insertCell(0);
	var col1 = myTable.insertCell(1);
	var col2 = myTable.insertCell(2);
	var col3 = myTable.insertCell(3);
	var col4 = myTable.insertCell(4);
	var col5 = myTable.insertCell(5);
	var col6 = myTable.insertCell(6);
	col0.innerHTML = '<label for="name">Asset Type:</label>';
	col1.innerHTML = '<input id="type" name="type" style="width:207px;">';
	col2.innerHTML = '<label for="name">Expect Time:</label>';
	col3.innerHTML = '<input id="expectTime" name="expectTime" class="easyui-datebox"></input></label>';
	col4.innerHTML = '<label for="name">Quantity:</label>';
	col5.innerHTML = '<input class="easyui-validatebox" type="text" id="quantity" name="quantity" required="true" style="width:100px;">';
	col6.innerHTML = '<a href="#" id="remove" onclick="javascript:dynamicRemove(this);">Remove</a>';
	$('#type').combobox({
		url:'assetTypeView.do',
		valueField:'text',
		textField:'text'
	});
	$('#expectTime').datebox({  
	     required:true
	});
	$('#remove').linkbutton({  
	     plain:true, 
	     text:'Remove',
	     iconCls:'icon-remove'
	});
}
function dynamicRemove(row){
	var i=row.parentNode.parentNode.rowIndex;
	document.getElementById('dynamicTable').deleteRow(i);
}
</script>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#orderDetailAddForm').form('submit',{
		url:'orderAdd.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#orderAdd').window('close');
		}
	});
}
function closeAddW() {
	$('#orderAdd').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="orderDetailAddForm" method="post">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td><input class="easyui-validatebox" type="text" name="name" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="status">Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="1">Arrived</option>
							<option value="2">Part Arrived</option>
							<option value="0" selected="selected">Not Arrived</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="Requester">Requester:</label></td>
					<td><input class="easyui-validatebox" type="text" name="requester" required="true" style="width:200px;"></input></td>
				</tr>
				<tr>
					<td><label for="description">Description:</label></td>
					<td> <textarea rows="2" cols="60" id="description" name="description"></textarea> </td>
				</tr>
			</table>
			<table id="dynamicTable">
				<tr>
					<td><label for="assettype">Asset Type:&nbsp;</label></td>
					<td><!--select id="type" class="easyui-combobox" name="type" style="width:150px;" required="true"-->
						<input id="type" name="type" style="width:207px;">
					</td>
					<td><label for="name">Expect Time:</label></td>
					<td><input id="expectTime" name="expectTime" class="easyui-datebox"></input></td>
					<td><label for="name">Quantity:</label></td>
					<td><input class="easyui-validatebox" type="text" id="quantity" name="quantity" required="true" style="width:100px;"></input></td>
					<td><a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:dynamicAdd();">Add</a></td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
<%@page import="java.util.*,com.cisco.assetscenter.dao.dataobject.asset.*,com.cisco.assetscenter.web.util.*" %>
<%@ include file="/WEB-INF/assetscenter/include.jsp" %>
<%
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("map");
	OrderDO order = (OrderDO)map.get("order");
	List<AssetTypeDO> assetTypeList = (List<AssetTypeDO>)map.get("assetTypeList");
%>
<script type="text/javascript">
//$(function(){
//	$('#type').combobox({
//		url:'',
//		valueField:'id',
//		textField:'text'
//	});
//});
function dynamicAdd() {
	var myTable = document.getElementById('dynamicEditTable').insertRow(0);
	//alert(myTable);
	var col0 = myTable.insertCell(0);
	var col1 = myTable.insertCell(1);
	var col2 = myTable.insertCell(2);
	var col3 = myTable.insertCell(3);
	var col4 = myTable.insertCell(4);
	var col5 = myTable.insertCell(5);
	var col6 = myTable.insertCell(6);
	col0.innerHTML = '<label for="name">Asset Type:</label>';
	col1.innerHTML = '<input id="typeNew" name="typeNew" style="width:207px;">';
	col2.innerHTML = '<label for="name">Expect Time:</label>';
	col3.innerHTML = '<input id="expectTimeNew" name="expectTimeNew" class="easyui-datebox" ></input></label>';
	col4.innerHTML = '<label for="name">Quantity:</label>';
	col5.innerHTML = '<input class="easyui-validatebox" type="text" id="quantityNew" name="quantityNew" required="true" style="width:100px;">';
	col6.innerHTML = '<a href="#" id="remove" onclick="javascript:dynamicRemove(this);">Remove</a>';
	$('#expectTimeNew').datebox({  
		 required:true
	});
	$('#typeNew').combobox({
		url:'assetTypeView.do',
		valueField:'text',
		textField:'text'
	});
	$('#remove').linkbutton({  
	     plain:true, 
	     text:'Remove',
	     iconCls:'icon-remove'
	});
}
function dynamicRemove(row){
	var i=row.parentNode.parentNode.rowIndex;
	document.getElementById('dynamicEditTable').deleteRow(i);
}
</script>
<script type="text/javascript">
function submitDetailQueryEdit(){
	$('#orderDetailEditForm').form('submit',{
		url:'orderEdit.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#orderEdit').window('close');
		}
	});
}
function closeEditW() {
	$('#orderEdit').window('close');
}
</script>
<%if(null != order && null != assetTypeList) {%>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="orderDetailEditForm" method="post">
			<input type="hidden" id="orderId" name="orderId" value="<%=order.getId()%>">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td><input class="easyui-validatebox" type="text" name="name" required="true" style="width:200px;" value='<%=order.getName() %>'/></td>
				</tr>
				<tr>
					<td><label for="name">Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="1" <%if(order.getStatus() == 1) {%>selected="selected"<%} %>>Arrived</option>
							<option value="2" <%if(order.getStatus() == 2) {%>selected="selected"<%} %>>Part Arrived</option>
							<option value="0" <%if(order.getStatus() == 0) {%>selected="selected"<%} %>>Not Arrived</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">Requester:</label></td>
					<td><input class="easyui-validatebox" type="text" name="requester" required="true" style="width:200px;" value='<%=order.getRequestName() %>'></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="2" cols="60" id="description" name="description"><%=order.getDescription() %></textarea> </td>
				</tr>
			</table>
			<table id="dynamicEditTable">
				<% 
				List<OrderAssetDO> orderAssetList = order.getAssetList();
				for(int i =0; i < orderAssetList.size(); i ++) { 
					OrderAssetDO orderAsset = orderAssetList.get(i);
				%>
				<input type="hidden" id="oai" name="oai" value="<%=orderAsset.getId() %>"/>
				<tr>
					<td><label for="name">Asset Type:</label></td>
					<td>
					<select id="type" class="easyui-combobox" name="type" style="width:207px;" required="true">
						<%for(int j = 0; j < assetTypeList.size(); j ++) {
							AssetTypeDO assetType = assetTypeList.get(j);
						%>
							<option value="<%=assetType.getName() %>" <%if(assetType.getName().equalsIgnoreCase(orderAsset.getTypeName())){%>selected="selected"<%} %> ><%=assetType.getName() %></option>
						<%} %>
					</td>
					<td><label for="name">Expect Time:</label></td>
					<td><input id="expectTime" name="expectTime" class="easyui-datebox" required="true" value="<%=DateUtils.convertStr2Str(orderAsset.getExpectTime(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT) %>"></input></td>
					<td><label for="name">Quantity:</label></td>
					<td><input class="easyui-validatebox" type="text" id="quantity" name="quantity" required="true" style="width:100px;" value="<%=orderAsset.getQuantity() %>"></input></td>
					<td>
						<%if(i == orderAssetList.size() - 1) {%>
							<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:dynamicAdd();">Add</a>
						<%}
						else{%>
							<a href="#" id="remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:dynamicRemove(this);">Remove</a>
						<%} %>
					</td>
				</tr>
				<%} %>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryEdit();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeEditW();">Cancel</a>
		</div>
</div>
<%}%>
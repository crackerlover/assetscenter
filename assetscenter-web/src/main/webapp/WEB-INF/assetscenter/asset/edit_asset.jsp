<%@page import="com.cisco.assetscenter.dao.dataobject.asset.*, java.util.*,com.cisco.assetscenter.web.util.*" %>
<%
	Map<String, Object> map = (Map)request.getAttribute("map");
	AssetDO asset = (AssetDO)map.get("asset");
	List<AssetTypeDO> assetTypeList = (List<AssetTypeDO>)map.get("assetTypeList");
%>
<%if(null != asset)  {%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#asetEditForm').form('submit',{
		url:'assetEdit.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#assetEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#assetEdit').window('close');
}

</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="asetEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=asset.getId()%>">
			<table>
				<tr>
					<td><label for="name">SN:</label></td>
					<td><input class="easyui-validatebox" type="text" style="width:200px;" name="sn" required="true" value="<%=asset.getSn()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">ELTMS:</label></td>
					<td><input class="easyui-validatebox" type="text" style="width:200px;" name="eltms" required="true" value="<%=asset.getEltms()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="1" <%if(asset.getStatus()==1) {%>selected<%} %>>Available</option>
							<option value="0" <%if(asset.getStatus()==0) {%>selected<%} %>>Not Available</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">Type:</label></td>
					<td>
						<select id="typeEdit" class="easyui-combobox" name="type" style="width:207px;" required="true">
							<%for(int j = 0; j < assetTypeList.size(); j ++) {
							AssetTypeDO assetType = assetTypeList.get(j);
						%>
							<option value="<%=assetType.getName() %>" <%if(assetType.getId() == asset.getTypeId()){%>selected="selected"<%} %> ><%=assetType.getName() %></option>
						<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">Warehouse Time:</label></td>
					<td><input id="WAREHOUSE_TIME_EDIT" name="WAREHOUSE_TIME" class="easyui-datebox" style="width:207px;" value="<%=DateUtils.convertStr2Str(asset.getWarehouseTime(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT)%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Owner:</label></td>
					<td><input class="easyui-validatebox" type="text" name="owner" required="true" style="width:200px;" value="<%=asset.getOwnerName()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">User:</label></td>
					<td><input class="easyui-validatebox" type="text" name="user" required="true" style="width:200px;" value="<%=asset.getUserName()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Order:</label></td>
					<td><input class="easyui-validatebox" type="text" name="order" style="width:200px;" required="true" value="<%=asset.getOrderName()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Price(RMB):</label></td>
					<td><input class="easyui-validatebox" type="text" name="price" style="width:200px;" value="<%=asset.getPrice()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Location:</label></td>
					<td><input class="easyui-validatebox" type="text" name="location" style="width:200px;" required="true" value="<%=asset.getLocation()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="2" cols="40" id="description" name="description"><%=asset.getDescription()%></textarea> </td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Ok</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
<%}%>
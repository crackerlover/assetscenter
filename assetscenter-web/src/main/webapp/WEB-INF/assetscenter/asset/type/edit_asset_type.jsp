<%@page import="com.cisco.assetscenter.dao.dataobject.asset.*, java.util.*,com.cisco.assetscenter.web.util.*" %>
<%
	Map<String, Object> map = (Map)request.getAttribute("map");
	AssetTypeDO assetTypeDO = (AssetTypeDO)map.get("assetTypeDO");
%>
<%if(null != assetTypeDO)  {%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#assetTypeEditForm').form('submit',{
		url:'assetTypeEdit.do',//
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#assetTypeEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#assetTypeEdit').window('close');
}

</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="assetTypeEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=assetTypeDO.getId()%>">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td>
						<input id="name" name="name" required="true" style="width:200px" value="<%=assetTypeDO.getName()%>">
					</td>
				</tr>
				<tr>
					<td><label for="description">Description:</label></td>
					<td> <textarea rows="2" cols="60" id="description" name="description"><%=assetTypeDO.getDescription()%></textarea> </td>
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
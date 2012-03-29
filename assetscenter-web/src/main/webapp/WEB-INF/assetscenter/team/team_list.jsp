<%@page import="com.cisco.assetscenter.dao.dataobject.team.*,com.cisco.assetscenter.dao.dataobject.*, java.util.*" %>
<%
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("map");
	List<TeamDO> teamList = (List<TeamDO>)map.get("teamList");
%>
<script type="text/javascript">
function submitTransfer(){
	$('#confirmForm').form('submit',{
		url:'setTeam.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','The set team operation is success!'); 
			initDataGrid(queryString);
			$('#setTeam').window('close');
			//parent.location.href='requestDispatcher.do?url=main';
		}
	});
}
function closeTransferW() {
	$('#setTeam').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="confirmForm" method="post">
			<input type="hidden" idd="assetId" name="assetId" value="<%=map.get("id")%>">
			<table>
				<tr>
					<td><label>Team:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="team" style="width:140px;" required="true">
							<%
								for(TeamDO team : teamList) {
							%>
							<option value="<%=team.getId()%>"><%=team.getName() %></option>
							<%} %>
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
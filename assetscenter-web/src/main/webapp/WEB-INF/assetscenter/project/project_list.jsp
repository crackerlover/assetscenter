<%@page import="com.cisco.assetscenter.dao.dataobject.project.*,com.cisco.assetscenter.dao.dataobject.*, java.util.*" %>
<%
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("map");
	List<ProjectDO> projectList = (List<ProjectDO>)map.get("projectList");
%>
<script type="text/javascript">
function submitTransfer(){
	$('#confirmForm').form('submit',{
		url:'setProject.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','The set project operation is success!'); 
			initDataGrid(queryString);
			$('#setProject').window('close');
			//parent.location.href='requestDispatcher.do?url=main';
		}
	});
}
function closeTransferW() {
	$('#setProject').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="confirmForm" method="post">
			<input type="hidden" idd="assetId" name="assetId" value="<%=map.get("id")%>">
			<table>
				<tr>
					<td><label>Project:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="project" style="width:140px;" required="true">
							<%
								for(ProjectDO project : projectList) {
							%>
							<option value="<%=project.getId()%>"><%=project.getName() %></option>
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
<%@page import="com.cisco.assetscenter.dao.dataobject.project.*,com.cisco.assetscenter.web.util.*" %>
<%
	ProjectDO project = (ProjectDO)request.getAttribute("project");
%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#projectEditForm').form('submit',{
		url:'projectEdit.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#projectEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#projectEdit').window('close');
}
<%if(null != project){%>
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="projectEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=project.getId()%>">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td>
						<input id="name" name="name" required="true" style="width:200px;" value="<%=project.getName()%>">
					</td>
				</tr>
				<tr>
					<td><label for="name">Manager(s):</label></td>
					<td>
						<%
							String[] managers = project.getManagers();
							String manager = "";
							if(null != managers && managers.length > 0) {
								for(int i = 0; i < managers.length; i ++) {
									if(i != managers.length - 1) {
										manager = manager + managers[i] + ",";
									}
									else {
										manager = manager + managers[i];
									}
								}
							}
						%>
						<input id="manager" name="manager" required="true" style="width:200px;" value="<%=manager%>">
					</td>
				</tr>
				<tr>
					<td><label for="name">Start Time:</label></td>
					<td><input id="START_TIME" name="START_TIME" class="easyui-datebox" required="true" style="width:207px;" value="<%=DateUtils.convertStr2Str(project.getStartTime(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT)%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">End Time:</label></td>
					<td><input id="END_TIME" name="END_TIME" class="easyui-datebox" required="true" style="width:207px;" value="<%=DateUtils.convertStr2Str(project.getEndTime(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT)%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="4" cols="55" id="description" name="description"><%=project.getDescription()%></textarea> </td>
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
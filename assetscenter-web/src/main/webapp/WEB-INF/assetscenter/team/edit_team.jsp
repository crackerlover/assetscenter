<%@page import="com.cisco.assetscenter.dao.dataobject.team.*" %>
<%
	TeamDO team = (TeamDO)request.getAttribute("team");
%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#teamEditForm').form('submit',{
		url:'teamEdit.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#teamEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#teamEdit').window('close');
}
<%if(null != team){%>
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="teamEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=team.getId()%>">
			<table>
				<tr>
					<td><label for="name">Name:</label></td>
					<td>
						<input id="name" name="name" required="true" style="width:200px;" value="<%=team.getName()%>">
					</td>
				</tr>
				<tr>
					<td><label for="name">Manager(s):</label></td>
					<td>
						<%
							String[] managers = team.getManagers();
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
					<td><label for="name">Description:</label></td>
					<td> <textarea rows="4" cols="55" id="description" name="description"><%=team.getDescription()%></textarea> </td>
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
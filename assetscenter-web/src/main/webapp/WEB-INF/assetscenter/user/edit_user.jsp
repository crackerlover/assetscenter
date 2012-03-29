<%@page import="com.cisco.assetscenter.dao.dataobject.user.*, java.util.*,com.cisco.assetscenter.web.util.*" %>
<%
	UserDO user = (UserDO)request.getAttribute("user");
%>
<%if(null != user)  {%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#userEditForm').form('submit',{
		url:'userEdit.do',//edit case means new a case.
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$('#userEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#userEdit').window('close');
}

</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="userEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=user.getId()%>">
			<table>
			<tr>
					<td><label for="name">User ID:</label></td>
					<td>
						<input id="usernameEdit" name="username" required="true" style="width:200px;" value="<%=user.getUsername()%>">
					</td>
				</tr>
				<tr>
					<td><label for="name">Full Name:</label></td>
					<td>
						<input id="fullnameEdit" name="fullname" required="true" style="width:200px;" value="<%=user.getFullName()%>">
					</td>
				</tr>
				<tr>
					<td><label>Role Type:</label></td>
					<td>
						<select id="role" class="easyui-combobox" name="role" style="width:207px;" required="true">
							<option value="2" <%if(user.getRole() == 2) {%>selected="selected"<%} %>>User</option>
							<option value="1" <%if(user.getRole() == 1) {%>selected="selected"<%} %>>Viewer</option>
							<option value="3" <%if(user.getRole() == 3) {%>selected="selected"<%} %>>Manager</option>
							<option value="4" <%if(user.getRole() == 4) {%>selected="selected"<%} %>>Admin</option>
						</select>
					</td>
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
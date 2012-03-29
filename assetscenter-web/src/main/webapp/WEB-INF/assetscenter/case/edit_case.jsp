<%@page import="com.cisco.assetscenter.dao.dataobject.cases.*, java.util.*,com.cisco.assetscenter.web.util.*" %>
<%
	Map<String, Object> map = (Map)request.getAttribute("map");
	CaseDO caseDO = (CaseDO)map.get("caseDO");
	List<CaseTypeDO> assetTypeList = (List<CaseTypeDO>)map.get("caseTypeList");
%>
<%if(null != caseDO)  {%>
<script type="text/javascript">
function submitDetailQueryAdd(){
	$('#caseEditForm').form('submit',{
		url:'caseEdit.do',//edit case means new a case.
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			initDataGrid(queryString);
			$.messager.alert('Info','Update case operation is success!');
			$('#caseEdit').window('close');
		}
	});
}
function closeAddW() {
	$('#caseEdit').window('close');
}

</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="caseEditForm" method="post">
			<input type="hidden" name="id" id="id" value="<%=caseDO.getId()%>">
			<table>
				<tr>
					<td><label for="name">Type:</label></td>
					<td>
						<select id="typeEdit" class="easyui-combobox" name="type" disabled="true" style="width:207px;" required="true">
							<%for(int j = 0; j < assetTypeList.size(); j ++) {
							CaseTypeDO caseType = assetTypeList.get(j);
						%>
							<option value="<%=caseType.getName() %>" <%if(caseType.getId() == caseDO.getTypeId()){%>selected="selected"<%} %> ><%=caseType.getName() %></option>
						<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">To(s):</label></td>
					<td><input class="easyui-validatebox" type="to" name="to" style="width:200px;" value="<%=caseDO.getTos()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Status:</label></td>
					<td>
						<select id="typeEdit" class="easyui-combobox" name="status" style="width:207px;" required="true">
							<option value="0" <%if(caseDO.getStatus() == 0){%>selected="selected"<%} %> >Pending</option>
							<option value="1" <%if(caseDO.getStatus() == 1){%>selected="selected"<%} %> >Closed</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="name">Title:</label></td>
					<td><input class="easyui-validatebox" type="text" name="title" disabled="true" style="width:200px;" value="<%=caseDO.getName()%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Create Time:</label></td>
					<td><input id="CREATE_TIME" name="CREATE_TIME" class="easyui-datebox" disabled="true" style="width:207px;" value="<%=DateUtils.convertStr2Str(caseDO.getGmtCreate(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT)%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Expect Time:</label></td>
					<td><input id="EXPECT_TIME_EDIT" name="EXPECT_TIME" class="easyui-datebox" disabled="true" style="width:207px;" value="<%=DateUtils.convertStr2Str(caseDO.getExpectTime(), DateUtils.DATABASE_ASSET_FORMAT, DateUtils.EASYUI_FORMAT)%>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Requester:</label></td>
					<td><input class="easyui-validatebox" type="text" name="requester" disabled="true" style="width:200px;" value="<%=caseDO.getSubmiter() %>"></input></td>
				</tr>
				<tr>
					<td><label for="name">Description:</label></td>
					<td><label><%=caseDO.getDescription()%></label></td>
				</tr>
				<tr>
					<td><label for="name">Work History:</label></td>
					<td>
						<label><%=caseDO.getUpdateInfo()%></label>
					</td>
				</tr>
				<tr>
					<td><label for="name">Update Info:</label></td>
					<td> <textarea rows="4" cols="55" id="info" name="info"></textarea> </td>
				</tr>
				<tr>
					<td><label style="color:red">Note:</label></label></td>
					<td><label style="color:red">To(s) splits by comma.[User1,User2,User3...]</label></label></td>
				</tr>
			</table>
			</form>
		</div>
		<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:submitDetailQueryAdd();">Update</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javacript:closeAddW();">Cancel</a>
		</div>
</div>
<%}%>
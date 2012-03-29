<%@page import="com.cisco.assetscenter.dao.dataobject.cases.*,com.cisco.assetscenter.dao.dataobject.*" %>
<%
CaseDO caseDO = (CaseDO)request.getAttribute("case");
%>
<script type="text/javascript">
function submitTransfer(){
	$('#confirmForm').form('submit',{
		url:'caseConfirm.do',
		onSubmit: function(){ 
			//alert('Do some checking...');
		},
		success:function(queryString){
			$.messager.alert('Info','The confirm operation is success!'); 
			initDataGrid(queryString);
			$('#confirmCase').window('close');
			//parent.location.href='requestDispatcher.do?url=main';
		}
	});
}
function closeTransferW() {
	$('#confirmCase').window('close');
}
</script>
	<div class="easyui-layout" fit="true">
		<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
			<form id="confirmForm" method="post">
			<input type="hidden" id="id" name="id" value="<%=caseDO.getId()%>">
			<table>
				<tr>
					<td><label>Status:</label></td>
					<td>
						<select id="status" class="easyui-combobox" name="status" style="width:140px;" required="true">
							<option value="0" <%if(caseDO.getStatus() == Constants.PENDING_CASE_STATUS){ %>selected="selected"<%} %>>Pending</option>
							<option value="1" <%if(caseDO.getStatus() == Constants.APPROVED_CASE_STATUS){ %>selected="selected"<%} %>>Approved</option>
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
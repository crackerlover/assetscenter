<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/assetscenter/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Order Detail</title>
	<style type="text/css">
	.dv-table td{
		border:0;
	}
	.dv-label{
		font-weight:bold;
		color:#15428B;
		width:100px;
	}
</style>
</head>
<body>
	<table class="dv-table" border="0" style="width:100%;">
	<c:forEach var="orderAsset" items="${list}">
	<tr>
		<td class="dv-label">Id: <c:out value="${orderAsset.id}"/></td>
		<td class="dv-label">Asset Type: <c:out value="${orderAsset.typeName}"/></td>
		<td class="dv-label">Quantity: <c:out value="${orderAsset.quantity}"/></td>
		<td class="dv-label">Expect Time: <c:out value="${orderAsset.expectTime}"/></td>
	</tr>
	</c:forEach>
</table>
</body>
</html>
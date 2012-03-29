<%@page import="java.util.*" %>
<%
	Map map = (Map)request.getAttribute("map");
	out.println(map.get("data"));
%>
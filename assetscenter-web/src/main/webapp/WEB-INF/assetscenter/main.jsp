<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cisco.assetscenter.dao.dataobject.user.*,com.cisco.assetscenter.dao.dataobject.*" %>
<%
	UserDO user = (UserDO)session.getAttribute("user");	
	if(null == user) {
		response.sendRedirect("logout.do?url=login/login");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AssetsCenter</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#m-tree').tree({
				onSelect: function(node){
					var url = node.attributes.url;
					var pp = $('#tt').tabs('getSelected'); 
					$('#tt').tabs('update', {
						tab:pp,
						options:{
							title:node.text,
							content:'<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>',
							selected:true
						}
					});
				},
				onLoadSuccess:function(node,data){
					if (data.length){
						var id = data[0].children[0].children[0].id;
						var n = $(this).tree('find', id);
						$(this).tree('select', n.target);
					}
				}
			});
		});
	</script>
	<style type="text/css">
		.rtitle{
			font-size:18px;
			font-weight:bold;
			padding:5px 10px;
			background:#336699;
			color:#fff;
		}
		.icon-channels{
			background:url('images/tree_channels.gif') no-repeat;
		}
		.icon-feed{
			background:url('images/rss.png') no-repeat;
		}
		.icon-rss{
			background:url('images/rss.gif') no-repeat;
		}
	</style>
</head>
<body class="easyui-layout">
		<div region="north" border="false" class="rtitle">
			Cisco Assets Management System
		</div>
		<div region="west" split="true" title="Menu(Welcome, <%= user.getUsername() %>)" style="width:250px;background:#EAFDFF;">
			<ul id="m-tree" class="easyui-tree" url="treeInitial.do?url=menu/meuns_json"></ul>
		</div>
		<div region="center" title="" style="overflow:hidden;">
			<div id="tt" class="easyui-tabs" fit="true" border="false">
					<div title="Home Page" style="overflow:hidden;"> 
						<div style="margin-top:20px;">
							<h3>&nbsp;This application is used as:</h3>
							<li>&nbsp;&nbsp;1)	Managing the assets information in lab, recording the status of assets in lab.</li> 
							<li>&nbsp;&nbsp;2)	Query the assets information filter by the special condition, recording the  lend or borrow history information.</li> 
							<li>&nbsp;&nbsp;3)	Making an order, recoding the status of order.</li> 
							<li>&nbsp;&nbsp;4)	Opening the case for the special requirement.</li> 
							<li>&nbsp;&nbsp;5)	Managing the project information, managing your project's assets information, querying the assets information in the project.</li> 
							<li>&nbsp;&nbsp;6)	Managing the team information, managing your team's assets information, querying the assets information in the team.</li> 
						</div>
					</div>
			</div>
		</div>
</body>
</html>

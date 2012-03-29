<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cisco.assetscenter.dao.dataobject.user.*"%>
<%
	UserDO user = (UserDO)session.getAttribute("user");	
	if(null != user) {
		response.sendRedirect("requestDispatcher.do?url=main");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Please login the eAssets system with your CEC</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		if(top != self) {
			if(top.location != self.location) {
				top.location = self.location;
			}
		}
	</script>
	<script type="text/javascript">
	function submit(){
		var username = document.getElementById('username').value;
		var password = document.getElementById('password').value;
		if(null == username || username == ''){
			$.messager.alert('Warning','Please input your username!');
			return;
		}
		if(null == password || password == ''){
			$.messager.alert('Warning','Please input your password!');
			return;
		}
		document.getElementById('loginForm').submit();
	}
	function reset() {
		document.getElementById('loginForm').reset();
	}
	function register(){
		var $win;
	    $win = $('#registerwin').window({
	            title:'Register with your CEC',
	            width: 400,
	            height: 225,
	            shadow: true,
	            modal:true,
	            iconCls:'icon-add',
			    closed:true,
			    cache:false,
			    minimizable:false,
			    maximizable:false,
			    collapsible:false,
			    href:'registerwin.do'
	         });
	   
	    $win.window('open');
	}
</script>
</head>
<body>
    <div id="win" class="easyui-window" title="Login eAsset System" minimizable="false" maximizable="false" closable="false" style="width:370px;height:250px;">  
       <form id="loginForm" method="post" action="login.do" style="padding:10px 30px 10px 50px;">
       		<% 
       			Object msg = request.getAttribute("msg");
       			if(null != msg) {
       		%> 
       	   <p><label style="color:red">Account information isn't correct!</label></p> 
       	   <%} %>  
           <p>Username: <input type="text" id="username" name="username" style="width:220px;"></p>  
           <p>Password: <input type="password" id="password" name="password" style="width:220px;" onkeypress="if(event.keyCode==13){submit();return false;}"></p>  
           <div style="padding:5px;text-align:left;">  
               <a href="#" class="easyui-linkbutton" icon="icon-ok" onclick="javascript:submit();">Login</a>  
               <a href="#" class="easyui-linkbutton" icon="icon-reload" onclick="javascript:reset();">Reset</a>
               <a href="#" class="easyui-linkbutton" iconCls="icon-tip" plain="true" onclick="javascript:register();">Register</a>              
           </div>  
       </form>  
    </div> 
<div id="registerwin" class="easyui-window" style="width:350px;height:225px;padding:5px;" closed="true"></div>
</body>
</html>
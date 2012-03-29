<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Approve Message</title>
<SCRIPT LANGUAGE="JavaScript"> 
<!-- 
var time = 8; //时间,秒 

function Redirect(){ 
window.location = "http://10.74.59.175:8080"; 
//window.location = "http://localhost:8080/assetscenter"; 
} 
var i = 0; 
function dis(){ 
document.all.s.innerHTML = "Remaining " + (time - i) + " Seconds"; 
i++; 
} 
timer=setInterval('dis()', 1000);//显示时间 
timer=setTimeout('Redirect()',time * 1000); //跳转 

//--> 
</SCRIPT> 
</head>
<body>
	<h1>Congratulations! Your approved operation is success.</h1>
	<span id="s"></span> 
</body>
</html>
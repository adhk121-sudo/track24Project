<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String)request.getAttribute("msg");
	String url = (String)request.getAttribute("url");
	
	if(msg == null) msg = "";
	if(url == null) url = "Power?t_gubun=main";
	
	// JavaScript에서 사용할 수 있도록 특수문자 이스케이프
	msg = msg.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
</head>
<body>
</body>
</html>


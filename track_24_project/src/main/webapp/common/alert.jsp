<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String)request.getAttribute("msg");
	String url = (String)request.getAttribute("url");
	
	if(msg == null) msg = "";
	if(url == null) url = "Power?t_gubun=main";
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


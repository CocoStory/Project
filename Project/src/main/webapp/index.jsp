<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.vo.*" %>
<%
	LoginUser login = (LoginUser)session.getAttribute("loginUser");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CodingStory</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>
	<section>
	
	
	</section>	
	<%@ include file="footer.jsp" %>
</body>
</html>
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
	<div class="index_wrap">
		<%
			if(login != null){ //null check 
		%>
		<div class="index_login">
			<br>
			<strong><%=login.getUname() %>님 로그인을 환영합니다.</strong>
		</div>
		<% 	
			}	
		%>
		<div class="img">
			<img src="image/coding.jpg" width="100%" alt="코딩이미지">
		</div>
		
	</div>
	</section>	
	<%@ include file="footer.jsp" %>
</body>
</html>
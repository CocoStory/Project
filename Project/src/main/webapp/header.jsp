<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.vo.*" %>
<%
	LoginUser m = (LoginUser)session.getAttribute("loginUser");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
	<nav>
		<div class="menu">
			<div class="logo">
				<a href="<%=request.getContextPath() %>/index.jsp">CodingStory;</a>
			</div>
			<ul>
				<li><a href="#">Introduction</a></li>
				<li><a href="<%=request.getContextPath() %>/question/list.jsp">Q&A</a></li>
				<%
			if(m == null){ //null 상태는 로그인 하지 않은 상태 
				%>
				<li><a href="<%=request.getContextPath() %>/login/login.jsp">Login</a></li>
				<li><a href="<%=request.getContextPath() %>/login/join.jsp">Sign up</a></li>
				<% 	
				}else{
				%>
				<li><a href="<%=request.getContextPath() %>/mypage/mypage.jsp">Mypage</a></li>
				<li><a href="<%=request.getContextPath() %>/login/logout.jsp">Logout</a></li>
				<%} %>
			</ul>
		</div>
	</nav>
</body>
</html>
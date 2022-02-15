<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.vo.*" %>

<%
	LoginUser m = (LoginUser)session.getAttribute("loginUser");
	//session.setMaxInactiveInterval(1200);//세션유지시간 1200초
%>
<nav>
	<div class="menu">
		<div class="logo">
			<a href="<%=request.getContextPath() %>/index.jsp">CodingStory;</a>
		</div>
		<ul>
			<li><a href="<%=request.getContextPath() %>/recruit/list.jsp">Recruit</a></li>
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
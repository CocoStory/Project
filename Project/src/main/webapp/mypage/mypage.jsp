<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");

	int uidx_ = login.getUidx();
	//System.out.print(uidx);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
<div class="mypage_wrap">
		<%
			if(login != null){ //null check 
		%>
		<div class="index_login"><!-- index꺼 그대로 사용 -->
			<br>
			<strong><%=login.getUname() %>님 환영합니다.</strong>
			<br>
			<br>
			<br>
			<br>
		</div>
		<% 	
			}	
		%>
	
		<hr>
		<div class="mypage_inline">
			<div class="#">
			<input type="button" value="내 정보 수정" onclick="location.href='modifyUser.jsp?uidx=<%=uidx_%>'">
			</div>
			<div class="#">
			<p>5<br><span>게시글</span></p>
			<input type="button" value="내가 작성한 글">
			</div>
			<div class="#">
			<p>3<br><span>댓글</span></p>
			<input type="button" value="내가 단 댓글">
			</div>
		</div>
		<hr>
		<div class="mypage_btn">
		<input type="button" value="로그아웃" onclick="location.href='../login/logout.jsp'">
		<input type="button" value="회원탈퇴">
		</div>	
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
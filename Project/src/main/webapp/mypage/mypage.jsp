<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	//내가 쓴 글 갯수 세기&리스트 불러오기
	// 글 갯수 - 일단 db에 접속하여 데이터를 불러온 다음, sql문을 count로 작성하고, 세는 기준은 login한 uidx를 기준으로 한다. uidx는 getter로 불러온다.
	// 내가 쓴 글 리스트 - 새로운 jsp 페이지로 이동하고 거기서 또 새로운 jsp 작성.sql 조건을 where절로 한다. select * from table_nm where = '세션에서 받아온 아이디'


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
		<input type="button" value="회원탈퇴" onclick="location.href='withdrawUser.jsp'">
		</div>	
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
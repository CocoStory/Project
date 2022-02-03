<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%
	request.setCharacterEncoding("UTF-8");   

	LoginUser login = (LoginUser)session.getAttribute("loginUser");
	
	int uidx = login.getUidx();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 페이지</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
<div class="modifyUser_title">
		<strong>회원탈퇴 화면</strong><br><br>
		정말로 회원탈퇴 하시겠습니까?<br>
		탈퇴하시면 되돌릴 수 없습니다.
		</div>
		<div class="modifyUserBox">
			<form action="withdrawUserOk.jsp" method="post">
				<input type="hidden" name="uidx" value="<%=uidx %>">
				<button onclick="check()">회원탈퇴</button> 
			</form>
		</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
<script>
function check(){
	alert("회원탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
	return false;
}
</script>
</html>
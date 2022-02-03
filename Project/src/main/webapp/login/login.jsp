<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>    
<%
	request.setCharacterEncoding("UTF-8");//오류 메세지 한글 깨지지 않게 인코딩
	String errMsg = (String)request.getParameter("errMsg");
	if(errMsg == null) errMsg = "";
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
	<section>
	<div class="login_wrap">
		<div class="login_title">
			<strong>로그인 후에 이용하세요!</strong>
		</div>
		<div class="login_form">
			<form name="loginForm" action="loginOk.jsp" method="post">
				<p><input type="text" name="userid" placeholder="ID입력"></p>
				<p><input type="password" name="upwd" placeholder="PASSWORD입력"></p>
				<div id="errMsg" style="color:red"><%=errMsg %></div>
				<input type="submit" value="로그인" onclick="loginCheck()">
			</form>
		</div>
		<div class="notuser">
			<p>계정이 없으신가요?<a href="join.jsp"> 회원가입</a></p>
		</div>
	</div>
	</section>	
<%@ include file="/footer.jsp" %>
</body>

<script>
function loginCheck(){
	if(!document.loginForm.upwd.value && !document.loginForm.userid.value){
		alert("아이디와 비밀번호를 입력하세요");
		return false;
	}
	
	if(!document.loginForm.userid.value){
		alert("아이디를 입력하세요");
		return false;
	}
	
	if(!document.loginForm.upwd.value){
		alert("비밀번호를 입력하세요");
		return false;
	}
	
}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<form action="loginOk.jsp" method="post">
				<p><input type="text" name="userid" placeholder="ID입력"></p>
				<p><input type="password" name="upwd" placeholder="PASSWORD입력"></p>
				<input type="submit" value="로그인">
			</form>
		</div>
		<div class="notuser">
			<p>계정이 없으신가요?<a href="join.jsp"> 회원가입</a></p>
		</div>
	</div>
	</section>	
<%@ include file="/footer.jsp" %>
</body>
</html>
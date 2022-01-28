<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
	<div class="join_wrap">
		<div class="join_title">
		<strong>회원가입</strong>
		</div>
		<hr><!-- 아이디(중복체크),패스워드,패스워드확인,이름,폰 입력 -->
		<div class="joinbox">
			<form name="joinform" action="joinOk.jsp" method="post">
				<div class="inputname">
					<br>
					<label>아이디<span class="red"></span></label>
				</div>
				<div class="jointable id">
					<input type="text" name="userid" placeholder="ID 입력"> 
					<input type="button" value="중복확인">
				</div>
				<div class="inputname">
					<label>비밀번호<span class="red"></span></label>
				</div>
				<div class="jointable password">
					<input type="password" name="upwd" placeholder="비밀번호 입력">
				</div>
				<div class="inputname">
					<label>비밀번호 확인<span class="red"></span></label>
				</div>
				<div class="jointable passwordre">
						<input type="password" class="#" placeholder="비밀번호 확인">
				</div>
				<div class="inputname">
					<label>이름<span class="red"></span></label>
				</div>
				<div class="jointable name">
					<input type="text" name="uname" placeholder="이름입력">
				</div>
				<div class="inputname">
					<label>연락처<span class="red"></span></label>
				</div>
				<div class="jointable phone">
					<select name="uphone1" id="phone1">
						<option value="010">010</option>
						<option value="010">011</option>
						<option value="010">016</option>
					</select>&nbsp;
					<input type="text" class="impor" name="uphone2" id="phone2" placeholder="연락처2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="checkFn('phone2')">&nbsp;
					<input type="text" class="impor" name="uphone3" id="phone3" placeholder="연락처3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="checkFn('phone3')">
				</div>
				<div class="joinsubmit">
					<br>
					<br>
					<input type="submit" value="회원가입">
				</div>
				<div class="alreadyuser">
				<p>이미 계정이 있으신가요?<a href="login.jsp"> 로그인</a></p>
				</div>
			</form>	
		</div>
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
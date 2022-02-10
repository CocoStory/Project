<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>
	function IdCheck(){
		var joinid = $("#id").val();
		var sendData  = {"id":id}
		
		$.ajax({
			method:"POST",
			url:"idCheck.jps",
			data : sendData,
			success : function(resp){
				if(resp == 'fail'){
					$('idSpan').css('color','red')
					$('#idSpan').html("사용할 수 없는 이메일입니다")
					flag = false;
				
				}else{
					$('idSpan').css('color','blue')
					$('#idSpan').html("사용할 수 있는 이메일입니다")
					flag = true;
						
				}
			}
				
			
		});
	}
	
	
</script>
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
	<div class="join_wrap">
		<div class="join_title">
		<strong>회원가입</strong>
		</div>
		<hr><!-- 아이디(중복체크),패스워드,패스워드확인,이름,폰 입력 -->
		<!-- name은 back으로 넘길 때의 명칭과 일치해야 하므로 건드리면 안됨.id는 모두 다르게 지정해 주어야함. -->
		<div class="joinbox">
			<form name="joinform" action="joinOk.jsp" method="post" onsubmit="return nullcheck();">
				<div class="inputname">
					<br>
					<label>아이디<span class="idSpan"></span></label>
				</div>
				<div class="jointable id">
					<input type="text" name="userid" id="id" placeholder="ID 입력"> 
					<input type="button" value="중복확인" onclick="IdCheck()"> 
					<div id="check_id"></div>
				</div>
				<div class="inputname">
					<label>비밀번호<span class="red"></span></label>
				</div>
				<div class="jointable password">
					<input type="password" name="upwd" id ="pwd" placeholder="비밀번호 입력">
				</div>
				<div class="inputname">
					<label>비밀번호 확인<span class="red"></span></label>
				</div>
				<div class="jointable passwordre">
						<input type="password" id ="pwd_check"  placeholder="비밀번호 확인">
				</div>
				<div class="inputname">
					<label>이름<span class="red"></span></label>
				</div>
				<div class="jointable name">
					<input type="text" name="uname" id="name_insert" placeholder="이름입력">
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
					<input type="text" class="impor" name="uphone2" id="phone2" placeholder="연락처2" maxlength="4">&nbsp;
					<input type="text" class="impor" name="uphone3" id="phone3" placeholder="연락처3" maxlength="4" >
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
<script src = "js/jquery-3.6.0.min.js"></script>
<script>
	// 유효성검사
	// input type text의 value를 찾아서 null check (이름, id, phone2,phone3)
	// pwd pwdcheck (일치여부 및 null 체크하기) 
	
	function nullcheck(){
		var id = document.getElementById('id').value;
		var pwd = document.getElementById('pwd').value;
		var phone2 = document.getElementById('phone2').value;
		var phone3 = document.getElementById('phone3').value;
		var pwd_check = document.getElementById('pwd_check').value;
		
		if((pwd == "")||(id == "")||(phone2 == "")||(phone3 == "")){
			alert("값을 모두 입력해주세요");
			return false;
		}else if(pwd != pwd_check){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		alert("회원가입이 완료되었습니다");
		return true;	
	}
</script>
</html>
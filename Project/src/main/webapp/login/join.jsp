<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">
<title>회원가입</title>
<script src = "<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
	//정규식
	function checkFn(type){
		if(type == 'id'){
			var regular = /^[A-Za-z0-9_-]{4,20}$/;
			var value = document.joinform.id.value;
			var span =  document.getElementsByClassName("idcheck")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "필수";		
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
			}
		
		}else if(type == 'pass'){
			var regular =/^[a-z0-9_-]{4,18}$/;
			var value = document.joinform.pwd.value;
			var span = document.getElementsByClassName("pwdcheck")[0].getElementsByTagName("span")[0];				
			if(value == ""){
					span.textContent = "필수";		
			}else if(!regular.test(value)){
					span.textContent = "형식오류";
			}else{
					span.textContent = "";
			}
			
		}else if(type == 'passre'){
			var value = document.joinform.pwd.value;
			var value2 = document.joinform.pwd_check.value;
			var span = document.getElementsByClassName("pwdcheckre")[0].getElementsByTagName("span")[0];
			if(value2 == ""){
				span.textContent = "필수";
			}else if(value != value2){
				span.textContent = "비밀번호 불일치";
			}else{
				span.textContent = "";
			}
			
		}else if(type == 'name'){
			var regular = /^[가-힣]/g;
			var value = document.joinform.name_insert.value;
			var span = document.getElementsByClassName("namecheck")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "필수";
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
				
			}

		}else if(type == 'phone2'){
			var regular = /^[0-9]{3,4}/g;
			var value = document.joinform.uphone2.value;
			var span = document.getElementsByClassName("phone")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "필수";				
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
				
			}
			
		}else if(type == 'phone3'){
			var regular = /^[0-9]{4}/g;
			var value = document.joinform.uphone3.value;
			var span = document.getElementsByClassName("phone")[0].getElementsByTagName("span")[0];
			if(value == ""){
				span.textContent = "필수";
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
				
			}
		}
	}	
	
	

	
	//중복체크
	function duplication(obj){
		//console.log($(obj).prev().val());
		//console.log(document.getElementById('id_span'));
		
		var id_value = $(obj).prev().val();
		var id_span = document.getElementById('id_span');
		var join_btn = document.getElementById('joinBtn');
		
		//ajax선언
		$.ajax({
			url:"idCheck.jsp",
			type:"post",
			data:"id_value="+id_value,
			success:function(data){
				var json = JSON.parse(data.trim());            
				if(json.length != 0){
					id_span.textContent = "사용불가";
					id_span.style.color = "red";
					join_btn.style.visibility = "hidden";
					idCheck = false;
					
				}else{
					id_span.textContent = "사용가능";
					id_span.style.color = "blue";
					join_btn.style.visibility = "visible";
					idCheck = false;
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
				<div class="inputname idcheck">
					<br>
					<label>아이디<span class="red" id="red1"></span></label>
				</div>
				<div class="jointable id">
					<input type="text" name="userid" id="id" placeholder="ID 입력" onblur="checkFn('id')" onchange="tryChange(this.value)"> 
					<input type="button" value="중복확인" onclick="duplication(this);"> 
					<span id="id_span"></span>
				</div>
				<div class="inputname pwdcheck">
					<label>비밀번호<span class="red" id="red2"></span></label>
				</div>
				<div class="jointable password">
					<input type="password" name="upwd" id ="pwd" placeholder="비밀번호 입력" onblur="checkFn('pass')">
				</div>
				<div class="inputname pwdcheckre">
					<label>비밀번호 확인<span class="red" id="red3"></span></label>
				</div>
				<div class="jointable passwordre">
						<input type="password" id ="pwd_check"  placeholder="비밀번호 확인" onblur="checkFn('passre')">
				</div>
				<div class="inputname namecheck">
					<label>이름<span class="red" id="red4"></span></label>
				</div>
				<div class="jointable name">
					<input type="text" name="uname" id="name_insert" placeholder="이름입력" onblur="checkFn('name')">
				</div>
				<div class="inputname phone">
					<label>연락처<span class="red" id="red5"></span></label>
				</div>
				<div class="jointable phone">
					<select name="uphone1" id="phone1">
						<option value="010">010</option>
						<option value="010">011</option>
						<option value="010">016</option>
					</select>&nbsp;
					<input type="text" class="impor" name="uphone2" id="phone2" placeholder="연락처2" maxlength="4" onblur="checkFn('phone2')">&nbsp;
					<input type="text" class="impor" name="uphone3" id="phone3" placeholder="연락처3" maxlength="4" onblur="checkFn('phone3')">
				</div>
				<div class="joinsubmit">
					<br>
					<br>
					<input type="submit" id="joinBtn" value="회원가입">
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
	
		//value는 input에 들어가는 값이니까 span에서는 적용 안될 수 있음.그래서 html로 함	
		var red1 = $("#red1").html();
		var red2 = $("#red2").html();
		var red3 = $("#red3").html();
		var red4 = $("#red4").html();
		var red5 = $("#red5").html();
		
		var id_span = $("#id_span").html();
		
		
		if((pwd == "")||(id == "")||(phone2 == "")||(phone3 == "")){
			alert("값을 모두 입력해주세요");
			return false;
		}else if(pwd != pwd_check){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}else if((red1 != "")||(red2 != "")||(red3 != "")||(red4 != "")||(red5 != "")){
			alert("형식이 바르지 않습니다");
			return false;
		}else if(id_span == ""){
			alert("아이디 중복체크를 해주세요");
			return false;	
		}else if(id_span == "사용불가"){
			alert("아이디가 중복됩니다");
			return false;
		}else{
			alert("회원가입이 완료되었습니다");
			return true;	
		}	
	}

	
	function tryChange(val){
		var id_span = document.getElementById('id_span');
		alert("id 중복체크를 해주세요");
		
		id_span.textContent = "";
		
	}
</script>
</html>
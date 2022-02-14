<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>     
<%	
	request.setCharacterEncoding("UTF-8");   
    
	LoginUser login = (LoginUser)session.getAttribute("loginUser");
	String uidx = request.getParameter("uidx");

	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String userid_ = "";
	String upwd_ = "";
	String uname_ = "";
	String uphone_ = "";
	int uidx_ = 0;  
    
	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from loginUser where uidx="+uidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			userid_ = rs.getString("userid");
			upwd_ = rs.getString("upwd");
			uname_ = rs.getString("uname");
			uphone_ = rs.getString("uphone");
			uidx_ = rs.getInt("uidx");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
	
  
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
<script>
	function checkFn(type){
		if(type == 'pwd'){
			var regular =/^[a-z0-9_-]{4,18}$/;
			var value = document.getElementById('pwd').value;
			var span = document.getElementById('pwdspan');
			
			if(value == ""){
				span.textContent = "필수";
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
			}
			
		}else if(type == 'pwd_check'){
			var value1 = document.getElementById('pwd').value;
			var value2 = document.getElementById('pwd_check').value;
			var span = document.getElementById('pwdrespan');

			if(value2 == ""){
				span.textContent = "필수";
			}else if(value1 != value2){
				span.textContent = "비밀번호 불일치";
			}else{
				span.textContent = "";
			}
			
			
		}else if(type =='phone2'){
			var regular = /^[0-9]{3,4}/g;
			var value = document.getElementById('phone2').value;
			var span = document.getElementById('phonespan');

			if(value == ""){
				span.textContent = "필수";
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
			}
			
		}else if(type =='phone3'){
			var regular = /^[0-9]{3,4}/g;
			var value = document.getElementById('phone3').value;
			var span = document.getElementById('phonespan');

			if(value == ""){
				span.textContent = "필수";
			}else if(!regular.test(value)){
				span.textContent = "형식오류";
			}else{
				span.textContent = "";
			}
		}
	}
</script>
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
	<div class="MU_wrap">
		<div class="modifyUser_title">
		<strong>회원정보 수정</strong><br><br>
		고객님께서 가입하신 코딩스토리 회원정보입니다.<br>
		비밀번호와 휴대폰 번호를 변경하고자 하는 경우 이 화면에서 수정하시기 바랍니다.
		</div>
		<hr>
		<div class="modifyUserBox">
			<form name="MUform" action="modifyUserOk.jsp" method="post" onsubmit="return nullcheck();">
				<input type="hidden" name="uidx" value="<%=uidx_ %>">
				<table class="MU_table">
					<tr>
						<th>아이디</th>
						<td>|</td>
						<td><%=userid_%></td>
					</tr>
					<tr>
						<th>이름</th>
						<td>|</td>
						<td><%=uname_ %></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>|</td>
						<td><input type="password" name="upwd" id="pwd" onblur="checkFn('pwd')"></td>
						<td><span id="pwdspan"></span></td>
					</tr>
					<tr><!-- 비밀번호와 비밀번호 확인이 일치해야 전송 -->
						<th>비밀번호 확인</th>
						<td>|</td>
						<td><input type="password" name="upwd" id="pwd_check" onblur="checkFn('pwd_check')"></td>
						<td><span id="pwdrespan"></span></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>|</td>
						<td>
						<select name="uphone1" id="phone1">
							<option value="010">010</option>
							<option value="010">011</option>
							<option value="010">016</option>
						</select>
							<input type="text" class="impor" name="uphone2" id="phone2" maxlength="4" onblur="checkFn('phone2')">
							<input type="text" class="impor" name="uphone3" id="phone3" maxlength="4" onblur="checkFn('phone3')">
						</td>
						<td><span id="phonespan"></span></td>
					</tr>
				</table>
				<!-- 버튼 type이 없으면 자동 서브밋 되어버림 -->
				<button type="button" onclick="location.href='mypage.jsp'">취소</button>
				<input type="submit" value="저장"> 
			</form>
		</div>
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
<script>
//함수 이름과 변수 이름 중복되지 않게 하기
//button은 type이 없으면 자동으로 submit이 되는데 이 경우 함수가 작동이 못 하니 button type이 필요함.
//그런데 위의 취소버튼도 button태그를 사용했기 때문에 둘다 button 인 경우 뭔가 문제가 생긴는듯.
//그래서 저장은 그냥 input type:submit을 사용했음. 
//return false인 경우 mypage로 돌아감. return false일 시 돌아가는 경로의 설정은 ?
//미입력시 submit되지 않게 하는 함수 && 비밀번호의 일치여부 확인

function nullcheck(){
	var phone2 = document.getElementById('phone2').value;
	var phone3 = document.getElementById('phone3').value;
	var pwd = document.getElementById('pwd').value;
	var pwd_check = document.getElementById('pwd_check').value;
	
	var span1 = document.getElementById('pwdspan').textContent;
	var span2 = document.getElementById('phonespan').textContent;
	
	
	if( ((phone2 != "") && (phone3 != "") && (pwd !="") && (pwd_check != "")) && (pwd == pwd_check)&&(span1=="")&&(span2=="")){
		alert("회원정보가 수정되었습니다.");
		return true;
	}else{
		alert("비밀번호가 일치하지 않거나 값이 바르게 입력되지 않았습니다.");
		return false;
	}
	
}
</script>
</html>
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
	
    System.out.println(uidx);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
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
			<form name="MUform" action="modifyUserOk.jsp" method="post">
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
						<td><input type="password" name="upwd"></td>
					</tr>
					<tr><!-- 비밀번호와 비밀번호 확인이 일치해야 전송이 되도록 함수 넣기 -->
						<th>비밀번호 확인</th>
						<td>|</td>
						<td><input type="password" name="upwd"></td>
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
							<input type="text" class="impor" name="uphone2" id="phone2" maxlength="4" >
							<input type="text" class="impor" name="uphone3" id="phone3" maxlength="4" >
						</td>
					</tr>
				</table>
				<button type="button" onclick="location.href='mypage.jsp'">취소</button>
				<button onclick="check()">저장</button> 
		</form>
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
<script>
function check(){
		alert("회원정보가 수정되었습니다");
}
</script>
</html>
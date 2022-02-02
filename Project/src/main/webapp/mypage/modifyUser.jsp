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
	

	System.out.print(uidx);
	
    
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
	<div class="join_wrap">
		<div class="join_title">
		<strong>회원정보 수정</strong>
		</div>
		<hr>
		<div class="modifyUserBox">
			<form action="modifyUserOk.jsp" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td><%=userid_%></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><%=uname_ %></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="upwd"></td>
					</tr>
					<tr><!-- 비밀번호와 비밀번호 확인이 일치해야 전송이 되도록 onblur 함수 넣기 -->
						<th>비밀번호 확인</th>
						<td><input type="password" name="upwd"></td>
					</tr>
					<tr>
						<th>휴대전화</th>
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
			
			
			
			<!-- <div class="modifyIndex">
				<br>
				<label>아이디</label>
			</div>
			<div>
				
			</div>
		</div>-->
		
		

		</form>
	</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
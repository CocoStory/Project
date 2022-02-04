<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	int uidx_ = login.getUidx();
	
	
	// 글 갯수 - 일단 db에 접속하여 데이터를 불러온 다음, sql문을 count로 작성하고, 세는 기준은 login한 uidx를 기준으로 한다. uidx는 getter로 불러온다.
	
	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	int text_num = 0;

	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		//데이터 베이스 커넥션
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select count(*) from question where uidx="+uidx_;
		
		//Statment 생성
		stmt = conn.createStatement();
		//쿼리 실행
		rs = stmt.executeQuery(sql);
		
		//쿼리실행 결과 출력
		while(rs.next()){
			text_num = rs.getInt(1);
		}
		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(stmt != null){
			stmt.close();
		}
		if(rs != null){
			rs.close();
		}
	}
		
	

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
			<p><%=text_num%><br><span>게시글</span></p>
			<input type="button" value="내가 작성한 글" onclick="location.href='mytext.jsp?uidx=<%=uidx_%>'">
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
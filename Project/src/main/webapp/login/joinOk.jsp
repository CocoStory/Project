<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="Project.vo.*" %>
<%
//join form에 들어있는 name은, 데이터베이스에 존재하는 테이블의 속성(Attribute)과 같아야 합니다.
//jdbc 이용 - form 태그의 데이터를 데이터베이스 loginUser테이블에 insert 해주기

	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("userid");
	String upwd = request.getParameter("upwd");
	String uname = request.getParameter("uname");
	String uphone1 = request.getParameter("uphone1");
	String uphone2 = request.getParameter("uphone2");
	String uphone3 = request.getParameter("uphone3");
	String uphone = uphone1+uphone2+uphone3;
	
	//변수선언
	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	//UIDX,USERID,UPWD,UNAME,UPHONE
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		
		String sql = " insert into loginuser(uidx,userid,upwd,uname,uphone)"
				   + " values(uidx_seq.nextval,?,?,?,?)"; 

	//psmt생성	
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,userid);
		psmt.setString(2,upwd);
		psmt.setString(3,uname);
		psmt.setString(4,uphone);
	
	//sql문 실행
		int result = psmt.executeUpdate();
			
		if(result == 1){ // 성공
			response.sendRedirect("login.jsp");
		} else{ // 실패
			response.sendRedirect("join");
		}
		
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null) conn.close();
			if(psmt != null) psmt.close();
		}
	

%>
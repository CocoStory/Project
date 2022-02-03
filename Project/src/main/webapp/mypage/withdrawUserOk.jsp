<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%	
	String uidx = request.getParameter("uidx");


	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement psmt = null;
	//삭제만 할 것이라 resultset은 필요없다 
	

	try{
		Class.forName("oracle.jdbc.driver.OracleDriver"); //오타가 있으면 ClassNotFound 오류 발생 (대소문자 확인) 
		conn = DriverManager.getConnection(url,user,pass);
		
	
		String sql = " delete from loginUser where uidx="+uidx ;
				
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();  
		
			//추가 작성 필요 (로그아웃 시키기 - 세션초기화)
			session.invalidate();
			response.sendRedirect("../index.jsp");
	
		
		}catch(Exception e){
			e.printStackTrace();
				
		}finally{
			if(conn != null) conn.close();
			if(psmt != null) psmt.close();
		}
		
%>
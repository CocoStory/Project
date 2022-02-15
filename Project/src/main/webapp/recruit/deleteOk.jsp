<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%	
	String jidx = request.getParameter("jidx");

	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement psmt = null;
	//삭제만 할 것이라 resultset은 필요없다 
	

	try{
		Class.forName("oracle.jdbc.driver.OracleDriver"); 
		conn = DriverManager.getConnection(url,user,pass);
		
	
		String sql = " delete from joboffer where jidx="+jidx ;
				
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();  
		
			response.sendRedirect("list.jsp");
	
		
		}catch(Exception e){
			e.printStackTrace();
				
		}finally{
			if(conn != null) conn.close();
			if(psmt != null) psmt.close();
		}
		
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.util.*"%>
<%@ page import="Project.vo.*"%>
<%@ page import="org.json.simple.*" %> 
<%@ page import="java.sql.*" %>   
<%
	request.setCharacterEncoding("UTF-8");

	String userid = request.getParameter("userid");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{//연결하기
		conn = DBManager.getConnection();
	
		String sql = "select userid from loginUser";
	
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
		
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBManager.close(psmt,conn,rs);
}


		
%>
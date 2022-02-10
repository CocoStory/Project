<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.util.*"%>
<%@ page import="java.sql.*"%>
<%
	String aidx = request.getParameter("aidx");
	System.out.println(aidx);

	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "delete from answer where aidx ="+aidx;
		
		psmt = conn.prepareStatement(sql);
		
		psmt.executeUpdate();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}

%>

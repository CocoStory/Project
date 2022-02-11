<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.util.*"%>
<%@ page import="Project.vo.*"%>
<%@ page import="org.json.simple.*" %> 
<%@ page import="java.sql.*" %>   
<%
	//고쳐야함..
	request.setCharacterEncoding("UTF-8");

	String id_value = request.getParameter("id_value");
	boolean result = false;//기본값
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
	
		String sql = "select * from loginUser where userid=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id_value);
		
		rs= psmt.executeQuery();
		
		if(rs.next()){//데이터가 중복된 경우 
			result = true; //중복시 true 
		}
		
		out.print(result); // 다시 전송 
		
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBManager.close(psmt,conn,rs);
}


		
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.util.*"%>
<%@ page import="Project.vo.*"%>
<%@ page import="org.json.simple.*" %> 
<%@ page import="java.sql.*" %>   
<%
	request.setCharacterEncoding("UTF-8");

	String id_value = request.getParameter("id_value");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
	
		String sql = "select * from loginUser where userid='"+id_value+"'";
		
		psmt = conn.prepareStatement(sql);
		rs= psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		
		if(rs.next()){//데이터가 중복된 경우 
			JSONObject jobj = new JSONObject();
		
			jobj.put("userid",rs.getString("userid"));
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString()); // 다시 전송 
		
}catch(Exception e){
	e.printStackTrace();
}finally{
	DBManager.close(psmt,conn,rs);
}


		
%>
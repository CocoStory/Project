<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "Project.util.*" %>
<%@ page import = "Project.vo.*" %>

<%
	String userid = request.getParameter("userid");
	String upwd = request.getParameter("upwd");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from LoginUser where userid=? and upwd = ? ";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,userid);
		psmt.setString(2,upwd);
		
		rs = psmt.executeQuery();
		LoginUser login = null;
		
		if(rs.next()){
			
			login = new LoginUser(); //만들어진 빈, 기본값, 데이터 채울 곳 
			login.setUidx(rs.getInt("uidx"));
			login.setUserid(rs.getString("userid"));
			login.setUname(rs.getString("uname"));	//객체생성
		
			//세션에 담아야함
			session.setAttribute("loginUser",login);
			
		}
		
		if(login != null){//입력한 아이디,패스워드가 존재하면 login 이 null이 아니게 된다.
			response.sendRedirect(request.getContextPath());
		}else{
			response.sendRedirect("login.jsp"); //다시 로그인 페이지로 이동 
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
		
	}



%>
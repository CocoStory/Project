<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="Project.vo.*" %>
<%	//board 글 등록을 위한 눈에 보이지 않는 화면


	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	//form name값과 일치해야함
	String jtitle = request.getParameter("jtitle"); 
	String jwriter = request.getParameter("jwriter");
	String jcontent = request.getParameter("jcontent");
	
	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	//저장만 하고 끝나기에 result set은 필요없다
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		
		String sql = " insert into joboffer(jidx,jtitle,jwriter,jcontent,uidx)"
				   + " values(jidx_seq.nextval,?,?,?,?)"; //포린키가 1인 것으로 넣기
		
		//uidx는 포린키
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,jtitle);
		psmt.setString(2,jwriter);
		psmt.setString(3,jcontent);
		psmt.setInt(4,login.getUidx());
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("list.jsp");
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>
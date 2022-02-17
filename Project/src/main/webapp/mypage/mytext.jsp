<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>     
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>      
<%
	
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");   
	
	String uidx = request.getParameter("uidx");

	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	//게시판1
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//게시판2
	PreparedStatement psmt = null;
	ResultSet rs2 = null;
	
	//select * from 
	//(SELECT ROWNUM r, que.* 
	//FROM (select * from question where uidx=1) que);
	
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		String sql = ""; 
		
		//String sql = " select * from question where uidx="+uidx;	
		
		sql = " select * from ";
		sql += " (select ROWNUM r , que.* from ";
		sql += " (select * from question where uidx="+uidx+") que)";
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		//sql = " select * from joboffer where uidx="+uidx;	
		sql = " select * from ";
		sql += " (select ROWNUM r , job.* from ";
		sql += " (select * from joboffer where uidx="+uidx+") job)";
		
		psmt = conn.prepareStatement(sql);
		rs2 = psmt.executeQuery(); 

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글 보기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
<div class="list_wrap">
	<div class="list_title">
	<strong>내가 쓴 글 보기</strong>
	</div>
		<div class="listtable_wrap">
			<div class="view_title">
				<strong>Q&amp;A 에서 내가 쓴 글</strong>
			</div>
		<table width="100%">
			<thead>
				<tr>					
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()){
				%>
					<tr>
						<td><%= rs.getInt(1) %></td>
						<td><a href="../question/view.jsp?qidx=<%= rs.getInt("qidx") %>"><%= rs.getString("qtitle") %></a></td>
						<td><%= rs.getString("qwriter") %></td>
						<td><%= rs.getString("qwdate") %></td>
					</tr>
				<%
					}
				%>	
			</tbody>
		</table>
	<br><br><br><br>
		<div class="view_title">
				<strong>Recruit 에서 내가 쓴 글</strong>
			</div>
		<table width="100%">
		<thead>
			<tr>					
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>		
		<tbody>				
			<%
				while(rs2.next()){
			%>
				<tr>
					<td><%= rs2.getInt(1) %></td>
					<td><a href="../recruit/view.jsp?jidx=<%= rs2.getInt("jidx") %>"><%= rs2.getString("jtitle") %></a></td>
					<td><%= rs2.getString("jwriter") %></td>
					<td><%= rs2.getString("jdate") %></td>
				</tr>
			<%
				}
			%>		
		</tbody>
		</table>
		</div>
</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(stmt != null)stmt.close();
		if(rs != null)	rs.close();
		if(psmt != null) psmt.close();
		if(rs2 != null) rs2.close();
		
	}
%>
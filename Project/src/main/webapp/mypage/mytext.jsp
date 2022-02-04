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
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String qtitle_ = "";
	String qwriter_ = "";
	String qcontent_ = "";
	int uidx_ = 0;
	int qidx_ = 0;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from question where uidx="+uidx;		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		

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
		<table width="100%">
			<thead>
				<tr>					
					<th width>글번호</th>
					<th width>제목</th>
					<th width>작성자</th>
					<th width>작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()){
				%>
					<tr>
						<td><%= rs.getInt("qidx") %></td>
						<td><a href="../question/view.jsp?qidx=<%= rs.getInt("qidx") %>"><%= rs.getString("qtitle") %></a></td>
						<td><%= rs.getString("qwriter") %></td>
						<td><%= rs.getString("qwdate") %></td>
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
		if(conn != null){
			conn.close();
		}
		if(stmt != null){
			stmt.close();
		}
		if(rs != null){
			rs.close();
		}
	}
%>
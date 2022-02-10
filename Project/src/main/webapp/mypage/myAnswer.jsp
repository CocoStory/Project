<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>     
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>      
<%
	
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");   
	
	String uidx = request.getParameter("uidx");
	String uname = login.getUname();

	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from answer where uidx="+uidx;		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 댓글 보기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
<div class="list_wrap">
		<div class="list_title">
		<strong>내가 쓴 댓글 보기</strong>
		</div>
		
	<div class="listtable_wrap">
		<table id ="answerTable">
				<%
					while(rs.next()){
				%>
				<tr>					
					<th><%=uname %></th>
					<td><%=rs.getString("acontent") %></td>
					<td><input type="button" value="글보기" onclick="location.href='../question/view.jsp?qidx=<%= rs.getInt("qidx") %>'"></td>
	<!-- 일단 qidx필요. qidx찾아서 그 글로 바로가게. qidx는 getInt로 불러올 수 있다. -->
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
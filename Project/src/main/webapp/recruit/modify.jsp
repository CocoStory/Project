<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%	
	request.setCharacterEncoding("UTF-8");
	
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String jidx = request.getParameter("jidx");
	
	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String jtitle_ = "";
	String jwriter_ = "";
	String jcontent_ = "";
	int jidx_ = 0;  

	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from joboffer where jidx="+jidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			jtitle_ = rs.getString("jtitle");
			jwriter_ = rs.getString("jwriter");
			jcontent_ = rs.getString("jcontent");
			jidx_ = rs.getInt("jidx");
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}

%>    
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정화면</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
<section>
<div class="modfiy_wrap">
	<div class="modify_title">
			<strong>글수정</strong>
	</div>
	<hr>
	<article>
		<div class="modify_table">
		<form action="modifyOk.jsp" method="post">
		<input type="hidden" name="jidx" value="<%=jidx_ %>">
			<table width="100%">
					<tr>
						<th>글제목</th>
						<td colspan="3"><input type="text" size="50" name="jtitle" value="<%=jtitle_%>"></td>
					</tr>
					<tr>
						<th>글번호</th>
						<td><%=jidx_ %></td>
						<th>작성자</th>
						<td><%=jwriter_ %></td>
					</tr>
					<tr height="300">
						<th>내용</th>
						<td colspan="3">
							<textarea name="jcontent"><%=jcontent_ %></textarea><!-- 반드시 name이 있어야 입력양식이 파라미터로 전송된다 -->
						</td>
					</tr>
				</table>
				<button type="button" onclick="location.href='view.jsp?jidx=<%=jidx%>'">취소</button>
				<button>저장</button> 
		</form>
		</div><!-- 표 -->
	</article>
</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
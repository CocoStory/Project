<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%	
	request.setCharacterEncoding("UTF-8");
	
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String qidx = request.getParameter("qidx");
	
	String url  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String qtitle_ = "";
	String qwriter_ = "";
	String qcontent_ = "";
	int qidx_ = 0;  

	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from question where qidx="+qidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			qtitle_ = rs.getString("qtitle");
			qwriter_ = rs.getString("qwriter");
			qcontent_ = rs.getString("qcontent");
			qidx_ = rs.getInt("qidx");
		}
		
		//System.out.println(qcontent_);
		
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
			<strong>Q&A 수정하기</strong>
	</div>
	<hr>
	<article>
		<div class="modify_table">
		<form action="modifyOk.jsp" method="post">
		<input type="hidden" name="qidx" value="<%=qidx_ %>">
			<table width="100%">
					<tr>
						<th>글제목</th>
						<td colspan="3"><input type="text" size="50" name="qtitle" value="<%=qtitle_%>"></td>
					</tr>
					<tr>
						<th>글번호</th>
						<td><%=qidx_ %></td>
						<th>작성자</th>
						<td><%=qwriter_ %></td>
					</tr>
					<tr height="300">
						<th>내용</th>
						<td colspan="3">
							<textarea name="qcontent"><%=qcontent_ %></textarea><!-- 반드시 name이 있어야 입력양식이 파라미터로 전송된다 -->
						</td>
					</tr>
				</table>
				<button type="button" onclick="location.href='view.jsp?qidx=<%=qidx%>'">취소</button>
				<button>저장</button> 
		</form>
		</div><!-- 표 -->
	</article>
</div>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
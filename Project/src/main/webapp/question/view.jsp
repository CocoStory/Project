<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%

	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//DB에 연결하는 부분 	 
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
	int uidx_ = 0;
	
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
			uidx_ = rs.getInt("uidx");
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
<title>Q&A 상세보기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
	<div class="view_wrap">
		<div class="view_title">
			<strong>Q&A 상세보기</strong>
		</div>
		<hr>
		<div class="view_table">
			<table width="100%">
				<tr>
					<th>글제목</th>
					<td colspan="3"><%=qtitle_ %></td>
				</tr>
				<tr>
					<th>글번호</th>
					<td><%=qidx_ %></td>
					<th>작성자</th>
					<td><%=qwriter_ %></td>
				</tr>
				<tr height="300">
					<th>내용</th>
					<td colspan="3"><%=qcontent_ %></td>
				</tr>
			</table>
		</div>
		<div class="view_button">
			<button onclick="location.href='list.jsp'">목록</button>
				
			<% if(login != null && login.getUidx() == uidx_){ %>
			
			<button onclick="location.href='modify.jsp?qidx=<%=qidx_%>'">수정</button>
			<button onclick="deleteFn()">삭제</button>
			<%
				} 
			%>
			<form name="frm" action="deleteOk.jsp" method="post">
				<input type="hidden" name="qidx" value="<%=qidx_%>">
			</form>
		</div>
	</div>
	</section>
	<%@ include file="/footer.jsp" %>
<script>
	function deleteFn(){
		console.log(document.frm);			
		document.frm.submit();
	}	
</script>
</body>
</html>
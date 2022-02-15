<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="java.util.*" %>    
<%
	//joboffer
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//DB에 연결하는 부분 	 
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
	int uidx_ = 0;
	
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
<title>Recruit 상세보기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	var uidx = 0;
	
	<%
	if(login != null){
	%>
	uidx = <%=login.getUidx() %> 
	<%
	}
	%>

</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
	<div class="view_wrap">
		<div class="view_title">
			<strong>recruit 상세보기</strong>
		</div>
		<hr>
		<div class="view_table"><!-- 글 공간 -->
			<table width="100%">
				<tr>
					<th>글제목</th>
					<td colspan="3"><%=jtitle_ %></td>
				</tr>
				<tr>
					<th>글번호</th>
					<td><%=jidx_ %></td>
					<th>작성자</th>
					<td><%=jwriter_ %></td>
				</tr>
				<tr height="300">
					<th>내용</th>
					<td colspan="3"><%=jcontent_ %></td>
				</tr>
			</table>
		</div>
		<div class="view_button"><!-- 목록 수정 삭제 버튼 -->
			<button onclick="location.href='list.jsp'">목록</button>
				
			<% if(login != null && login.getUidx() == uidx_){ %>
			
			<button onclick="location.href='modify.jsp?jidx=<%=jidx_%>'">수정</button>
			<button onclick="deleteFn()">삭제</button>
			<%
				} 
			%>	
			<form name="frm" action="deleteOk.jsp" method="post">
				<input type="hidden" name="jidx" value="<%=jidx_%>">
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
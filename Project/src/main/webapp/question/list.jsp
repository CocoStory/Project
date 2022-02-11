<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="Project.vo.*" %> 
<%@ page import="Project.util.*" %> 
<%

	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	request.setCharacterEncoding("UTF-8");
	
	//searchValue 가 null 이면 검색버튼을 누르지 않고 화면으로 들어옴.
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	
	String nowPage = request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	PagingUtil paging  = null;
	
	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		String sql = ""; 
		//String sql = " select * from question";
		
		
		sql = " select count(*) as total from question ";
		if(searchValue != null && !searchValue.equals("")){
			if(searchType.equals("qtitle")){
				sql +=" where qtitle like '%"+searchValue+"%'";
			}else if(searchType.equals("qwriter")){
				sql +=" where qwriter like '%"+searchValue+"%'";	
			}
		}
		

		sql += " order by qidx desc";
		
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
	
		int total = 0;
		
		if(rs.next()){
			total = rs.getInt("total"); 	
		}
		
		paging = new PagingUtil(total,nowPageI,15); // 한 페이지에 들어가는 갯수 15개 
		
		sql = " select * from ";		
		sql += " (select ROWNUM r , b.* from ";	//오라클에서 페이징 하는 방법 
		sql += " (select * from question";
		
		if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
			if(searchType.equals("qtitle")){
				sql += " where question like '%"+searchValue+"%'";
			}else if(searchType.equals("qwriter")){
				sql += " where qwriter = '"+searchValue+"'";
			}
			
		}
		
		sql += " order by qidx desc ) b)";
		sql += " where r >= "+paging.getStart()+" and r <= "+paging.getEnd();
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CodingStory Q&A</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="/header.jsp" %>
	<section>
	<div class="list_wrap">
		<div class="list_title">
			<strong>Hello, Q&A</strong>
			<p>궁금한 것을 물어보세요!</p>
			<p>코딩관련한 것들을 질문하시면 답변을 달아드립니다!</p>
			<br><br>
			<div class="list_insert_button">
				<% if(login != null){ %>
				<button onclick="location.href='insert.jsp'">글쓰기</button>
				<% } %>
			</div>
		</div>
		<div class="list_searchbar searchArea">
			<form action="list.jsp">
				<select name="searchType">
					<option value="qtitle" <%if(searchType != null && searchType.equals("qtitle")) out.print("selected"); %>>글제목</option>
					<option value="qwriter" <%if(searchType != null && searchType.equals("qwriter")) out.print("selected"); %>>작성자</option>
				</select>
				<input type="text" name="searchValue"
				<%	if(searchValue != null && !searchValue.equals("")&& !searchValue.equals("null")) 
					out.print("value='"+searchValue+"'");
				%>>
				<input type="submit" value="검색">
			</form>
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
						<td><a href="view.jsp?qidx=<%= rs.getInt("qidx") %>"><%= rs.getString("qtitle") %></a></td>
						<td><%= rs.getString("qwriter") %></td>
						<td><%= rs.getString("qwdate") %></td>
					</tr>
				<%
					}
				%>		
			</tbody>
		</table>
		</div>
		<div class="list_paging">
			<% if(paging.getStartPage() > 1){
			%>	
				<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>	
			<%	
			}
			
			for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
				
				if(i == paging.getNowPage()){
			%>
				<b class="active"><%= i %></b>
			<%
				}else{
			%>
				<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i %></a>				
			<% 
				}
			}
			if(paging.getEndPage() != paging.getLastPage()){
			%>	
				<a href="list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>	
			<%	
			}
			%>		
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
		if(psmt != null){
			psmt.close();
		}
		if(rs != null){
			rs.close();
		}
	}
%>
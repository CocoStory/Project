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
	
	//댓글
	PreparedStatement psmtAnswer = null;
	ResultSet rsAnswer = null;
	

	String qtitle_ = "";
	String qwriter_ = "";
	String qcontent_ = "";
	int qidx_ = 0;
	int uidx_ = 0;
	
	ArrayList<Answer> aList = new ArrayList<>();
	
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
		
		sql = "select * from answer a, loginUser u where a.uidx = u.uidx and qidx="+qidx;
		
		psmtAnswer = conn.prepareStatement(sql); //실행
		
		rsAnswer = psmtAnswer.executeQuery();//담기
		
		while(rsAnswer.next()){
			Answer answer = new Answer();
			answer.setQidx(rsAnswer.getInt("qidx"));
			answer.setUidx(rsAnswer.getInt("uidx"));
			answer.setAidx(rsAnswer.getInt("aidx"));
			answer.setAcontent(rsAnswer.getString("acontent"));
			answer.setAdate(rsAnswer.getString("adate"));
			answer.setUname(rsAnswer.getString("uname"));
			
			aList.add(answer);
		}
				

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
		if(psmtAnswer != null)psmtAnswer.close();
		if(rsAnswer != null)rsAnswer.close();
	
	}
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
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
	
	//댓글등록
	
	function saveR(){
	$.ajax({  
		url:"answer.jsp", 
		type:"post", 
		data : $("form[name='answer']").serialize(), 
		success: function(data){ 
			var json = JSON.parse(data.trim()); 
			var html = "<tr>";
			html += "<td>"+json[0].uname+" <input type='hidden' name='aidx' value='"+json[0].aidx+"'></td>";
			html += "<td>"+json[0].acontent+"</td>"; 
			html += "<td>"

			if(uidx == json[0].uidx){
				html += "<input type='button' value='수정' onclick='modify(this)'>";
				html += "<input type='button' value='삭제' onclick='delteAnswer(this)'>";			
				}
					
			html += "</td>";
			html += "</tr>";

			$("#answerTable>tbody").append(html); 
			

			document.answer.reset();
			
		}
	
	});
}
	
	
	//댓글수정버튼 클릭시 실행함수
	
	function modify(obj){
		
		var acontent = $(obj).parent().prev().text();
		var html = "<input type='text' name='acontent' value='"+acontent+"'><input type='hidden' name='origin' value='"+acontent+"'>";
		$(obj).parent().prev().html(html);
		
		html = "<input type='button' value='저장' onclick='updateAnswer(this)'><input type='button' value='취소' onclick='cancelAnswerModify(this)'>";
		$(obj).parent().html(html);
		
	}
	
	
	
	//댓글수정창 들어가서 수정에 성공했을 시 실행 되는 함수
	//val() - form의 값을 가져오거나 값을 설정할 수 있다. 
	//obj(button)의 parent(td)의 prev(앞)에서 td와 th를 찾아 input을 find하기.
	//post:date 보내줄 때 사용 //date:전송할 데이터 
	//success에서의 function(data)여기서 data는 url 실행시 결과로 받아오는 것을 의미함. 
	//function() 에서 ()의 이름은 꼭 data가 아니라 아무 이름이나 들어가도 됨.
	
	
	
	function updateAnswer(obj){
		var aidx = $(obj).parent().prev().prev().find("input:hidden").val();
		var acontent = $(obj).parent().prev().find("input:text").val();
		
	$.ajax({	
		url:"updateAnswer.jsp",
		type:"post",
		data:"aidx="+aidx+"&acontent="+acontent,
		success : function(data){	
			$(obj).parent().prev().html(acontent);
			
			var html = "<input type='button' value='수정' onclick='modify(this)'>";
			html += "<input type='button' value='삭제' onclick='delteAnswer(this)'>";					
			$(obj).parent().html(html);
		}
	});
}
	
	
	
	
	//댓글수정버튼을 클릭후 수정에 취소한 경우에 실행되는 함수 
	
	function cancelAnswerModify(obj){
		
		var originContent = $(obj).parent().prev().find("input[name='origin']").val();
		$(obj).parent().prev().html(originContent);
		
		var html ="";
		html += "<input type='button' value='수정' onclick='modify(this)'>";
		html +="<input type='button' value='삭제' onclick='delteAnswer(this)'>";

		$(obj).parent().html(html);
		
	}
	
	
	
	
</script>
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
		
		<div class="answerArea">
			<div class="answerList">
				<table id="answerTable">
					<tbody>
				<%for(Answer a : aList){ %>
						<tr>
							<th><%=a.getUname() %>  <input type="hidden" name="aidx" value="<%=a.getAidx()%>"></th>
							<td><%=a.getAcontent()%></td>
							<td>
								<%if(login != null && (login.getUidx() == a.getUidx())){ %>
								<input type="button" value="수정" onclick='modify(this)'>
								<input type="button" value="삭제" onclick="deleteAnswer(this)">
								<%} %>
							</td>							
						</tr>						
				<%} %>
					</tbody>
				</table>
				</div>
				<br>
			<div class="answerInput">
				<form name ="answer">
				<input type="hidden" name="qidx" value="<%=qidx%>">
				<% if(login != null){ %>
						<p>
							<label>
								답변하기 <input type="text" name="acontent" size="50">
							</label>
						</p>
						<p>
							<input type="button" value="등록" onclick="saveR()">
						</p>
				<%} %>
				</form>
			</div>
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
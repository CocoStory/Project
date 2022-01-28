<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.vo.*" %> 
<%
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	String userName = "";  //작성자명
	if(login != null){
		userName = login.getUname();
	}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문하기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<%@include file="/header.jsp" %>  
	<section><!-- board -->
	<div class="insert_wrap">
		<div class="insert_title">
		<strong>질문하기<strong>
		</div>
		<article>
		<div class="insert_table">
			<form action="insertOk.jsp" method="post"><!-- 입력받은 값을 어디로 보내기 위해 form 태그 활용  -->
				<table width="100%">
					<tr>
						<th>제목</th>
						<td><input type="text" name="qtitle" required></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="qwriter" value="<%=userName%>" readonly></td>
						<!-- readonly 속성은 <input> 필드가 읽기 전용임을 명시합니다.
						읽기 전용으로 사용자가 수정할 수는 없지만, 하이라이트하거나 복사할 수는 있습니다. -->
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="qcontent" rows="15"></textarea>
						</td>
					</tr>
				</table>
				<input type="button" value="취소" onclick="location.href='list.jsp'">
				<input type="submit" value="등록">
			</form>
		</div>
		</article>
	</div>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>
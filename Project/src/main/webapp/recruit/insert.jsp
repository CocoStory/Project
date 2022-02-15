<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.vo.*" %> 
<%	//JOBOFFER
	LoginUser login = (LoginUser)session.getAttribute("loginUser");

	String userName = "";//작성자명
	if(login != null){
		userName = login.getUname();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet">
<script src = "<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
	function file_submit(obj){
		 var form = $("#fileFrm")[0];	
		 var formData =  new FormData(form);
		 $.ajax({
	         url: "fileAction.jsp",
	         type: "post",
	         data: formData,
	         enctype: "multipart/form-data", 
	         contentType: false,
	         processData: false,
	         success: function(data){
	        	 var imgsys = data.trim();
	        	 setTimeout(() => sleep(), 1000);
	        	  function sleep(){
	        		  $("#jcontent2").append(imgsys); 
	        	 }
	         }
		  });
		}
	
</script>
</head>
<body>
<%@include file="/header.jsp" %>  
	<section><!-- board -->
	<div class="insert_wrap">
		<div class="insert_title">
		<strong>글쓰기<strong>
		</div>
		<article>
		<div class="insert_table">
			<form action="insertOk.jsp" method="post"><!-- 입력받은 값을 보내기 위해 form 태그 활용  -->
				<table width="100%">
					<tr>
						<th>제목</th>
						<td><input type="text" name="jtitle" required></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="jwriter" value="<%=userName%>" readonly></td>
						<!-- readonly 속성은 <input> 필드가 읽기 전용임을 명시합니다.
						읽기 전용으로 사용자가 수정할 수는 없지만, 하이라이트하거나 복사할 수는 있습니다. -->
					</tr>
					<tr>
						<th>내용</th>
						<td id = "content">
							<textarea name="jcontent" rows="15"></textarea><!-- css로 display : none 줘야함 -->
							<div id="jcontent2" contentEditable="true"></div><!-- id(css주기용),contentEditable="true"(textarea처럼 바꿔줌)  -->
							<!-- textarea는 이미지가 안 들어감.  -->			
						</td>
					</tr>
				</table>
				<input type="button" value="취소" onclick="location.href='list.jsp'">
				<input type="submit" value="등록" onclick="writeFn()">
			</form>	
			<!-- 파일전송 form -->
			<form action="fileAction.jsp" id="fileFrm" class ="fileFrm" method="post" enctype="multipart/form-date">
				<input type="file" name ="file">
				<input type="button" id="filebtn" value="이미지첨부" onclick="file_submit()">
			</form>
		</div>
		</article>
	</div>
	</section>
	<%@include file="/footer.jsp" %>
</body>
</html>
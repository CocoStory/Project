<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Project.util.*"%>
<%@ page import="Project.vo.*"%>
<%@ page import="org.json.simple.*" %> 
<%@ page import="java.sql.*" %> 
   
<%	
	request.setCharacterEncoding("UTF-8");
	
	//insert 필요 data 꺼내오기 
	String qidx = request.getParameter("qidx");
	String acontent = request.getParameter("acontent");//댓글쿼리만들기
	
	//session 에서 data 가져오기 - uidx
	LoginUser login = (LoginUser)session.getAttribute("loginUser");
	
	int uidx =  login.getUidx();

	//db 접속 
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	
	
	try{//연결하기
		conn = DBManager.getConnection();
		//쿼리문 작성  - 바인드 변수
		String sql = " insert into answer(aidx,qidx,uidx,acontent,adate)values(aidx_seq.nextval,?,?,?,sysdate)"; //시퀀스는 _seq.nextval로 , radat는 sysdate로 하면 등록 시점으로 들어간다.
		
		
		psmt = conn.prepareStatement(sql); //sql문이 db에 전송되어 진다.
		
		//데이터 넘겨주기 (데이터가 빠진 ?(바인드변수)에 대한 데이터 설정)
		psmt.setInt(1,Integer.parseInt(qidx));
		psmt.setInt(2,uidx);
		psmt.setString(3,acontent);
		
		
		psmt.executeUpdate(); 
		
		//
		sql = "select * from answer a, loginUser u where a.uidx = u.uidx and a.aidx = (select max(aidx) from answer)";
		
		psmt = conn.prepareStatement(sql); // sql 문 db전송 
		
		rs = psmt.executeQuery();//rs:전역변수에 선언한 Resultset
		
		//JSON 사용 이유 - 화면에 동적으로 바로 표시되게 하기 위함 
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("qidx",rs.getInt("qidx"));
			jobj.put("uidx",rs.getInt("uidx"));
			jobj.put("aidx",rs.getInt("aidx"));
			jobj.put("acontent",rs.getString("acontent"));
			jobj.put("uname",rs.getString("uname"));
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString());
		
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	

%>
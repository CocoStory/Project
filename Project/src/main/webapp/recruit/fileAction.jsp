<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*" %>
<%@ page import="Project.vo.*" %>
<%@ page import="Project.util.*" %>
<%@ page import="org.json.simple.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	final String saveFolder = "D:/workspace/upload";
	final String encoding = "UTF-8";
	final int maxSize = 100*1024*1024;
		
    String systemName = "";
    String originName = "";
    String systemName2 = "";

    
    try{
       MultipartRequest multi = new MultipartRequest(request,saveFolder,maxSize,encoding,new DefaultFileRenamePolicy());
		
       systemName = multi.getFilesystemName("file1");
       originName = multi.getOriginalFileName("file1");

       systemName2 = "<img src='"+request.getContextPath()+"/upload/"+systemName+"'>";

       out.print(systemName2);
       
    }catch(Exception e){
        e.printStackTrace();
    }
  %>
    
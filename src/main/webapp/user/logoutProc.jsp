<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	session.invalidate(); //그동안 세션 설정한 것들 다 없앰
	response.sendRedirect("main.jsp");
%>
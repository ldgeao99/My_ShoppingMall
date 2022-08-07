<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
 	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	MemberDao mdao = MemberDao.getInstance();
	MemberBean mbean = mdao.getMemberById(id);
	
	if(mbean != null){
		out.print("IMPOSSIBLE");	
	}else{
		out.print("POSSIBLE");
	}
%>
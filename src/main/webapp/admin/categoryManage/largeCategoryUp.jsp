<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int lno = Integer.parseInt(request.getParameter("lno"));
	int lstep = Integer.parseInt(request.getParameter("lstep")); // 해당 대분류의 순서
	
	CategoryDao cdao = CategoryDao.getInstance();	
	
	int result = -1;
	
	if (lstep > 1) { // 수정하려는 행의 step이 맨 첫번째가 아닌 경우
		result = cdao.updateUpLStep(lno, lstep);
	}

	response.sendRedirect("categoryManage.jsp");
%>
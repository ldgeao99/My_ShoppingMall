<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String lcname = request.getParameter("lcname");
	
	
	CategoryDao cdao = CategoryDao.getInstance();
	int cnt = cdao.insertLCategory(lcname);
	
	String msg = "";
	
	if(cnt > 0){
		msg = "대분류 추가 성공";		
	}
	else{
		msg = "대분류 추가 실패";	
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>
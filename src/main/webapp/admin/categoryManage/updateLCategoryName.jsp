<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int lno = Integer.parseInt(request.getParameter("lno"));
	String i = request.getParameter("i");	
	String lcname = request.getParameter("lcname" + i);
	
	CategoryDao cdao = CategoryDao.getInstance();
	int cnt = cdao.updateLCategoryName(lno, lcname);
	
	String msg = "";
	
	if(cnt > 0){
		msg = "대분류 수정 성공";		
	}
	else{
		msg = "대분류 수정 실패";	
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>

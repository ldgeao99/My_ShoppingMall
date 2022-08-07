<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int lno = Integer.parseInt(request.getParameter("lno"));
	String scname = request.getParameter("scname");
	
	System.out.println("lno: " + lno);
	System.out.println("scname: " + scname);
	
	CategoryDao cdao = CategoryDao.getInstance();
	int cnt = cdao.insertSCategory(lno, scname);
	
	String msg = "";
	
	if(cnt > 0){
		msg = "소분류 추가 성공";		
	}
	else{
		msg = "소분류 추가 실패";	
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>
<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int sno = Integer.parseInt(request.getParameter("sno"));
	String i = request.getParameter("i");	
	String scname = request.getParameter("scname" + i);
	
	System.out.println("sno:" + sno);
	System.out.println("i:" + i);
	System.out.println("scname:" + scname);
	
	CategoryDao cdao = CategoryDao.getInstance();
	int cnt = cdao.updateSCategoryName(sno, scname);
	
	String msg = "";
	
	if(cnt > 0){
		msg = "소분류 수정 성공";		
	}
	else{
		msg = "소분류 수정 실패";	
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>

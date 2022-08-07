<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	int sno = Integer.parseInt(request.getParameter("sno"));
	int sstep = Integer.parseInt(request.getParameter("sstep"));

	CategoryDao cdao = CategoryDao.getInstance();
	int cnt = cdao.deleteSCategory(sno, sstep);
	
	String msg = "";
	
	if(cnt > 0){
		msg = "소분류 삭제 성공";		
	}
	else{
		msg = "소분류 삭제 실패";	
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>
%>
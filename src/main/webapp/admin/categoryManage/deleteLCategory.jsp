<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	int lno = Integer.parseInt(request.getParameter("lno"));
	int lstep = Integer.parseInt(request.getParameter("lstep"));

	CategoryDao cdao = CategoryDao.getInstance();
	
	int cnt = cdao.countScategory(lno);
	
	String msg = "";
	if(cnt != 0){
		msg = "하위 소분류가 존재하여 삭제가 불가합니다.";
	}
	else{
		int result = cdao.deleteLCategory(lno, lstep);
		
		if(result > 0){
			msg = "대분류 삭제 성공";		
		}
		else{
			msg = "대분류 삭제 실패";	
		}
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "categoryManage.jsp"
</script>
%>
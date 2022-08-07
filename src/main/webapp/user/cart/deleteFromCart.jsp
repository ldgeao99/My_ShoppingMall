<%@page import="cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int itemno = Integer.parseInt(request.getParameter("itemno"));

	CartDao ctdao = CartDao.getInstance();
	int cnt = ctdao.deleteItem(itemno);
	
	String url = "";
	
	if(cnt > 0){
		url = "showCart.jsp";
	}
%>

<script>
	location.href = "<%=url%>";
</script>

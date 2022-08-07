<%@page import="cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int no = Integer.parseInt(request.getParameter("cartItemNum"));
	int qty = Integer.parseInt(request.getParameter("qty"));
	
	CartDao ctdao = CartDao.getInstance();
	int cnt = ctdao.updateItem(no, qty);
	
	if(cnt > 0){
		response.sendRedirect("showCart.jsp");
	}
%>
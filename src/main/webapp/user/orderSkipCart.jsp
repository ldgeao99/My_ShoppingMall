<%@page import="cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int mno = (int) session.getAttribute("mno");
	int pno = Integer.parseInt(request.getParameter("pno"));
	int qty = Integer.parseInt(request.getParameter("qty"));
	String opname = request.getParameter("opname");
	
	CartDao ctdao = CartDao.getInstance();
	int cnt = ctdao.insertItem(mno, pno, qty, opname);
	
	int ctno = ctdao.getMaxCtno(mno);
	
	response.sendRedirect("orderView.jsp?ctno=" + ctno);
%>
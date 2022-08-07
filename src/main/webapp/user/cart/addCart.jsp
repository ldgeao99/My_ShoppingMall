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
	
	String url = "";
	
	if (cnt > 0) {
		url = "showCart.jsp";
	}
%>

<script type="text/javascript">
	location.href = "<%=url%>";
</script>
<%@page import="orderlist.OrderBean"%>
<%@page import="orderlist.OrderDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="product.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top_admin.jsp"%> 

<style type="text/css">
	#searchUser{
		margin : auto;
		text-align: right;
		width : 70%;
	}

	#orderManage{
		margin : auto;
		text-align: center;
		width : 80%;
	}
	
	#orderManage a:hover{
		color : #C2674B;
	}
	
	#orderManage > caption{
		font-size: 19px;
	}
	
	/* #productManage tr:hover {background-color: #C2674B;} */
</style>

<%
	request.setCharacterEncoding("UTF-8");
	String searchId = request.getParameter("searchId");
	
	OrderDao odao = OrderDao.getInstance();
	ArrayList<OrderBean> list = null;
	
	if(searchId == null){
		list = odao.getAllOrder(); 
		System.out.println(list.size() + "개1");
	}else{
		list = odao.getAllOrderById(searchId);
		System.out.println(list.size() + "개2");
	}
%>

<form name="f" action="orderList.jsp">
	<table id="searchUser">
		<tr>
			<td></td>
			<td></td>
			<td>
				<input type="text" name="searchId" placeholder="아이디 입력">
				<input type="submit" value="검색">
			</td>
		</tr>
	</table>
</form>

<table id="orderManage">
	<caption>
		<b>주문접수내역</b>
		<hr>
	</caption>
	<tr>
		<th>번호</th>
		<th>주문자ID</th>
		<th>상품명</th>
		<th>옵션명</th>
		<th>단가</th>
		<th>수량</th>
		<th>총계</th>
		<th>배송지</th>
		<th>수령자명</th>
		<th>주문시간</th>
		<th>상품이미지</th>
	</tr>
	<%
	DecimalFormat decFormat = new DecimalFormat("###,###");
	
	for(OrderBean obean : list){%>
	<tr>
		<td><%=obean.getNo()%></td>
		<td><%=obean.getId() %></td>
		<td><%=obean.getName() %></td>
		<td><%=obean.getOpname() %></td>
		<td><%=decFormat.format(obean.getPrice())%>원</td>
		<td><%=obean.getQty() %></td>
		<td><%=decFormat.format(obean.getQty() * obean.getPrice())%>원</td>
		<td>(<%=obean.getRv_zip()%>) <%=obean.getRv_addr1()%> <%=obean.getRv_addr2()%></td>
		<td><%=obean.getReceiver()%></td>
		<td><%=obean.getTime()%></td>
		<td>
			<%
			String fullPath = request.getContextPath() + "/admin/product_images/" + obean.getMainimgn();
			//System.out.println(fullPath);
			%>
			<img src="<%=fullPath%>" width="50px" height="60px">
		</td>
	</tr>
	<%
	}%>
</table>
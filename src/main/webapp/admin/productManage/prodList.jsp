<%@page import="java.text.DecimalFormat"%>
<%@page import="product.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top_admin.jsp"%> 

<style type="text/css">
	#productManage{
		margin : auto;
		text-align: center;
		width : 750px;
	}
	
	#productManage a:hover{
		color : #C2674B;
	}
	
	#productManage > caption{
		font-size: 19px;
	}
	
	/* #productManage tr:hover {background-color: #C2674B;} */
</style>

<%
	ProductDao pdao = ProductDao.getInstance();
	ArrayList<ProductBean> list = pdao.getAllProduct();
%>

<table id="productManage">
	<caption>
		<b>상품관리</b>
		<hr>
	</caption>
	<tr>
		<th>번호</th>
		<th>대분류</th>
		<th>소분류</th>
		<th>상품명</th>
		<th>정가</th>
		<th>할인가</th>
		<th></td>
		<th></td>
		<th>상품이미지</th>
	</tr>
	<%
	DecimalFormat decFormat = new DecimalFormat("###,###");
	
	for(ProductBean pbean : list){%>
	<tr>
		<td><%=pbean.getNo()%></td>
		<td><%=pbean.getLcname() %></td>
		<td><%=pbean.getScname() %></td>
		<td><a href="<%=request.getContextPath()%>/user/productDetail.jsp?no=<%=pbean.getNo()%>"><%=pbean.getName()%></a></td>
		<td><%=decFormat.format(pbean.getOriprice())%>원</td>
		<td><%=decFormat.format(pbean.getDiscprice())%>원</td>
		<td><a href="prodUpdateForm.jsp?pno=<%=pbean.getNo()%>">수정</a></td>
		<td><a href="prodDelete.jsp?pno=<%=pbean.getNo()%>">삭제</a></td>
		<td>
			<%
			String rContext = request.getContextPath() + "/admin/product_images/";
			String fullPath = rContext + pbean.getMainImgN();
			System.out.println(rContext);
			System.out.println(fullPath);
			%>
			<img src="<%=fullPath%>" width="50px" height="60px">		
		</td>
	</tr>
	<%
	}%>
	
	<tr>
		<td colspan="9"><button onClick="location.href='prodInsertForm.jsp'">상품등록</button></td>
	</tr>
</table>
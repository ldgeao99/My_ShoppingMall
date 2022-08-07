<%@page import="java.text.DecimalFormat"%>
<%@page import="product.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./top_user.jsp"%>

<style type="text/css">
	body {
		font-family: Noto Sans Kr;
		font-size: 13px;
	}
	
	#mainList {
		margin: auto;
		margin-top : 50px;
		text-align: center;
		width: 750px;
	}
	
	#mainListInside td {
		padding-left: 10px;
		padding-right: 10px;
	}
	
	#mainListInside h3 {
		padding-top: 10px;
		padding-bottom: 10px; font-size : 13px;
		word-spacing: -1px;
		color: #000;
		border-bottom: 1px solid #D5D5D5;
		font-size: 13px
	}
	
	#mainListInside td>span {
		color: #555555;
		font-size: 12px;
	}
	
</style>

<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#banner_image').show();
		/* $('#banner_image').hide();
		$('#banner_image').fadeIn(3000);
		setInterval(function(){
			$('#banner_image').hide();
			$('#banner_image').fadeIn(3000);
		}, 5000); */
	});
</script>


<%
	int lcno = Integer.parseInt(request.getParameter("lcno"));
	
	ProductDao pdao = ProductDao.getInstance();
	ArrayList<ProductBean> list = pdao.getAllProductByLcno(lcno); 
	
	DecimalFormat decFormat = new DecimalFormat("###,###");
%>

<%
	if(list.size() == 0){%>
		<table id="mainList">
		<tr>
			<td>해당 카테고리에는 진열된 상품이 존재하지 않습니다.</td>
		</tr>
		</table>
	<%
	}else{%>
	<table id="mainList">
		<tr>
		<%
			for(int i = 0; i < list.size(); i++){
				ProductBean pbean = list.get(i);
				
				String fullPath = request.getContextPath() + "/admin/product_images/" + pbean.getMainImgN();
				System.out.println(fullPath);
				%>
					<td>
						<table id="mainListInside">
							<tr>
								<td><a href="productDetail.jsp?no=<%=pbean.getNo()%>"><img src=<%=fullPath%> width="300px" height="380px"></a></td>
							</tr>
							<tr>
								<td><h3><%=pbean.getName()%></h3></td>
							</tr>
							<tr>
								<td width="300px"><span><%=pbean.getInfo()%></span></td>
							</tr>
							<tr>
								<td>
									<span style="text-decoration:line-through;"><%=decFormat.format(pbean.getOriprice())%>원</span>
									<span><%=decFormat.format(pbean.getDiscprice())%>원</span>
								</td>
							</tr>
						</table>
					</td>
				<%
				if(i%4 == 3){%>
					</tr>
					<tr>
				<%	
				}
			}
		%>
		</tr>
	</table>	
	<%
	}
%>

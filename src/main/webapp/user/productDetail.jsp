<%@page import="java.text.DecimalFormat"%>
<%@page import="product.stock.StockBean"%>
<%@page import="product.stock.StockDao"%>
<%@page import="product.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./top_user.jsp"%>

<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<style type="text/css">
	/* 5 */
	.custom-btn {
	  background: #000;
	  color: #fff;
	  line-height: 42px;
	  padding: 0;
	  border: none;
	  font-size: 15px;
	  cursor:pointer;
	}
</style>


<style type="text/css">
	#detailTopArea{
		margin : auto;
		width: 1000px;
	}
	
	
	#mainImg{
		margin : 50px;
	}
	
	h3{
		padding-top: 10px;
		word-spacing: -1px;
		color: #000;
		/* border-bottom: 1px solid #D5D5D5; */
		font-size: 24px
	}
	
	#detailMiddleArea{
		margin : auto;
		width: 800px;
		
	}
	
	#detailTopRight{
		margin-right: 55px;
		border-spacing: 5px;
	}
	
	#detailTopRight td:nth-child(2){
		text-align: center;
		width: 80%;
	}
	
	#detailTopRight td #info{
		color: #555555;
		font-size: 12px;
	}
	
	#detailTopRight td{
		color: #555555;
		font-size: 14px;
	}

</style>


<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$(".plus").click(function() {
			var num = $(".numBox").val();
			var plusNum = Number(num) + 1;
			
			$(".numBox").val(plusNum);
		});

		$(".minus").click(function() {
			var num = $(".numBox").val();
			var minusNum = Number(num) - 1;
			
			if(minusNum <= 0) {
				$(".numBox").val(num);
			} 
			else {
				$(".numBox").val(minusNum);          
			}
		});
		
		
	});
	
	function addCart(pno){
		<%
		if(session.getAttribute("mno") == null){
		%>
				alert("로그인 먼저 해야합니다.");
				location.href="loginView.jsp";
				return;
		<%
		}
		%>
		
		if($('#optionSelect').val() == ""){
			//alert($('#optionSelect').val());
			alert("옵션을 선택해주세요");
			return;
		}

		var qty = $(".numBox").val();
		var opname = $('#optionSelect').val();
		
		var count = (($('select option:selected').text()).split("(")[1]).split("개")[0]; // 재고
		
		if(parseInt(count) < parseInt(qty)){
			alert("재고수량을 확인 후 다시 시도하세요");
			return;
		}
		
		location.href = "./cart/addCart.jsp?pno=" + pno + "&qty=" + qty + "&opname=" + opname; 
	}
	
	function addCartSkipShow(pno){
		<%
		if(session.getAttribute("mno") == null){
		%>
				alert("로그인 먼저 해야합니다.");
				location.href="loginView.jsp";
				return;
		<%
		}
		%>
		
		if($('#optionSelect').val() == ""){
			//alert($('#optionSelect').val());
			alert("옵션을 선택해주세요");
			return;
		}
		
		var qty = $(".numBox").val();
		var opname = $('#optionSelect').val();
		
		var count = (($('select option:selected').text()).split("(")[1]).split("개")[0]; // 재고
		
		if(parseInt(count) < parseInt(qty)){
			alert("재고수량을 넘어서는 주문 시도는 불가능 합니다");
			return;
		}
		
		location.href = "./orderSkipCart.jsp?pno=" + pno + "&qty=" + qty + "&opname=" + opname; 
	}
</script>


<%
	int pno = Integer.parseInt(request.getParameter("no"));
	System.out.println("no:" + pno);

	ProductDao pdao = ProductDao.getInstance();
	ProductBean pbean = pdao.getProduct(pno);
	
	String fullPath = request.getContextPath() + "/admin/product_images/" + pbean.getMainImgN();
	//System.out.println(fullPath);
	DecimalFormat decFormat = new DecimalFormat("###,###");
%>

<table id="detailTopArea">
	<tr>
		<td>
			<img id="mainImg" src="<%=fullPath%>" width="450px" height="550px">
		</td>
		<td>
			<table id="detailTopRight">
				<tr>
					<td colspan="2">
						<h3><%=pbean.getName() %></h3>
						<img src="../images/depart_today.png">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<span id="info"><%=pbean.getInfo() %></span>
						<br><br>
					</td>
				</tr>
				<tr>
					<td colspan="2"><h4> </h4></td>
				</tr>
				<tr>
					<td>정가</td>
					<td><span style="text-decoration:line-through"><%=decFormat.format(pbean.getOriprice())%></span>원</td>
				</tr>
				<tr>
					<td>할인가</td>
					<td><%=decFormat.format(pbean.getDiscprice())%>원</td>
				</tr>
				<tr>
					<td>수량선택</td>
					<td>
						<button type="button" class="plus">+</button>
						<input type="number" class="numBox" min="1" max="999" size="10" value="1" readonly="readonly" style="width: 40px; text-align:right;" >
						<button type="button" class="minus">-</button>
					</td>
				</tr>
				<!-- <tr>
					<td colspan="2">
						<h3>
					</td>
				<tr> -->
				<tr>
					<td colspan="2">
						<select style="width : 100%; height: 25px" id="optionSelect">
							<option value="">옵션선택</option>
							<%
							StockDao sdao = StockDao.getInstance();
							ArrayList<StockBean> slist = sdao.getAllStockByPno(pno);
							
							for(StockBean sbean : slist){%>
								<option value="<%=sbean.getOpname()%>" <%if(sbean.getCount() == 0){%> disabled <%} %>>
									<%=sbean.getOpname()%> 
									<%
										for(int i = 0; i<30 ;i++){%>
											&nbsp;		
										<%}
									
										if(sbean.getCount() == 0){
										%>
										(품절)
										<%		
										}
										else{%>
										(<%=sbean.getCount()%>개 남음)
										
										<%	
										}
									%>									
								 </option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><h4>&nbsp;</h4></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="장바구니 추가" style="width: 100%; height:50px" class="custom-btn" onClick="addCart(<%=pbean.getNo()%>)"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="바로구매" style="width: 100%; height:50px" class="custom-btn" onClick="addCartSkipShow(<%=pbean.getNo()%>)"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table id="detailMiddleArea">
<%
	String detailImg_fullPath = null;

	if(pbean.getDetailImgN1() != null){
		detailImg_fullPath= request.getContextPath() + "/admin/product_images/" + pbean.getDetailImgN1();
		%>
		<tr>
			<td>	
				<img src = "<%=detailImg_fullPath%>">
			</td>
		</tr>
		<%
	}
	
	if(pbean.getDetailImgN2() != null){
		detailImg_fullPath= request.getContextPath() + "/admin/product_images/" + pbean.getDetailImgN2();
		%>
		<tr>
			<td>
				<img src = "<%=detailImg_fullPath%>">
			</td>
		</tr>
		<%
	}
	
	if(pbean.getDetailImgN3() != null){
		detailImg_fullPath= request.getContextPath() + "/admin/product_images/" + pbean.getDetailImgN3();
		%>
		<tr>
			<td>
				<img src = "<%=detailImg_fullPath%>">
			</td>
		</tr>
		<%
	}
	
	if(pbean.getDetailImgN4() != null){
		detailImg_fullPath= request.getContextPath() + "/admin/product_images/" + pbean.getDetailImgN4();
		%>
		<tr>
			<td>
				<img src = "<%=detailImg_fullPath%>">
			</td>
		</tr>
		<%
	}
%>
</table>
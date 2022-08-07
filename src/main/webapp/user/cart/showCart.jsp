<%@page import="java.text.DecimalFormat"%>
<%@page import="cart.CartBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top_user.jsp"%>

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
	#cartTable{
		margin: auto;
		margin-top : 50px;
		text-align: center;
		width: 800px;
	}
	#cartTable p{
		margin : 10px;
	}
	
	#cartTable > caption{
		font-size: 19px;
	}
	
	#cartTable a:hover{
		color : #C2674B;
	}
</style>

<!-- jquery 파일 로드 해주는건 top_user.jsp에 위치하여 생략 -->
<script type="text/javascript">
	
	$(document).ready(function(){
		$('.update').live("click", function(){
			if(isNaN($(this).parent().prev().find('input').val())){
				alert("숫자만 입력 가능합니다.");
				$(this).parent().prev().find('input').select();
				return;
			}
			
			if($(this).parent().prev().find('input').val() == ""){
				alert("숫자를 입력하세요.");
				$(this).parent().prev().find('input').focus();
				return;
			}
			
			var cartItemNum = $(this).parent().parent().parent().find('input:eq(0)').val(); 			
			var qty = $(this).parent().prev().find('input').val();  //수량
			
			location.href="updateCartItem.jsp?cartItemNum=" + cartItemNum + "&qty=" + qty;
		});
		
		
	});
	
	function allCheck(){
		ac = document.f.allcheck;
		rc = document.f.rowcheck;
		
		if (typeof(rc.length)=='undefined') { // 체크박스가 1개일 때 자꾸 오류났는데 이렇게 하니까 해결됨
			if(rc.checked){
				rc.checked = false;	
			}else{
				rc.checked = true;	
			}
		}else{
			if(ac.checked == true){
				for(var i = 0; i<rc.length;i++){
					rc[i].checked = true;
				}
			}else{
				for(var i = 0; i<rc.length;i++){
					rc[i].checked = false;
				}
			}	
		}
	}
	
	function gotoOrder(){
		rc = document.f.rowcheck;
		
		if (typeof(rc.length)=='undefined' && rc.checked) {
			document.f.submit();
			return;
		}
		
		isChecked = false;
		
		for(var i = 0; i<rc.length;i++){
			if(rc[i].checked){
				isChecked = true;
				break;
			}
		}
		
		if(isChecked == false){
			alert("결제할 상품을 선택하세요.");
			return;
		}
		
		document.f.submit();
	}
</script>
<%
	int mno = (int) session.getAttribute("mno");
	CartDao ctdao = CartDao.getInstance();
	ArrayList<CartBean> ctlist = ctdao.getAllItem(mno);
%>
<form name=f action="../orderView.jsp">
	<table id="cartTable">
		<caption>
			<strong>장바구니</strong>
			<hr>
		</caption>
		<tr>
			<td><input type="checkbox" name="allcheck" onClick="allCheck()"></td>
			<td>상품이미지</td>
			<td>상품명</td>
			<td>선택옵션</td>
			<td>단가</td>
			<td>수량</td>
			<td>소계금액</td>
			<td>삭제</td>
		</tr>
		
		<%
		for(CartBean ctbean : ctlist){
		%>
			<tr>	
				<td><input type="checkbox" name="rowcheck" value="<%=ctbean.getNo()%>"></td>
				<%-- <td><%=ctbean.getNo()%></td> --%>
				<%
				String fullPath = request.getContextPath() + "/admin/product_images/" + ctbean.getMainimgn();
				/* System.out.println(fullPath); */
				DecimalFormat decFormat = new DecimalFormat("###,###");
				%>
				<td><img src="<%=fullPath%>" style="width:100px; height:120px"></td>
				<td><%=ctbean.getPname()%></td>
				<td><%=ctbean.getOpname()%></td>
				<td><%=decFormat.format(ctbean.getOneprice())%>원</td>
				<td>
				<p><input type="text" value="<%=ctbean.getQty()%>" style="width: 30px; height: 20px;text-align: center;"></p>
				<p><input type="button" value="수정" class="update" style=" font-size: 5px; text-align: center; "></p>
				</td>
				<td><%=decFormat.format(ctbean.getOneprice()*ctbean.getQty())%>원</td>
				<td><a href="deleteFromCart.jsp?itemno=<%=ctbean.getNo()%>">삭제</a></td>
			</tr>
		<%
		}
		%>
		<tr>
		<% 
		if(ctlist.size() == 0){%>
			<td colspan="8"><br><br>장바구니에 상품이 존재하지 않습니다.</td>	
		<%	
		}
		else{%>
			<td colspan="8"><br><br><input type="button" value="선택상품 주문하기" class="custom-btn" onClick="gotoOrder()" style="width:433px; height:50px"></td>
		<%
		}
		%>
		</tr>
	</table>
</form>


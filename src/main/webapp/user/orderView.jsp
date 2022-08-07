<%@page import="java.text.DecimalFormat"%>
<%@page import="cart.CartBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartDao"%>
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
	#orderTable{
		margin: auto;
		margin-top : 50px;
		text-align: center;
		width: 800px;
	}
	
	#orderTable > caption{
		font-size: 19px;
	}
	
	#deliveryInfoTable{
		margin: auto;
		margin-top : 50px;
		text-align: left;
		width: 800x;
		border-spacing: 0 10px;
	}
	
	#deliveryInfoTable > caption{
		font-size: 19px;
	}
	
	#deliveryInfoTable p{
		margin: 0px;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("input[name='addressInputWay']").change(function(){
			var v = $("input[name='addressInputWay']:checked").val();
			
			if(v == 1){
				<%
				MemberBean mbean = mdao.getMemberById(mid);
				%>
				$("input[name='name']").val("<%=mbean.getName()%>");
				$("input[name='hp1']").val("<%=mbean.getHp1()%>");
				$("input[name='hp2']").val("<%=mbean.getHp2()%>");
				$("input[name='hp3']").val("<%=mbean.getHp3()%>");
				$("input[name='zip']").val("<%=mbean.getZip()%>");
				$("input[name='addr1']").val("<%=mbean.getAddr1()%>");
				$("input[name='addr2']").val("<%=mbean.getAddr2()%>");
				
			}
			else if(v == 2){
				$("input[name='name']").val("");
				$("input[name='hp1']").val("");
				$("input[name='hp2']").val("");
				$("input[name='hp3']").val("");
				$("input[name='zip']").val("");
				$("input[name='addr1']").val("");
				$("input[name='addr2']").val("");
				$("input[name='memo']").val("");
			}	
		}).change();
		
	});
	
	function finishWithPay(){
		if($("input[name='name']").val() == ""){
			alert("받는 분의 성함을 입력해주세요");
			$("input[name='name']").focus();
			return;
		}
		
		if($("input[name='hp1']").val() == ""){
			alert("전화번호를 입력해주세요");
			$("input[name='hp1']").focus();
			return;
		}
		
		if($("input[name='hp2']").val() == ""){
			alert("전화번호를 입력해주세요");
			$("input[name='hp2']").focus();
			return;
		}
		
		if($("input[name='hp3']").val() == ""){
			alert("전화번호를 입력해주세요");
			$("input[name='hp3']").focus();
			return;
		}
		
		if($("input[name='zip']").val() == ""){
			alert("주소를 입력해주세요");
			return;
		}
		
		if($("input[name='addr2']").val() == ""){
			alert("상세주소를 입력해주세요");
			$("input[name='addr2']").focus();
			return;
		}
		
		if(isNaN($("input[name='hp1']").val())){
			alert("전화번호는 숫자만 입력가능합니다.");
			$("input[name='hp1']").select();
			return;
		}
		
		if(isNaN($("input[name='hp2']").val())){
			alert("전화번호는 숫자만 입력가능합니다.");
			$("input[name='hp2']").select();
			return;
		}
		
		if(isNaN($("input[name='hp3']").val())){
			alert("전화번호는 숫자만 입력가능합니다.");
			$("input[name='hp3']").select();
			return;
		}
		
		document.f.submit();
	}
</script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	var newJquery = $.noConflict(true); // 다른 라이브러리랑 겹칠때 이렇게 해주면 됨.
	function openZipSearch() {
		new daum.Postcode({
			oncomplete: function(data) {
				newJquery('[name=zip]').val(data.zonecode); // 우편번호 (5자리)
				newJquery('[name=addr1]').val(data.address);
				newJquery('[name=addr2]').val(data.buildingName);
				newJquery('[name=addr2]').focus();
			}
		}).open();
	}
</script>

<%
	String[] rowcheck = request.getParameterValues("rowcheck");
	CartDao ctdao = CartDao.getInstance();
	int ctno = -1;
	ArrayList<CartBean> ctlist = new ArrayList<CartBean>();
	
	String madedToTheOneRowcheck = "";
	
	if(rowcheck != null){ // 장바구니를 통해 들어왔을 경우
		for(String no: rowcheck){
			ctlist.add(ctdao.getItem(Integer.parseInt(no)));
		}
	
		//다음페이지로 넘길때 rowcheck를 한번 더 사용하기 위해 하나의 문자열로 만듬.
		if(rowcheck.length == 1){
			madedToTheOneRowcheck = rowcheck[0] + ",";	
		}
		else if(rowcheck.length > 1){
			madedToTheOneRowcheck = "" + rowcheck[0];
			for(int i = 1; i< rowcheck.length; i++){
				madedToTheOneRowcheck += "," + rowcheck[i];
			}
		}	
	}	
	else{ // 바로 구매하기 버튼을 눌러 들어온 경우
		ctno = Integer.parseInt(request.getParameter("ctno")); // 장바구니에 담긴 상품의 번호를 들고와야 함.
		ctlist.add(ctdao.getItem(ctno));
	}
%>
<form name=f action="orderProc.jsp">
	<table id="orderTable">
		<caption>
			<strong>결제할 상품 정보</strong>
			<hr>
		</caption>
		<tr>
			<td>상품이미지</td>
			<td>상품명</td>
			<td>선택옵션</td>
			<td>단가</td>
			<td>수량</td>
			<td>소계금액</td>
		</tr>
		
		<%
		DecimalFormat decFormat = new DecimalFormat("###,###");
		int totalPrice = 0;
		for(CartBean ctbean : ctlist){
			totalPrice += ctbean.getOneprice()*ctbean.getQty();
		%>
			<tr>	
				<%-- <td><%=ctbean.getNo()%></td> --%>
				<%
				String fullPath = request.getContextPath() + "/admin/product_images/" + ctbean.getMainimgn();
				/* System.out.println(fullPath); */
				%>
				<td><img src="<%=fullPath%>" style="width:100px; height:120px"></td>
				<td><%=ctbean.getPname()%></td>
				<td><%=ctbean.getOpname()%></td>
				<td><%=decFormat.format(ctbean.getOneprice())%>원</td>
				<td><%=ctbean.getQty()%></td>
				<td><%=decFormat.format(ctbean.getOneprice()*ctbean.getQty())%>원</td>
			</tr>
		<%
		}
		%>
		
		<tr>
			<td colspan="8"> <b>결제하실 총 금액은 총 <%=decFormat.format(totalPrice)%>원 입니다.</b></td>
		</tr>
		
	</table>
	
	<table id="deliveryInfoTable">
		<caption>
		<strong>배송지 정보</strong>
		<hr>
		</caption>
		<tr>
			<td>배송지 선택</td>
			<td><input type="radio" name="addressInputWay" value="1" checked>주문자 정보와 동일 <input type="radio" name="addressInputWay" value="2">새로운 배송지 작성</td>
		</tr>
		<tr>
			<td>받는분 성명</td>
			<td><input type="text" name="name" style="width:140px"></td>
		</tr>
		<tr>
			<td valign="top">연락처</td>
			<td>
				<input type="text" maxlength="3" name="hp1" style="width:30px"> - <input type="text" maxlength="4" name="hp2" style="width:40px"> - <input type="text" maxlength="4" name="hp3" style="width:40px">
			</td>
		</tr>
		<tr>
			<td valign="top">배송지주소</td>
			<td>
				<p><input type="text" name="zip" style="width:60px" readonly> <input type="button" value="우편번호" onclick="openZipSearch()"></p>
				<p><input type="text" name="addr1" style = "margin-top: 10px;" readonly> <input type="text" name="addr2"></p>
			</td>
		</tr>
		<tr>
			<td>배송메모</td>
			<td>
				<input type="text" name="memo" style="width:100%;">
			</td>
		</tr>
		<tr>
			
			<td colspan="8">
				<input type="hidden" name="ctno" value="<%=ctno%>">
				<input type="hidden" name="rowcheck" value="<%=madedToTheOneRowcheck%>">
				<br><input type="button" value="결제하기" class="custom-btn" onClick="finishWithPay()" style="width:433px; height:50px">
			</td>
		</tr>
	</table>
</form>
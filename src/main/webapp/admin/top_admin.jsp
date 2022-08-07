<%@page import="cart.CartDao"%>
<%@page import="member.MemberDao"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style type="text/css">
	body, header {
	    font-size: 17px;
	    line-height: 1.25;
	    font-family: 'Noto Sans KR', AppleGothic, Helvetica, sans-serif;
	}
	
	body{
	    background-color: #FFF;
	}
	
	/* a태그 밑줄 없애기 */
	a{
  		text-decoration: none;
  		color: #1c1c1c;
	}
	
	/* 리스트의 왼쪽 점 없애기 */
	li{
		list-style : none;
	}
	
	/* 마우스 올리면 색깔 변하게 하기 */
	.tmenu > a:hover{
		color : #C2674B;
	}
	
	/* 최상단 헤더--------------*/
	.hd{
		width : 100%;
		background-color: #FFF;
	}
	
	.hd img{
		width : 247px;
	}
	
	.hdRight li{
		float : right;
		margin : 10px;
	}

	.hdRight a{
		font-size: 12px;
	}
	/* ----------------------*/
	
	/* 카테고리가 위치한 헤더-------------- */
	.hd2{
		width: 100%;
		border-top: 1px solid black;
	}
	.hd2 td{
		height : 50px;
	}
	
	.cateWrap, .searchWrap{
		text-align: center;
	}
	
	.tmenu{
		position: relative; /* class = 'depth2'가 absolute 일 때 이것을 부모로 인식하도록 position을 지정해줌*/
		margin: 0px 10px;
	}
	
	/* 카테고리에 마우스 올렸을 때 화면에 뜨는 부분 */
	.depth2{
		position: absolute; /* 다른 요소에 영향을 주지않고 배치시키기 위함  */
		transform: translate(-50%,0%);
		right : 50%; 
		left : 50%;
		top: 100%;
		width: 100px; 
		padding-left: 0px;
		text-align: center;
		padding-top: 10px;
		/* background-color: #FFF; */
		margin-top: 0;
		background-color: #FFF;
		
		/* border : 1px red solid; */
	}
	
	.depth2 li{
		padding : 5px;
		font-size: 13px;
	}
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
 		//카테고리 펼쳐지고 접히기
		jQuery(".tmenu").live("mouseenter", function() {
		   jQuery(this).find(".depth2").slideDown("fast");
		});
		jQuery(".tmenu").live("mouseleave", function() {
		   jQuery(this).find(".depth2").slideUp("fast");
		});
	});
	
	function gotoCart(){
		<%
		if(session.getAttribute("mno") == null){%>
			location.href = "./loginView.jsp";
		<%			
		}
		else{
		%>
			location.href = "<%=request.getContextPath()%>/user/cart/showCart.jsp";	
		<%	
		}
		%>
	}
</script>

<header>
	<table class="hd">
		<tr>
			<td width=33%></td>
			<td width=33% align="center"><a href="<%=request.getContextPath()%>/user/main.jsp" class="hd_logo"><img src="<%=request.getContextPath()%>/images/title.png" style="height:40px; width:230px"></a></td>
			
			<td width=33% align="right">
				<ul class="hdRight">
					<li>
						<a href="javascript:gotoCart()">
						CART<span class="bsCount">(<span id="user_basket_quantity" class="user_basket_quantity">
						<%
						int result = 0;
						if(session.getAttribute("mno") != null){
							int mno = (int)session.getAttribute("mno");
							CartDao ctdao = CartDao.getInstance();
							result = ctdao.countItemInCart(mno);	
						}
						%>
						
						<%=result%>
						
						</span>)</span>
						</a>
					</li>
					
					
					<%
						MemberDao mdao = MemberDao.getInstance();
						
						String mid = (String)session.getAttribute("mid");
						
						if(mid == null){ // 로그인을 하지 않은 상태
						%>
							<li><a href="https://www.jogunshop.com/shop/idinfo.html?type=new&amp;mem_type=person&amp;first=">JOIN</a></li>
							<li><a href="./loginView.jsp">LOGIN</a></li>
						<%							
						}
						else{ // 로그인 상태
							MemberBean mbean = mdao.getMemberById(mid);
							%>
							<li><a href="/shop/member.html?type=mynewmain">MYPAGE</a></li>
							<li><a href="<%=request.getContextPath()%>/user/logoutProc.jsp">LOGOUT</a></li>
							<li><a href="<%=request.getContextPath()%>/user/main.jsp">HOME</a></li>
							<li><a><%=mbean.getName()%>님</a></li>
							<%
						}

					%>
					
					
					<!-- <li><a href="https://www.jogunshop.com/shop/idinfo.html?type=new&amp;mem_type=person&amp;first=">JOIN</a></li>
					<li><a href="/shop/member.html?type=login">LOGIN</a></li> -->
				</ul>
			</td>
		<tr>
	</table>
	
	<!-- <hr> -->
	<table class="hd2">
		<tr>
			<td width="20%"></td>
			<td width="60%">
				<!-- 카테고리 -->
				<div class="cateWrap">   <!-- 절대주소 사용해야함.  -->
					<span class="tmenu"> <a href="<%=request.getContextPath()%>/admin/categoryManage/categoryManage.jsp">카테고리 관리</a>
					</span> 
					
					<span class="tmenu"> 
						<a href="<%=request.getContextPath()%>/admin/productManage/prodList.jsp">상품관리</a>
					</span> 
					
					<span class="tmenu"> 
						<a href="<%=request.getContextPath()%>/admin/orderManage/orderList.jsp">주문내역</a>
					</span> 
					
					<span class="tmenu"> 
						<a href="<%=request.getContextPath()%>/admin/userManage/userList.jsp">회원관리</a>
					</span> 
				</div>
			</td> 
			<td width="20%">
			</td> 
		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>
	</table>
</header>
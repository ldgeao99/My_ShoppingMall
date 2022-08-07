<%@page import="cart.CartDao"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@page import="category.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style type="text/css">
	body, header {
	    font-size: 17px;
	    line-height: 1.25;
	    font-family: 'Noto Sans KR', AppleGothic, Helvetica, sans-serif;
	}
	
	body {
	    background-color: #FFF;
	}
	
	/* a태그 밑줄 없애기 */
	a {
  		text-decoration: none;
  		color: #1c1c1c;
	}
	
	/* 리스트의 왼쪽 점 없애기 */
	li{
		list-style : none;
	}
	
	/* 마우스 올리면 색깔 변하게 하기 */
	.tmenu > a:hover{
		color : gray;
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
	
	.searchWrap{
		height : auto;
		display: flex;
	}
	
	.depth2 li{
		padding : 5px;
		font-size: 13px;
	}
	
	.searchArea li{
		float : left;
		margin : 5px;
	}
	
	.searchspan{
		position: relative; /* class = 'depth2'가 absolute 일 때 이것을 부모로 인식하도록 position을 지정해줌*/
		margin: 0px 0px;
	}
	
	.searchspan input{
		width : 150px;
		border-radius: 8px;
		/* outline: red; */
		border: 1px #979797 solid; 
		background: transparent;
		margin-top: 15px;
	}
	
	.searchspan img{
		position : absolute;
		top: 0px;
	}
	
	
	.searchArea{
		height : auto;
		display: flex; /* 높이가 자동으로 0으로 설정된다면 사용해볼만한 설정 */
	}
	/* ----------------------*/
</style>

<!-- <script type="text/javascript" src="../js/jquery.js"></script> -->

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
							
							<li><a href="./userJoinView.jsp">JOIN</a></li>
							<li><a href="./loginView.jsp">LOGIN</a></li>
						<%							
						}
						else{ // 로그인 상태
							
							MemberBean mbean = mdao.getMemberById(mid);
							
							%>
								
								<li><a href="/shop/member.html?type=mynewmain">MYPAGE</a></li>
								<li><a href="<%=request.getContextPath()%>/user/logoutProc.jsp">LOGOUT</a></li>
							<%
						
							if(mid.equals("admin")){%>
								<li><a href="<%=request.getContextPath()%>/admin/categoryManage/categoryManage.jsp">MANAGE</a></li>
							<%	
							}
							
							%>
							
							<li><a><%=mbean.getName()%>님</a></li>
							
							<%
						}
						
						
						
					%>
					<!-- <li><a href="https://www.jogunshop.com/shop/idinfo.html?type=new&amp;mem_type=person&amp;first=">JOIN</a></li>
					<li><a href="./login/loginView.jsp">LOGIN</a></li> -->
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
				<div class="cateWrap">
					
					<%
						CategoryDao cdao = CategoryDao.getInstance();	
						ArrayList<CategoryBean> clist = cdao.getAllCategory();
							
						String beforeLname = "";
						
						for(int i = 0; i<clist.size() ;i++){
							CategoryBean cbean = clist.get(i);
							
							if(cbean.getSstep() == 1 || cbean.getSname() == null){%>
									</ul>
								</span>
							<% 
							}
							
							if(beforeLname.equals(cbean.getLname()) == false && (cbean.getSstep() == 1 || cbean.getSname() == null) && cbean.getLstep() != 0){// 대분류 명일때
							%>
								<span class="tmenu"> <a href="<%=request.getContextPath()%>/user/showLargeCategory.jsp?lcno=<%=cbean.getLno()%>"><%=cbean.getLname() %></a>
									<ul class="depth2" style="display: none;">
							<%	
							}
							
							if(cbean.getSname() != null){%>
								<li><a href="<%=request.getContextPath()%>/user/showSmallCategory.jsp?scno=<%=cbean.getSno()%>"><%=cbean.getSname() %></a></li>
							<%	
							}

							beforeLname = cbean.getLname();
						}
					
					%>
					
			
					<!-- <span class="tmenu"> 
					<a href="/shop/shopbrand.html?xcode=071&amp;type=P"><font color=#C2674B>BEST</font></a>
					</span> 
					
					<span class="tmenu"> <a href="/shop/shopbrand.html?xcode=078&amp;type=Y">TOP</a>
						<ul class="depth2" style="display: none;">
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=010">반팔티</a></li>
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=003">나시</a></li>
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=002">프린팅티</a></li>
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=011">니트</a></li>
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=009">맨투맨&amp;후드티</a></li>
							<li><a href="/shop/shopbrand.html?xcode=078&amp;type=N&amp;mcode=004">긴팔티</a></li>
						</ul>
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=055&amp;type=Y">SHIRTS</a>
						<ul class="depth2" style="display: none;">
							<li><a
								href="/shop/shopbrand.html?xcode=055&amp;type=N&amp;mcode=004">베이직</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=055&amp;type=N&amp;mcode=006">청남방</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=055&amp;type=N&amp;mcode=005">체크&amp;패턴</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=055&amp;type=N&amp;mcode=003">스트라이프</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=055&amp;type=N&amp;mcode=008">헨리넥&amp;차이나</a></li>
						</ul>
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=081&amp;type=Y">PANTS</a>
						<ul class="depth2" style="display: none;">
							<li><a
								href="/shop/shopbrand.html?xcode=081&amp;type=N&amp;mcode=006">슬랙스</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=081&amp;type=N&amp;mcode=003">면바지</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=081&amp;type=N&amp;mcode=002">청바지</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=081&amp;type=N&amp;mcode=007">밴딩팬츠</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=081&amp;type=N&amp;mcode=004">반바지</a></li>
						</ul>
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=079&amp;type=Y">OUTER</a>
						<ul class="depth2" style="display: none;">
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=004">패딩</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=002">코트</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=006">수트&amp;블레이져</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=010">자켓</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=007">블루종/MA-1</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=005">가디건&amp;조끼</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=079&amp;type=N&amp;mcode=008">후드&amp;집업</a></li>
						</ul>
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=083">SHOES&amp;BAG</a>
						<ul class="depth2" style="display: none;">
							<li><a
								href="/shop/shopbrand.html?xcode=083&amp;type=N&amp;mcode=001">신발</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=083&amp;type=N&amp;mcode=002">가방</a></li>
						</ul>
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=080">ACC</a>
						<ul class="depth2" style="display: none;">
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=005">양말&amp;타이</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=003">모자</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=008">벨트&amp;시계</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=006">머플러&amp;장갑</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=002">안경</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=004">쥬얼리</a></li>
							<li><a
								href="/shop/shopbrand.html?xcode=080&amp;type=N&amp;mcode=007">etc</a></li>
						</ul>
			
					</span> 
					
					<span class="tmenu"> 
						<a href="/shop/shopbrand.html?xcode=076">SALE</a>
					</span> -->
				</div>
			</td> 
			<td width="20%">
				<div class=searchWrap>
					<form action="showSearchResult.jsp" method="post" name="search">
						<span class="searchspan"> 
								<input name="search" onkeydown="CheckKey_search();" value="" class="MS_search_word"> 
								<a href="javascript:search_submit();" class="searhBtn">
								<i class="xi-search"></i>
								</a>
						</span> 
							
						<span class="searchspan"> 				
							<a href="/shop/shopbrand.html"><img src="<%=request.getContextPath()%>/images/btn_search.gif"></a>
						</span>
					</form>
				</div>
			</td> 
		</tr>
	</table>
</header>
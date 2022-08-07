<%@page import="product.ProductBean"%>
<%@page import="product.ProductDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.stock.StockBean"%>
<%@page import="product.stock.StockDao"%>
<%@page import="orderlist.OrderDao"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	request.setCharacterEncoding("UTF-8");
	String ctno = request.getParameter("ctno"); // 바로 결제하기를 통해 넘어왔을 경우만 null이 아님
	String rowcheck = request.getParameter("rowcheck"); // 장바구니 통해서 넘어온 경우만 null이 아님
%>


<jsp:useBean id="mbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mbean"/>

<%	mbean.setNo((int)session.getAttribute("mno"));

	StockDao sdao = StockDao.getInstance();
	CartDao ctdao = CartDao.getInstance();
	ProductDao pdao = ProductDao.getInstance();
	OrderDao odao = OrderDao.getInstance();
	
	
	/* 결제를 진짜로 진행시키기 전에 재고가 결제를 진행시키기에 충분한지 체크 */
	
	boolean isEnoughStcok = true;
	String msg = "";
	
	if(ctno.equals("-1") == true){ // 장바구니를 통해 넘어온 경우 => rowcheck를 모두 이용
		String[] rowcheckArr = rowcheck.split(",");
		for(String no : rowcheckArr){
			//장바구니에 담겨있는 상품의 pno, 옵션 이름, 주문수량을 얻음
			CartBean ctbean = ctdao.getItem(Integer.parseInt(no));
			int pno = ctbean.getPno();
			String opname = ctbean.getOpname();
			int qty = ctbean.getQty();
			
			//상품의 재고데이터를 가져와서 재고가 충분한지 체크함
			ArrayList<StockBean> stlist = sdao.getAllStockByPno(pno);
			for(StockBean stbean : stlist){
				if(opname.equals(stbean.getOpname())){
					ProductBean pbean = pdao.getProduct(pno);
					System.out.println("계산결과");
					System.out.println(stbean.getCount() - qty < 0);
					if(stbean.getCount() - qty < 0){ // (해당 상품의 재고 - 주문할 수량)
						isEnoughStcok = false;
						msg += pbean.getName() + "의 재고부족. ";
						break;
					}
				}
			}
			
			if(isEnoughStcok){
				break;
			}
		}
	}
	else{	// 바로 결제하기를 타고 넘어온 경우 => 1개의 상품이므로 ctno를 바로이용
		
		//장바구니에 담겨있는 상품의 pno, 옵션 이름, 주문수량을 얻음
		CartBean ctbean = ctdao.getItem(Integer.parseInt(ctno));
		int pno = ctbean.getPno();
		String opname = ctbean.getOpname();
		int qty = ctbean.getQty();
		
		//상품의 재고데이터를 가져와서 재고가 충분한지 체크함
		ArrayList<StockBean> stlist = sdao.getAllStockByPno(pno);
		for(StockBean stbean : stlist){
			if(opname.equals(stbean.getOpname())){
				ProductBean pbean = pdao.getProduct(pno);
				System.out.println("계산결과");
				System.out.println(stbean.getCount() - qty < 0);
				if(stbean.getCount() - qty < 0){ // (해당 상품의 재고 - 주문할 수량)
					isEnoughStcok = false;
					msg += pbean.getName() + "의 재고부족. ";
					break;
				}
			}
		}
	}
	
	if(isEnoughStcok){
		//결제를 진행하고, 장바구니에서 해당 상품들을 제거
		if(ctno.equals("-1") == true){ // 장바구니를 통해 넘어온 경우 => rowcheck를 모두 이용
			String[] rowcheckArr = rowcheck.split(","); //rowcheck 파싱
			for(String no : rowcheckArr){
				CartBean ctbean = ctdao.getItem(Integer.parseInt(no));
				odao.insertOrder(ctbean, mbean);
				sdao.updateByOrder(ctbean.getPno(), ctbean.getOpname(), ctbean.getQty());//해당 상품의 재고수량 update
			}
			
			// 주문이 완료된 상품은 장바구니에서 제거
			for(String no : rowcheckArr){
				ctdao.deleteItem((Integer.parseInt(no))); 
			}
			
			msg = "주문성공";
			
		}else{	// 바로 결제하기를 타고 넘어온 경우 => 1개의 상품이므로 ctno를 바로이용
			CartBean ctbean = ctdao.getItem(Integer.parseInt(ctno)); // 상품정보를 얻음.
			odao.insertOrder(ctbean, mbean);
			sdao.updateByOrder(ctbean.getPno(), ctbean.getOpname(), ctbean.getQty()); //해당 상품의 재고수량 update
			ctdao.deleteItem(Integer.parseInt(ctno));// 주문이 완료된 상품은 장바구니에서 제거
			
			msg = "주문성공";
		}
	}
%>

<script>
	alert("<%=msg%>");
	location.href = "main.jsp";
</script>
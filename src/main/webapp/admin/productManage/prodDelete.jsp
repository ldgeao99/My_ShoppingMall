<%@page import="product.stock.StockDao"%>
<%@page import="java.io.File"%>
<%@page import="product.ProductBean"%>
<%@page import="product.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String msg = "";
	int pno = Integer.parseInt(request.getParameter("pno"));

	ProductDao pdao = ProductDao.getInstance();
	ProductBean pbean = pdao.getProduct(pno);
	
	/* 존재하는 사진부터 지우기 */

	String targetLocation = config.getServletContext().getRealPath("/admin/product_images"); 
	
	if(pbean.getMainImgN() != null){
		File delFile = new File(targetLocation, pbean.getMainImgN());
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}
	}

	if(pbean.getDetailImgN1() != null){
		File delFile = new File(targetLocation, pbean.getDetailImgN1());
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}
	}
	
	if(pbean.getDetailImgN2() != null){
		File delFile = new File(targetLocation, pbean.getDetailImgN2());
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}

	if(pbean.getDetailImgN3() != null){
		File delFile = new File(targetLocation, pbean.getDetailImgN3());
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}
	
	if(pbean.getDetailImgN4() != null){
		File delFile = new File(targetLocation, pbean.getDetailImgN4());
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}
	
	
	/* DB에서 해당 행 지우기 */
	int cnt = pdao.deleteProduct(pno);
	
	/* 사이즈에서 해당 테이블 지우기 */
	StockDao sdao = StockDao.getInstance();
	int cnt2 = sdao.deleteAllStock(pno);
%>

<script>
	location.href = "prodList.jsp";
</script>
<%@page import="java.io.File"%>
<%@page import="product.stock.StockDao"%>
<%@page import="product.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="category.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%  /* 파일 업로드 */
	// 1. 웹서버 내에서 저장될 위치를 지정하기 위해, jsp의 내장객체 config를 이용해서 웹서버 내에서 특정 위치의 경로를 생성
	String targetLocation = config.getServletContext().getRealPath("/admin/product_images");
	//System.out.println(targetLocation);
	
	// 2. 최대 업로드 가능 사이즈를 지정 및 인코딩 방식 지정
	int maxSize = 1024 * 1024 * 10; 	// 5메가
	String encType = "UTF-8"; 		// 한글이 안깨지도록
	
	// 3. 웹서버 폴더 내의 targetLocation 경로로 업로드 실행(객체 생성 = 업로드 실행임) 
	//MultipartRequest multi = new MultipartRequest(request, targetLocation, maxSize, encType);
	MultipartRequest multi = new MultipartRequest(request, targetLocation, maxSize, encType, new DefaultFileRenamePolicy());
	
	/* form에서 요청한 정보를 가져오는 방법(바로 위에서 만든 객체를 이용함, 파일 업로드를 위해 넘어온 경우에는 request 내장 객체로 접근 불가) */
	
	/* 
	int lno = Integer.parseInt(multi.getParameter("selLargeCategory"));
	int sno = Integer.parseInt(multi.getParameter("selSmallCategory"));
	String name = multi.getParameter("name");
	int oriprice = Integer.parseInt(multi.getParameter("oriprice"));
	int discprice = Integer.parseInt(multi.getParameter("discprice"));	
	String info = multi.getParameter("info");
	
	String mainImgN = multi.getFilesystemName("mainImg");
	String detailImgN1 = multi.getFilesystemName("detailImg1");
	String detailImgN2 = multi.getFilesystemName("detailImg2");
	String detailImgN3 = multi.getFilesystemName("detailImg3");
	String detailImgN4 = multi.getFilesystemName("detailImg4");
	
	System.out.println(lno);
	System.out.println(sno);
	System.out.println(name);
	System.out.println(oriprice);
	System.out.println(discprice);
	System.out.println(info);
	
	System.out.println(mainImgN);
	System.out.println(detailImgN1);
	System.out.println(detailImgN2);
	System.out.println(detailImgN3);
	System.out.println(detailImgN4);
	 */
	 
	/* DB에서의 수정 */
	ProductDao pdao = ProductDao.getInstance();
	int cnt1 = pdao.updateProduct(multi);
	if(cnt1 > 0){
		System.out.println("상품 수정 완료");
	}else{
		System.out.println("상품 수정 실패");
	} 
	
	
	/* 이전과 달라진 부분이 있다면 존재하던 사진 파일 삭제 */	
	String beforeMainImg = multi.getParameter("beforeMainImg");
	String beforeImg1 = multi.getParameter("beforeImg1");
	String beforeImg2 = multi.getParameter("beforeImg2");
	String beforeImg3 = multi.getParameter("beforeImg3");
	String beforeImg4 = multi.getParameter("beforeImg4");
	
	String mainImgN = multi.getFilesystemName("mainImg");
	String detailImgN1 = multi.getFilesystemName("detailImg1");
	String detailImgN2 = multi.getFilesystemName("detailImg2");
	String detailImgN3 = multi.getFilesystemName("detailImg3");
	String detailImgN4 = multi.getFilesystemName("detailImg4");
	
	
	if(beforeMainImg != null && mainImgN !=  null){
		File delFile = new File(targetLocation, beforeMainImg);
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}
	
	if(beforeImg1 != null && detailImgN1 !=  null){
		File delFile = new File(targetLocation, beforeImg1);
		System.out.println("삭제시도:" + beforeMainImg);
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}
	
	if(beforeImg2 != null && detailImgN2 !=  null){
		File delFile = new File(targetLocation, beforeImg2);

		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}	
	
	if(beforeImg3 != null && detailImgN3 !=  null){
		File delFile = new File(targetLocation, beforeImg3);
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}	
	
	if(beforeImg4 != null && detailImgN4 !=  null){
		File delFile = new File(targetLocation, beforeImg4);
		
		boolean isSuccessed = false;
		
		if(delFile.exists()){ // true, false
			
			isSuccessed = delFile.delete(); // 파일 삭제
		}	
	}
	
	String haveToBedelete = multi.getParameter("haveToBedelete");
	String[] arr = haveToBedelete.split(",");
	
	for(String s : arr){
		if(s != null){
			File delFile = new File(targetLocation, s);
			if(delFile.exists()){ // true, false
				delFile.delete(); // 파일 삭제
			}	
		}
	}
	
	StockDao sdao = StockDao.getInstance();
	//재고 전부 delete.
	int cnt2 = sdao.deleteAllStock(Integer.parseInt(multi.getParameter("pno")));
	if(cnt2 > 0){
		System.out.println("재고 재삽입전 전부 삭제완료");
	}else{
		System.out.println("재고 재삽입전 전부 삭제실패");
	}
	
	/* 재고삽입 수정후에 하는 재고 삽입은 따로 이를 위한 함수를 만들어주자.*/
	
	int cnt3 = sdao.insertStockForUpdate(multi);
	
	if(cnt3 > 0){
		System.out.println("재고 재삽입 완료");
	}else{
		System.out.println("재고 재삽입 실패");
	}
%>

<script>
	location.href="prodList.jsp";
</script>

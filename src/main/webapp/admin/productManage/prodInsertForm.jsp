<%@page import="category.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="category.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="../top_admin.jsp"%> 
 
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
	var opcount = 1; // 전달할 추가한 옵션의 개수(최소는 1개)
	var opArr = [];
	opArr.push(1);
	
	$(document).ready(function(){
		$("select[name='selLargeCategory']").change(function(){
			var choicedNo = $(this).val(); // 선택된 것의 lno 값
		
			$.ajax({
				url : "returnSCategory.jsp",
				dataType : "json",
				data :{
					lno : choicedNo
				},
				success : function(responseData){		
					
					var len =Object.keys(responseData.ITEMS).length;
					var temp = "<option value='-1'>소분류 생략</option>";
					
					for(i = 0; i < len ; i++){
						temp += "<option value=" + JSON.stringify(responseData.ITEMS[i].sno) + ">" + (JSON.stringify(responseData.ITEMS[i].sname)).replace(/"/g,"") + "</option>"			
					}
					if(len == 0){
						$("select[name='selSmallCategory']").html("<option value='-1'>소분류가 존재하지 않습니다</option>");
						//$("select[name='selSmallCategory']").parent().parent().hide();
					}else{
						$("select[name='selSmallCategory']").parent().parent().show();
						$("select[name='selSmallCategory']").html(temp);
					}
				}
			});
		});
		
		$('#optionAdd').live("click", function(){
			$(this).parent().append("<span><input type='text' value='' size='5' name='opn_" + (++opcount) + "'> <input type='text' value='' size='5' name='stock_" + opcount +"'> <input type='button' value='-' class='deleteopt'> <br></span>");
			opArr.push(opcount);
		});
		
		
		$('.deleteopt').live("click", function(){
			//name속성 뒤에 붙은 값을 분리해서 이걸 배열에서 제거하자.
			var temp = $(this).prev().attr("name"); // stock_2
			var tempArr = temp.split('_');
			//alert(tempArr[1] + "삭제");
			for(var i = 0; i < opArr.length; i++) {
				  if(opArr[i] == tempArr[1])  {
					  opArr.splice(i, 1);
				    i--;
				    break;
				  }
			}
			//alert(opArr);
			//alert($(this).parent().prev().children().attr("name"));
			
			$(this).parent().remove();
		});
	});
	
	function check(){
		if($("select[name='selLargeCategory']").val() == "선택안함"){
			alert("대분류를 선택해주세요");
			return false;
		}
		
		if($("input[name='name']").val() == ""){
			alert("상품명을 입력해주세요");
			return false;
		}
		
		if($("input[name='oriprice']").val() == ""){
			alert("정가를 입력해주세요");
			return false;
		}
		
		if($("input[name='discprice']").val() == ""){
			alert("할인가를 입력해주세요");
			return false;
		}
		

		
		if(isNaN($("input[name='stock_1']").val())){
			alert("재고는 숫자만 입력 가능합니다.");
			return false;
		}
		
		//alert(opcount);
		var temp = "";
		
		for(var i = 0; i < opArr.length; i++){
			temp += opArr[i] + ",";
		}
		document.f.opnums.value = temp;
		//alert(temp);
		//alert(document.f.opnums.value);
		//return false;
		
		//null로 보내면 안되므로
		//alert($("select[name='selSmallCategory']").val());
		
		
		for(var i = 0; i<opArr.length; i++){
			if($("input[name='opn_"+ opArr[i] +"']").val() == ""){
				alert("빈칸없이 옵션명을 입력해야 합니다.");
				$("input[name='opn_"+ opArr[i] +"']").focus();
				return false;
			}
			
			if($("input[name='stock_"+ opArr[i] +"']").val() == ""){
				alert("빈칸없이 재고수량을 입력해야 합니다.");
				$("input[name='stock_"+ opArr[i] +"']").focus();
				return false;	
			}
			
			if(isNaN($("input[name='stock_"+ opArr[i] +"']").val())){
				alert("재고수량은 숫자만 입력가능합니다.");
				$("input[name='stock_"+ opArr[i] +"']").focus().select();
				return false;
			}	
		}
		
		
		
		document.f.submit();
	}
</script>
 
<style type="text/css">
	#producRegister{
		margin : auto;
		/* border : 1px solid black; */
	}
	
	#producRegister > caption{
		font-size: 19px;
	}
	
	#t2{
		width : 250px;
	}
	textarea{
		resize: none; 
		width: 100%; 
		height:70px;
	}
</style>


<%
	CategoryDao cdao = CategoryDao.getInstance();
	ArrayList<CategoryBean> lcateList = cdao.getOnlyLargeCategory();
%>

<form name="f" action="prodInsertProc.jsp" method="post" enctype="multipart/form-data">
	<table id="producRegister">
		<caption>
				<strong>상품등록</strong>
				<hr>
		</caption>
		<tr>
		 	<td>대분류</td>
		 	<td>
		 		<select name="selLargeCategory">
		 			<option value="선택안함" selected>선택안함</option>
		 			<% 
		 			for(CategoryBean cbean : lcateList){
		 				if(cbean.getLno() != -1){
		 			%>
		 				<option value="<%=cbean.getLno()%>"><%=cbean.getLname()%></option>
		 			<%
		 				}
		 			}
		 			%>
		 		</select>	 	
		 	</td>
		 <tr>
		 
		 <tr>
		 	<td>소분류</td>
		 	<td>
		 		<select name="selSmallCategory">
		 			<option value="선택안함">대분류를 먼저 선택해주세요</option>
		 		</select>	 	
		 	</td>
		 <tr>
		 <tr>
		 	<td>이름</td>
		 	<td><input type="text" name="name" value="미니룩데이 베이지 스커트"></td>
		 </tr>
		 <tr>
		 	<td>정가</td>
		 	<td><input type="text" name="oriprice" value="5000"></td>
		 </tr>
		 <tr>
		 	<td>할인판매가</td>
		 	<td><input type="text" name="discprice" value="3000"></td>
		 </tr>
		 <tr>
		 	<td>상품설명</td>
		 	<td>
		 		<textarea name="info">여리한 A 라인 실루엣에 플리츠 주름 잡힌 디자인으로 매력을 더한 미니스커트에요! 쫀쫀한 텐션이 느껴지는 소재와 후면 밴딩으로 편안하게 착용되어 소장 가치 높은 아이템이랍니다.</textarea>
			</td>
		 </tr>
		 <tr>
		 	<td>상품이미지</td>
		 	<td><input type="file" name="mainImg"></td>
		 </tr>
		 <tr>
		 	<td>설명이미지1</td>
		 	<td><input type="file" name="detailImg1"></td>
		 </tr>
		 <tr>
		 	<td>설명이미지2</td>
		 	<td><input type="file" name="detailImg2"></td>
		 </tr>
		 <tr>
		 	<td>설명이미지3</td>
		 	<td><input type="file" name="detailImg3"></td>
		 </tr>
		  <tr>
		 	<td>설명이미지4</td>
		 	<td><input type="file" name="detailImg4"></td>
		 </tr>
		 
		  <tr>
		 	<td colspan="2"><hr></td>
		 </tr>
		 
		 <tr border="1">
		 	<td>
		 	옵션/재고
		 	</td>
		 	<td> 
				<input type="button" value="추가" id="optionAdd">	<br>	<br>
				<span><input type='text' value='S' size='5' placeholder='사이즈 등' name="opn_1"> <input type='text' value='10' size='5' placeholder='재고수량' name="stock_1"><br></span>	

		 	</td>
		 <tr>
		 
		 <tr >
		 	<td colspan="2" align="center">
		 		<input type="hidden" value="" name="opnums">
		 		<input type="button" value="상품등록" onClick="check()">
		 		<input type="button" value="취소" onClick="location.href='prodList.jsp'">
		 	</td>
		 </tr>
	</table>
</form>
 


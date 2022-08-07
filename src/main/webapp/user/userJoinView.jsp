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
	
	#userJoinTable{
		margin: auto;
		margin-top : 100px;
		text-align: left;
		width: 800x;
		border-spacing: 0 10px;
	}
	
	#userJoinTable > caption{
		font-size: 19px;
	}
	
	#userJoinTable p{
		margin: 0px;
	}
</style>

<script type="text/javascript">

	var idUsable = "";  // null, POSSIBLE, IMPOSSIBLE
	
	$(document).ready(function(){
		//alert(1);
		
		//중복체크 버튼을 클릭했을 때
		$('#id_check').click(function(){
			
			if($('input[name="id"]').val().length == 0){
				alert("아이디를 입력하세요");
				return;
			}
			else{
				$.ajax({ // 요청 자체를 화면을 이동하거나 하지 않으면서 할 수 있다는 장점이 있음
					url : "id_check_proc.jsp", //어디가서 처리결과를 가져올 건지 url을  지정
					data : {
						// 요청시 넘겨줄 데이터를 여기에 작성할 수 있음
						// 왼쪽에 위치한 변수는 내가 임의로 명명 가능
						// 이후에 id_check_proc.jsp 에서 request.getParameter("userid") 로 접근가능 
						id : $('input[name="id"]').val() // 사용자가 입력한 id
					},
					success : function(responseData){ // 인자에는  : 응답정보가 오는데 id_check_proc.jsp의 실행 결과가 넘어옴. 주석같은 것도 날라오기 때문에 id_check_proc.jsp 에서는 주석을 달면 안됨
						//alert('data: ' + $.trim(responseData)); 
						idUsable = $.trim(responseData);
						
						if($.trim(responseData) == 'POSSIBLE'){ // 앞뒤에 붙은 공백을 제거해주고 비교해야 함. 					
							$('#id_message').html("<font color=blue>사용 가능합니다.</font>");
							$('#id_message').show(); // 아래서 css('display', 'none') 한걸 다시 보이게 해줘야 함.
						}else{
							$('#id_message').html("<font color=red>이미 사용중인 아이디</font>");
							$('#id_message').show();
						}
					}//success
				});//ajax	
			} // else
		});//중복체크 클릭의 끝
		
		
		$('input[name="id"]').keydown(function(){ //키보드가 한번이라도 눌리면 발생하는 이벤트 처리
			$('#id_message').css('display', 'none'); // 키가 눌렸을 때 안보이게.
			isChanged = true;
			ues=""; // 새로운 데이터의 입력이 들어오면 상태 초기화
		});
		
	});//ready
	
	function gotoRegisterProc(){
		
		if($('input[name="id"]').val() == ""){
			alert("아이디를 입력하세요");
			$('input[name="id"]').focus();
			return;
		}
		
		if($('input[name="password"]').val() == ""){
			alert("비밀번호를 입력하세요");	
			$('input[name="password"]').focus();
			return;
		}
		
		if($('input[name="re_password"]').val() == ""){
			alert("비밀번호 확인을 입력하세요");	
			$('input[name="re_password"]').focus();
			return;
		}
		
		if($('input[name="password"]').val() != $('input[name="re_password"]').val()){
			alert("비밀번호가 일치하지 않습니다.");		
			return;
		}
		
		if($('input[name="name"]').val() == ""){
			alert("이름을 입력하세요");		
			$('input[name="name"]').focus();
			return;
		}
		
		if($('input[name="rrn1"]').val() == ""){
			alert("주민등록번호를 입력하세요");	
			$('input[name="rrn1"]').focus();
			return;
		}
		
		if($('input[name="rrn2"]').val() == ""){
			alert("주민등록번호를 입력하세요");	
			$('input[name="rrn2"]').focus();
			return;
		}
		
		if( isNaN($('input[name="rrn1"]').val())){
			alert("주민등록번호는 숫자만 입력 가능합니다");
			$('input[name="rrn1"]').select();
			return;
		}
		
		if( isNaN($('input[name="rrn2"]').val())){
			alert("주민등록번호는 숫자만 입력 가능합니다");
			$('input[name="rrn2"]').select();
			return;
		}
		
		if($('input[name="hp1"]').val() == ""){
			alert("전화번호를 입력하세요");	
			$('input[name="hp1"]').focus();
			return;
		}
		
		if($('input[name="hp2"]').val() == ""){
			alert("전화번호를 입력하세요");	
			$('input[name="hp2"]').focus();
			return;
		}
		
		if($('input[name="hp3"]').val() == ""){
			alert("전화번호를 입력하세요");	
			$('input[name="hp3"]').focus();
			return;
		}
		
		if( isNaN($('input[name="hp1"]').val())){
			alert("전화번호는 숫자만 입력 가능합니다");
			$('input[name="hp1"]').select();
			return;
		}
		
		if( isNaN($('input[name="hp2"]').val())){
			alert("전화번호는 숫자만 입력 가능합니다");
			$('input[name="hp2"]').select();
			return;
		}
		
		if( isNaN($('input[name="hp3"]').val())){
			alert("전화번호는 숫자만 입력 가능합니다");
			$('input[name="hp3"]').select();
			return;
		}
		
		if($('input[name="zip"]').val() == ""){
			alert("주소를 입력하세요");	
			return;
		}
		
		if($('input[name="addr2"]').val() == ""){
			alert("상세주소를 입력하세요");	
			$('input[name="addr2"]').focus();
			return;
		}
		
		if(idUsable == ""){
			alert("아이디 중복체크를 수행해주세요");
			return;
		}
		
		if(idUsable == "IMPOSSIBLE"){
			alert("아이디 중복여부를 확인하세요");
			return;
		}
		
		var reg = /^[a-zA-Z0-9]{3,10}$/;
		
		var tempId = $('input[name="id"]').val();
		if(tempId.search(reg) == -1){
			alert("아이디는 3~10자의 영문, 숫자만 가능합니다");
			return;
		}
		
		var tempPw = $('input[name="password"]').val();
		if(tempPw.search(reg) == -1){
			alert("비밀번호는 3~10자의 영문, 숫자만 가능합니다");
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

<form name=f action="./userJoinProc.jsp" method="post">
	<table id="userJoinTable">
		<caption>
		SIGN UP
		<hr>
		</caption>
		<tr>
			<td><b>아이디</b></td>
			<td><input type="text" name="id" style="width:150px" maxlength="10" placeholder="3~10자의 영문, 숫자"> 
				<input type="button" id="id_check" value="중복체크" style="height :22px;">
				<span id="id_message" style="font-size:13px"></span>
			</td>
		</tr>
		<tr>
			<td><b>비밀번호</b></td>
			<td><input type="password" name="password" maxlength="8" style="width:150px" placeholder="3~10자의 영문, 숫자"></td>
		</tr>
		<tr>
			<td><b>비밀번호 확인</b></td>
			<td><input type="password" name="re_password" maxlength="8" style="width:150px"></td>
		</tr>
		<tr>
			<td><b>성명</b></td>
			<td><input type="text" name="name" style="width:150px"></td>
		</tr>
		<tr>
			<td><b>주민등록번호</b></td>
			<td><input type="text" maxlength="6" name="rrn1" style="width:60px"> - <input type="text" maxlength="7" name="rrn2" style="width:70px"></td>
		</tr>
		<tr>
			<td valign="top"><b>연락처</b></td>
			<td>
				<input type="text" maxlength="3" name="hp1" style="width:30px"> - <input type="text" maxlength="4" name="hp2" style="width:40px"> - <input type="text" maxlength="4" name="hp3" style="width:40px">
			</td>
		</tr>
		<tr>
			<td valign="top"><b>주소</b></td>
			<td>
				<p><input type="text" name="zip" style="width:60px" readonly> <input type="button" value="우편번호" onclick="openZipSearch()"></p>
				<p><input type="text" name="addr1" style = "margin-top: 10px;" readonly> <input type="text" name="addr2"></p>
			</td>
		</tr>
		<tr>
			<td colspan="8"><br><input type="button" value="회원가입" class="custom-btn" onClick="gotoRegisterProc()" style="width:100%; height:50px"></td>
		</tr>
	</table>
</form>
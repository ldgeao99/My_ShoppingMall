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
	  width: 100%;
	}
</style>

<style type="text/css">
	#loginform {
		margin-top: 250px;		
	}
	
	#loginTable{
		width : 270px;
		height : 120px;
		text-align: center;
		border-spacing: 0 10px;
	}
</style>

<script type="text/javascript">
	function checkForm(){
		//alert("asada");
		
		if(document.myform.id.value == ""){
			alert("아이디를 입력하세요");
			return false;
		}
		
		if(document.myform.password.value == ""){
			alert("비밀번호를 입력하세요");
			return false;
		}
	}
</script>

<form id="loginform" name="myform" action="loginProc.jsp" method="post" onsubmit="return checkForm();">
	<table  align="center" id="loginTable">
		<tr>
			<td colspan="2">
				<font style="font-size: 19px">LOGIN</font>
				<hr>
			</td>
		</tr>
		<tr>
			<td align="left" width="30%"><b>아이디</b></td>
			<td><input type="text" name="id" value="" style="width:100%"></td> <!-- admin, 1234 -->
		</tr>
		<tr>
			<td align="left"><b>비밀번호</b></td>
			<td><input type="password" name="password" value="" style="width:100%"></td>
		</tr>
		
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="로그인" class="custom-btn">		
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 12px;">
				<hr>
				<a href="<%=request.getContextPath()%>/user/userJoinView.jsp">회원가입</a> | <a href="#">아이디찾기</a> | <a href="#">비밀번호찾기</a>
				<%-- <input type="button" value="회원 가입" onClick="location.href='<%=request.getContextPath()%>/myshop/member/register.jsp'">		<!-- './myshop/member/register.jsp' 도 가능 -->				
				<input type="button" value="아이디 찾기" onClick="location.href='<%=request.getContextPath()%>/findid.jsp'">				
				<input type="button" value="비번 찾기" onClick="location.href='<%=request.getContextPath()%>/findpw.jsp'"> --%>
			</td>
		</tr>
	</table>
</form>
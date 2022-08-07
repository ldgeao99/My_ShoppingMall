
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- loginView.jsp -> loginProc.jsp -->

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	MemberDao mdao = MemberDao.getInstance();
	MemberBean mbean = mdao.getMemberByInfo(id, password); 
	
	String viewPage = "";
	
	if(mbean != null){ // 회원이면
		String mid = mbean.getId();
		int mno = mbean.getNo();
		
		/* 세션에 아이디와 이름 저장 */
		session.setAttribute("mid", mid);
		session.setAttribute("mno", mno);
		
		if(mid.equals("admin")){	// 관리자일 때 
			viewPage = request.getContextPath() + "/admin/categoryManage/categoryManage.jsp";
		}else{ 						// 일반 회원일 때
			viewPage = request.getContextPath() + "/user/main.jsp";	
		}
	}else{ // 비회원이면
		viewPage = request.getContextPath() + "/user/loginView.jsp"; // 로그인 화면
		%>
		<script type="text/javascript">
			alert("존재하지 않는 회원입니다.");
		</script>
		<%
	}
%>

<script type="text/javascript">
	location.href = "<%=viewPage%>";
</script>
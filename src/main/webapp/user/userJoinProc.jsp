<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
	
	MemberDao mdao = MemberDao.getInstance();
%>	
	
<jsp:useBean id="mbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mbean"/>

<%
	int cnt = mdao.insertMember(mbean); // DB에 회원등록
	
	String url = "";

	if(cnt > 0){
		url = "main.jsp";
		MemberBean mbean2 = mdao.getMemberById(mbean.getId());
		
		System.out.println("here" + mbean2.getId());
		System.out.println("here" + mbean2.getNo());
		session.setAttribute("mid", mbean2.getId());
		session.setAttribute("mno", mbean2.getNo());
		%>
		<script>
			alert("<%=mbean.getName()%>님, " + "회원이 되신걸 환영합니다.");
			location.href = "<%=url%>";
		</script>
		<%
	}
	else{		
	}
%>




<%-- 
id: <%=mbean.getId() %><br>
password: <%=mbean.getPassword() %><br>
name: <%=mbean.getName() %> <br>
rrn1: <%=mbean.getRrn1() %><br>
rrn2: <%=mbean.getRrn2() %><br>
hp1: <%=mbean.getHp1() %><br>
hp2: <%=mbean.getHp2() %><br>
hp3:<%=mbean.getHp3() %><br>
zip: <%=mbean.getZip() %><br>
addr1: <%=mbean.getAddr1() %> <br>
addr2: <%=mbean.getAddr2() %> <br> --%>
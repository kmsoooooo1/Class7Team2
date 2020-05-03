<%@page import="team2.member.db.MemberDAO"%>
<%@page import="team2.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	   로그인한 사용자의 경우 사용자 ID를 출력,
	   로그인X 사용자의 경우 로그인페이지로 이동 	   
	 -->
	 <%
	   // 세션정보(ID값 가져오기)
	   String id = (String)session.getAttribute("id");
	   // 로그인 유무 판단 처리 
	   
	   if(id == null){
		  response.sendRedirect("./MemberLogin.me");   
	   }   
	   MemberDAO mdao = new MemberDAO();
	   MemberDTO mdto = mdao.getMember(id);
	 %>
	
	<h3>환영합니다. <%=mdto.getName() %> 회원님!</h3> 
	
	<a href="./MemberInfo.me">회원 정보 조회</a>
	<a href="./MemberUpdate.me">회원정보 수정</a>
	<a href="./MemberDelete.me">회원탈퇴</a>
	
	<hr>
	<a href="">주문내역</a>
	<a href="./BasketList.ba">장바구니</a>
	<a href="">내 게시글</a>
	
	

</body>
</html>
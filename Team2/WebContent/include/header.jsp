<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<a href="./Main.me" id="logo"> 갈라파고스(로고) </a>
		<%
			request.setCharacterEncoding("UTF-8");
			
			//로그인 되었는지
			String id = (String) session.getAttribute("id");
			if(id == null){	
		%>
			<a href="./Main.ad"> 관리자 페이지(임시) </a>
			<a href="./MemberJoin.me"> 회원가입 </a>
			<a href="./MemberLogin.me"> 로그인 </a>
		<% }else if(id.equals("admin")) { %>
			<a href="./Main.ad"> 관리자 페이지 </a>
			<a href=""> 로그아웃 </a>
		<% }else{ %>
			<a href=""> 로그아웃 </a>
		<% } %> 
	</div>
</body>
</html>
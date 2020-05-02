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
			<a href="./MemberJoin.me"> 회원가입 </a>
			<a href="./MemberLogin.me"> 로그인 </a>
		<% }else if(id.equals("admin")) { %>
			<a href="./Main.ad"> 관리자 페이지 </a>
			<a href="./MemberLogout.me"> 로그아웃 </a>
		<% }else{ %>
			<a href="./MemberPage.me"> 마이 페이지 </a>
			<a href="./MemberLogout.me"> 로그아웃 </a>
		<% } %> 
	</div>
	
	<a href="./notice.bo?category=notice">공지사항</a>
	<a href="./review.bo?category=review">상품후기</a>
	
	<!-- 메인 메뉴 -->
	<div>
		<ul>
			<li> <a href="./AnimalList.an?category=파충류"> 파충류 </a>
				<ul>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=게코 도마뱀"> 게코 도마뱀 </a> </li>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=뱀"> 뱀 </a> </li>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=거북"> 거북 </a> </li>
				</ul>
			</li>
			<li> <a href="./AnimalList.an?category=양서류"> 양서류 </a>
				<ul>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=프로그"> 프로그 </a> </li>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=살라맨더"> 살라맨더 </a> </li>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=팩맨"> 팩맨 </a> </li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>
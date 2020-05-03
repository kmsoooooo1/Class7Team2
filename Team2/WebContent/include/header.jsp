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
	
	<a href="./BoardList.bo?category=0">공지사항</a>
	<a href="./BoardList.bo?category=1">상품후기</a>
	
	<!-- 메인 메뉴 -->
	<div>
		<ul>
			<li> <a href="./AnimalList.an?category=파충류&sub_category=도마뱀"> 도마뱀 </a>
				<ul>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=리자드/모니터"> 리자드/모니터 </a> </li>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=레오파드 게코"> 레오파드 게코 </a> </li>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=크레스티드 게코"> 크레스티드 게코 </a> </li>
					<li> <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=카멜레온"> 카멜레온 </a> </li>
				</ul>
			</li>
			<li> <a href="./AnimalList.an?category=파충류&sub_category=뱀"> 뱀 </a> </li>
			
			<li> <a href="./AnimalList.an?category=파충류&sub_category=거북"> 거북 </a> </li>
			
			
			<li> <a href="./AnimalList.an?category=양서류"> 양서류 </a>
				<ul>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=프로그"> 프로그 </a> </li>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=살라맨더"> 살라맨더 </a> </li>
					<li> <a href="./AnimalList.an?category=양서류&sub_category=팩맨"> 팩맨 </a> </li>
				</ul>
			</li>
			
			<li> <a href="#"> 먹이 </a>
				<ul>
					<li><a href="#"> 생먹이 </a></li>
					<li><a href="#"> 냉동먹이 </a></li>
					<li><a href="#"> 인공사료 </a></li>
					<li><a href="#"> 칼슘/약품 </a></li>
				</ul>
			</li>
			
			<li> <a href="#"> 사육용품 </a>
				<ul>
					<li><a href="#"> 사육장 </a></li>
					<li><a href="#"> 장식/그릇 </a></li>
					<li><a href="#"> 램프 </a></li>
					<li><a href="#"> 바닥재 </a></li>
					<li><a href="#"> 온/습도 관련 </a></li>
					<li><a href="#"> 보조용품 </a></li>
					<li><a href="#"> 수족관 </a></li>
				</ul>
			</li>
		</ul>
	</div>
	
	<hr>
</body>
</html>
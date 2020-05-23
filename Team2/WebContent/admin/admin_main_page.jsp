<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/admin.css?ver=2" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 메인 페이지</title>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<div class="container">
	<div class="contents">
	<h2>관리자 메인페이지</h2>
		<!-- 관리자 동물 파트 -->
		<table border="1" class="admintable">
		<colgroup>
			<col style="width:20%;">
			<col style="width: auto;">
		</colgroup>
		<tr>
			<th> 동물 파트 </th>
			<td><a href="./AnimalList.aa?category=all"> 모든 동물 리스트 </a>
			<a href="./AnimalAdd.aa">동물 추가하기</a>
			<a href="./AnimalNew.aa">동물 신상리스트</a></td>
		</tr>
		<!-- 관리자 상품 파트 -->
		<tr>
			<th> 상품 파트 </th>
			<td><a href="./GoodsList.ag?category=all"> 모든 상품 리스트 </a>
			<a href="./GoodsAdd.ag">사육용품 추가하기</a></td>
		</tr>
		<!-- 관리자 멤버 파트 -->
		<tr>
			<th> 멤버 파트 </th>
			<td><a href="./MemberList.me">회원 리스트 보기</a>
			<a href="https://center-pf.kakao.com/_iLxlxexb/chats">카카오 상담 내역보기</a></td>
		</tr>
		<!-- 관리자 게시판 파트 -->
		<tr>
			<th> 게시판 파트 </th>
			<td><a href="./AdminBoard.bo">회원 리스트 보기</a></td>
		</tr>
		<!-- 관리자 쿠폰 파트 -->
		<tr>
			<th> 쿠폰 파트 </th>
			<td><a href="./CouponAdd.ac">새로운 쿠폰 등록하기</a>
			<a href="#"> 쿠폰 리스트 보기 </a></td>
		</tr>	
		</table>
	</div>
	</div>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>
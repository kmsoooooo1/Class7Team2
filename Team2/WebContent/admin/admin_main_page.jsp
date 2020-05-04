<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<h2> 관리자 페이지 </h2>
	
	<div>
		<!-- 관리자 동물 파트 -->
		<div> 
			<h4> 동물 파트 </h4>
			<a href="./AnimalList.aa?category=all"> 모든 동물 리스트 </a>
			<a href="./AnimalAdd.aa">동물 추가하기</a>
		</div>
		
		<!-- 관리자 상품 파트 -->
		<div>
			<h4> 상품 파트 </h4>
			<a href="./GoodsList.ag?category=all"> 모든 상품 리스트 </a>
			<a href="./GoodsAdd.ag">사육용품 추가하기</a>
		</div>
		
		<!-- 관리자 멤버 파트 -->
		<div>
			<h4> 멤버 파트 </h4>
		</div>
	</div>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>
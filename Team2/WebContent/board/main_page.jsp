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
	
	<h2> 메인 페이지 </h2>
	
	<a href="./notice.bo?category=notice">공지사항</a>
	<a href="./review.bo?category=review">상품후기</a>
	
	<!-- 메뉴 -->
	<div>
		<ul>
			<li> <a href=""> 파충류 </a>
				<ul>
					<li> <a href=""> 게코 도마뱀 </a> </li>
					<li> <a href=""> 뱀 </a> </li>
					<li> <a href=""> 거북 </a> </li>
				</ul>
			</li>
			<li> <a href=""> 양서류 </a>
				<ul>
					<li> <a href=""> 프로그 </a> </li>
					<li> <a href=""> 살라맨더 </a> </li>
					<li> <a href=""> 팩맨 </a> </li>
				</ul>
			</li>
		</ul>
	</div>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	

</body>
</html>
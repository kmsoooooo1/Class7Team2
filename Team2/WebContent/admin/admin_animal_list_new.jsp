<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/swiper.min.css" rel="stylesheet">
</head>
<body>

	<%
		//AnimalListAction 객체에서 저장된 정보를 저장 
		List<AnimalDTO> admin_animalList = (List<AnimalDTO>) request.getAttribute("admin_animalList");
		String[] arr = new String[5];
		
		for(int i=0; i<admin_animalList.size(); i++){
			AnimalDTO adto = admin_animalList.get(i);
			
			arr[i] = adto.getA_thumbnail();
		}
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->


		
	
	
	  <!-- 신상품 리스트 -->
  <div class="newlist">
  <div class="swiper-container second">
  <h2>신상품 리스트</h2>
	<div class="swiper-wrapper">
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-10">
		  <img src="./upload/multiupload/<%=arr[0]%>">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-150">
		   <img src="./upload/multiupload/<%=arr[1]%>">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-11">
		   <img src="./upload/multiupload/<%=arr[2]%>">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-200">
		  <img src="${pageContext.request.contextPath}/img/플레임 할리퀸.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-10">
		  <img src="${pageContext.request.contextPath}/img/그린 바실리스크1.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-150">
		  <img src="${pageContext.request.contextPath}/img/베일드 카멜레온.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-11">
		  <img src="${pageContext.request.contextPath}/img/주얼드 라세타.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-200">
		  <img src="${pageContext.request.contextPath}/img/플레임 할리퀸.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-10">
		  <img src="${pageContext.request.contextPath}/img/그린 바실리스크1.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-150">
		  <img src="${pageContext.request.contextPath}/img/베일드 카멜레온.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-11">
		  <img src="${pageContext.request.contextPath}/img/주얼드 라세타.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-200">
		  <img src="${pageContext.request.contextPath}/img/플레임 할리퀸.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-11">
		  <img src="${pageContext.request.contextPath}/img/주얼드 라세타.jpg">
		 </a>
		</div>
		<div class="swiper-slide">
		 <a href="./AnimalDetail.an?a_code=a-200">
		  <img src="${pageContext.request.contextPath}/img/플레임 할리퀸.jpg">
		 </a>
		</div>
	</div>

	<!-- 페이징 -->
	<div class="swiper-pagination"></div>
</div>
</div>

	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
<script>

// swiper-container second  
var mySwiper = new Swiper('.second', {
    //파라미터
    speed: 400,
    spaceBetween: 30,
    slidesPerColumn: 3,
    slidesPerView: 4,
    autoplay: {
        delay: 3000,
        disableOnInteraction: false,
    },
    
    //페이지네이션
    pagination: {
        el: '.second .swiper-pagination',
        clickable: true,
    },
    //네비게이션
    navigation: {
        nextEl: '.second .swiper-button-next',
        prevEl: '.second .swiper-button-prev',
    },
	
}); 
</script>
</html>
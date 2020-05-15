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
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	 <!-- 메인 슬라이드 배너  -->
	<div class="slideshow-container">
	 <div class="mySlides slide">
	  <div class="numbertext">1 / 3</div>
	   <img src="../img/RedEye.jpg" style="width: 100%" height="100%">
	  <div class="text">도마뱀</div>
	 </div>
	
	 <div class="mySlides slide">
	  <div class="numbertext">2 / 3</div>
	   <img src="../img/turtle.jpg" style="width: 100%" height="100%">
	  <div class="text">거북이</div>
	 </div>
	
	 <div class="mySlides slide">
	  <div class="numbertext">3 / 3</div>
	   <img src="../img/Flog.jpg" style="width: 100%" height="100%">
	  <div class="text">개구리</div>
	 </div>
	</div>
	<div style="text-align: center;">
	 <span class="dot"></span>
	 <span class="dot"></span>
	 <span class="dot"></span>
	</div>
	
	<!-- 메인 4단 배너 -->
	<div class="sec-banner1">
	 <ul class="xans">
	  <li><a href="#" alt="배너"><img class="banner_imagie" alt="배너"
	  		rel="52-12" src="../img/turtleSet.png"></a></li>
	  <li><a href="#" alt="배너"><img class="banner_imagie" alt="배너"
	  		rel="53-12" src="../img/packSet.png"></a></li>
	  <li><a href="#" alt="배너"><img class="banner_imagie" alt="배너"
	  		rel="54-12" src="../img/reoSet.png"></a></li>
	  <li><a href="#" alt="배너"><img class="banner_imagie" alt="배너"
	  		rel="55-12" src="../img/snakeSet.png"></a></li>
	 </ul>
	
	</div>
	
 <script>
	var slideIndex = 0;
	showSlides();

	function showSlides() {
 	 var i;
 	 var slides = document.getElementsByClassName("mySlides");
  	var dots = document.getElementsByClassName("dot");
 	 for (i = 0; i < slides.length; i++) {
   	 slides[i].style.display = "none";  
 	 }
 	 slideIndex++;
 	 if (slideIndex > slides.length) {slideIndex = 1}    
  		for (i = 0; i < dots.length; i++) {
    	dots[i].className = dots[i].className.replace(" active", "");
 		 }
  	slides[slideIndex-1].style.display = "block";  
  	dots[slideIndex-1].className += " active";
  	setTimeout(showSlides, 2000); // Change image every 2 seconds
	}
 </script>
	<hr>
	
	<!-- 신상품 리스트 -->
	- 신상품 
	
	<!-- 파충류 리스트 -->
	- 파충류
	
	<!-- 양서류 리스트 -->
	- 양서류
	
	<!-- 상품 리스트 -->
	- 상품
	
	
	<hr>
	
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>	

</body>
</html>
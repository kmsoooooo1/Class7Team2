<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/swiper.min.css" rel="stylesheet">
</head>
<body>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<!-- 메인슬라이드 -->
  	<div class="swiper-container first">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
       <img src="${pageContext.request.contextPath}/img/t1.png">
      </div>
      <div class="swiper-slide">
       <img src="${pageContext.request.contextPath}/img/t2.png">
      </div>
      <div class="swiper-slide">
       <img src="${pageContext.request.contextPath}/img/t3.png">
      </div>
    </div>
    <!-- 페이징 -->
    <div class="swiper-pagination"></div>
    <!-- 네비게이션 버튼 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div> 
 
 <!-- 메인 그룹 배너 1-->
 <div class="main-group">
 <div class="banner">
  <ul>
   <li><a href="./aHospital.bo"><img src="${pageContext.request.contextPath}/img/navi.png"></a></li> 
   <li><a href="./aHospital.bo"><img src="${pageContext.request.contextPath}/img/turt.png"></a></li>
  </ul>
 </div>

  <!-- 메인 그룹 배너 3 -->
  <div class="banner">
   <ul>
   <li><a href="./aHospital.bo"><img src="${pageContext.request.contextPath}/img/gaeko.png"></a></li>
   <li><a href="./aHospital.bo"><img src="${pageContext.request.contextPath}/img/fl.png"></a></li>
   </ul>
  </div> 
 </div>

 <!-- 메인 그룹 중앙 배너 2 -->
 <div class="swiper-container banner">
  <div class="swiper-wrapper">
   <div class="swiper-slide">
    <img src="${pageContext.request.contextPath}/img/cBanner1.png">
   </div>
   <div class="swiper-slide">
    <img src="${pageContext.request.contextPath}/img/cBanner2.png">
   </div>
  </div>
  <!-- 페이징 -->
    <div class="swiper-pagination"></div>
    <!-- 네비게이션 버튼 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
 </div> 
 
  <!-- 신상품 리스트 -->
  <div class="newlist">
  <div class="swiper-container second">
  <h2>신상품 리스트</h2>
	<div class="swiper-wrapper">
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
  <!-- Swiper JS -->
  <script src="${pageContext.request.contextPath}/js/swiper/swiper.min.js"></script>

  <!-- Swiper first,second -->
  <script>
  	// swiper-container first
    var swiper = new Swiper('.first', {
      loop: true,
      loopFillGroupWithBlank: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  	// swiper-container banner
    var swiper = new Swiper('.banner', {
      loop: true,
      loopFillGroupWithBlank: true,
      pagination: {
        el: '.banner .swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.banner .swiper-button-next',
        prevEl: '.banner .swiper-button-prev',
      },
    });
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
  <div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>반려동물</h2>
      <h5>이달의 반려동물 인기 순위입니다.</h5>
      <div class="fakeimg" style="height:200px;"><img src="${pageContext.request.contextPath}/img/banner.png"></div>
      <p>갈라파고스에서...</p>
      <p>여러분이 애지중지하게 키운 반려동물의 사진을 올려주세요</p>
    </div>
    <div class="card">
      <h2>TITLE HEADING</h2>
      <h5>Title description, Sep 2, 2017</h5>
      <div class="fakeimg" style="height:200px;"><img src="${pageContext.request.contextPath}/img/banner.png"></div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    </div>
  </div>
  <div class="rightcolumn">
    <div class="card">
      <h2>About Me</h2>
      <div class="fakeimg" style="height:100px;"><img src="${pageContext.request.contextPath}/img/banner.png"></div>
      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
    </div>
    <div class="card">
      <h2>SET상품 리스트 Coming Soon</h2>
      <div class="fakeimg"><p><img src="${pageContext.request.contextPath}/img/snakeSet.png"></p></div>
      <div class="fakeimg"><p><img src="${pageContext.request.contextPath}/img/packSet.png"></p></div>
      <div class="fakeimg"><p><img src="${pageContext.request.contextPath}/img/reoSet.png"></p></div>
    </div>
    <div class="card">
      <h3>Follow Me</h3>
      <p>Some text..</p>
    </div>
  </div>
</div>
  	
	<hr>
	
	
	
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
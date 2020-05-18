<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/main.css" rel="stylesheet">
<link href="../css/swiper.min.css" rel="stylesheet">
</head>
<body>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<!-- 메인슬라이드 -->
  	<div class="swiper-container first">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
       <img src="../img/t1.png">
      </div>
      <div class="swiper-slide">
       <img src="../img/t2.png">
      </div>
      <div class="swiper-slide">
       <img src="../img/t3.png">
      </div>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>

  <!-- Swiper JS -->
  <script src="../js/swiper/swiper.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
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
  </script>
  <hr>
  <!-- 신상품 리스트 -->
  <div>
  <div class="swiper-container second">
	<div class="swiper-wrapper">
		<div class="swiper-slide"><img src="http://oldmidi.cdn3.cafe24.com/p/0133.jpg"></div>
		<div class="swiper-slide"><img src="https://biketago.com/img/p/0501.jpg"></div>
		<div class="swiper-slide"><img src="http://oldmidi.cdn3.cafe24.com/p/0506.jpg"></div>
		<div class="swiper-slide"><img src="http://superkts.dothome.co.kr/img/p2/0619.jpg"></div>
		<div class="swiper-slide"><img src="http://ktsmemo.cdn3.cafe24.com/p/0491.jpg"></div>
		<div class="swiper-slide"><img src="https://biketago.com/img/p/0473.jpg"></div>
		<div class="swiper-slide"><img src="http://oldmidi.cdn3.cafe24.com/p/0275.jpg"></div>
		<div class="swiper-slide"><img src="https://biketago.com/img/p/0790.jpg"></div>
		<div class="swiper-slide"><img src="http://ktsmemo.cdn3.cafe24.com/p/0114.jpg"></div>
		<div class="swiper-slide"><img src="https://biketago.com/img/p/0343.jpg"></div>
		<div class="swiper-slide"><img src="http://ktsmemo.cdn3.cafe24.com/p/0236.jpg"></div>
		<div class="swiper-slide"><img src="http://ktsmemo.cdn3.cafe24.com/p/0784.jpg"></div>
		<div class="swiper-slide"><img src="http://superkts.dothome.co.kr/img/p2/0229.jpg"></div>
		<div class="swiper-slide"><img src="https://biketago.com/img/p/0197.jpg"></div>
		<div class="swiper-slide"><img src="http://oldmidi.cdn3.cafe24.com/p/0565.jpg"></div>
	</div>
	</div>
	<!-- 네비게이션 -->
	<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
	<div class="swiper-button-prev"></div><!-- 이전 버튼 -->

	<!-- 페이징 -->
	<div class="swiper-pagination"></div>
</div>
<div style="text-align:center; margin-top:5px;">랜덤사진 갤러리</div>
  <script>
   new Swiper('.second', {
		
		slidesPerView : 3, // 동시에 보여줄 슬라이드 갯수
		spaceBetween : 30, // 슬라이드간 간격
		slidesPerGroup : 3, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

		// 그룹수가 맞지 않을 경우 빈칸으로 메우기
		// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
		loopFillGroupWithBlank : true,

		loop : true, // 무한 반복

		pagination : { // 페이징
			el : '.swiper-pagination',
			clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
		},
		navigation : { // 네비게이션
			nextEl : '.swiper-button-next', // 다음 버튼 클래스명
			prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
		},
	}); 
  </script>
  <div class="row">
  <div class="leftcolumn">
    <div class="card">
      <h2>반려동물</h2>
      <h5>이달의 반려동물 인기 순위입니다.</h5>
<!--       <div class="fakeimg" style="height:200px;"><img src="../img/banner.png"></div> -->
      <p>갈라파고스에서...</p>
      <p>여러분이 애지중지하게 키운 반려동물의 사진을 올려주세요</p>
    </div>
    <div class="card">
      <h2>TITLE HEADING</h2>
      <h5>Title description, Sep 2, 2017</h5>
      <div class="fakeimg" style="height:200px;">Image</div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    </div>
  </div>
  <div class="rightcolumn">
    <div class="card">
      <h2>About Me</h2>
      <div class="fakeimg" style="height:100px;">Image</div>
      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
    </div>
    <div class="card">
      <h3>Popular Post</h3>
      <div class="fakeimg"><p>Image</p></div>
      <div class="fakeimg"><p>Image</p></div>
      <div class="fakeimg"><p>Image</p></div>
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
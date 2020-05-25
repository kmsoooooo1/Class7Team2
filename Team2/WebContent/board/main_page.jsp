<%@page import="team2.animal.db.AnimalDAO"%>
<%@page import="java.util.List"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인 페이지</title>
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/swiper.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
<%
	AnimalDAO adao = new AnimalDAO();
	
	String category = request.getParameter("category");
	String sub_category = "";
	String sub_category_index = "";
	
	List<AnimalDTO> admin_animalList = adao.ImageNew();

	AnimalDTO adto = new AnimalDTO();
%>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	<div id="main_body">
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
      <div class="swiper-slide">
       <img src="${pageContext.request.contextPath}/img/t4.png">
      </div>
    </div>
    <!-- 페이징 -->
    <div class="swiper-pagination"></div>
    <!-- 네비게이션 버튼 -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div> 
 
 <!-- center_banner -->
    
 <div class="center_banner">
  <div class="banner_img">
   <a href="./aHospital.bo">
    <img src="${pageContext.request.contextPath}/img/navi.png" alt="Navi" class="image">
   </a>
   <div class="overlay">동물병원 정보</div>
  </div>
  <div class="banner_img">
   <a href="./AnimalList.an?category=파충류&sub_category=거북">
    <img src="${pageContext.request.contextPath}/img/turt.png" alt="Turtle" class="image">
   </a>
    <div class="overlay">거북이</div>
  </div>
  <div class="banner_img">
   <a href="./AnimalList.an?category=파충류&sub_category=도마뱀">
    <img src="${pageContext.request.contextPath}/img/gaeko.png" alt="Gaeko" class="image">
   </a> 
    <div class="overlay">개코</div>
  </div>
  <div class="banner_img">
   <a href="./AnimalList.an?category=양서류">
    <img src="${pageContext.request.contextPath}/img/fl.png" alt="Flog" class="image">
   </a> 
    <div class="overlay">개구리</div>
  </div>
  <div class="banner_img">
   <img src="${pageContext.request.contextPath}/img/c2.jpg" alt="Flog" class="image">
    <div class="overlay">GALAPAGOS</div>
  </div>
 </div>
  <!-- 신상품 리스트 -->
  <div class="newlist">
  <div class="swiper-container second">
  <h2>신상품 리스트</h2>
	<div class="swiper-wrapper">
		<%	for(int i=0; i<admin_animalList.size(); i++){
			 adto = admin_animalList.get(i);
		%>
			<div class="swiper-slide">
			 <a href="./AnimalDetail.an?a_code=<%=adto.getA_code()%>">
			  <img src="${pageContext.request.contextPath}/upload/multiupload/<%=adto.getA_thumbnail()%>">
			 </a>
			</div>
		<%} %>

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
   // swiper-container second  
    var mySwiper = new Swiper('.second', {
        //파라미터
        speed: 400,
        spaceBetween: 30,
        slidesPerColumn: 2,
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
 <div class="second_banner"> 
  <div class="banner_img2">
   <img src="${pageContext.request.contextPath}/img/가게내부.png">
  </div>
 </div>
 
 <div id="body"> 
 <div class="main">

<h2 class="ani">반려동물</h2>


<h2>습성</h2>

<div id="myBtnContainer">
  <button class="btn active" onclick="filterSelection('all')"> 전체보기</button>
  <button class="btn" onclick="filterSelection('Lizard')"> 도마뱀</button>
  <button class="btn" onclick="filterSelection('Turtle')"> 거북이</button>
  <button class="btn" onclick="filterSelection('Flog')"> 개구리</button>
</div>

<!-- Portfolio Gallery Grid -->
<div class="row">
  <div class="column Lizard">
    <div class="content">
      <img src="${pageContext.request.contextPath}/img/1.jpg" alt="Mountains" style="width:100%">
      <h4>술라웨시 워터 스킨크</h4>
      <p>악어와 닮은 생김새로 크로커다일 스킨크라도 불리는 스킨크입니다.<br>
                    물을 좋아하지만 성격이 예민하고 겁이 많습니다.</p> 
    </div>
  </div>
  <div class="column Lizard">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/2.jpg" alt="Mountains" alt="Lights" style="width:100%">
      <h4>사바나 모니터 베이비</h4>
      <p>지능이 매우 높고 순한종으로  애완파충류 중 강아지와 같은 입지를<br> 
 		  가지고있습니다. 특히 '개바나'라고도 불립니다.</p>
    </div>
  </div>
  <div class="column Flog">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/3.jpg" alt="Mountains" alt="Nature" style="width:100%">
      <h4>자이언트 픽시 프로그</h4>
      <p>뭐든 잘먹는 식성과20cm까지 자라는 크기로 많은 매니아들이<br>
       	  좋아하는 종이기도 합니다. 누구나 쉽게 키울수있는 귀여운 개구리입니다.</p>
    </div>
  </div>
  
  <div class="column Flog">
    <div class="content">
      <img src="${pageContext.request.contextPath}/img/4.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>브라운[탄]팩맨 베이비</h4>
      <p>생김새가 게임 '팩맨'을 닮았다하여 팩맨이라고 불리는 개구리로<br>
                    눈 앞에 보이는 먹이는 무엇이든 통채로 잡아먹는 모습이 매우 귀엽습니다.</p>
    </div>
  </div>
  <div class="column Turtle">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/5.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>텍사스 테라핀</h4>
      <p>용골이 큰 편이며 등갑은 어두운 갈색에서 밝은 갈색으로 나타납니다.<br>
                    사료도 가리는것 없이 아주 잘먹습니다.</p>
    </div>
  </div>
  <div class="column Flog">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/6.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>부쉬벨드 레인프록</h4>
      <p>흔히 알려진 사막 비개구리와 유사한 종입니다. 평상시에는 흙 안쪽으로<br>
                    숨어있다가, 비가 오면 나와 먹이활동을 하는 개구리입니다.</p>
    </div>
  </div>

  <div class="column Lizard">
    <div class="content">
      <img src="${pageContext.request.contextPath}/img/7.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>메라우케 블루텅 스킨크(성체급)</h4>
      <p> 주로 곤충과 바나나를 즐겨 먹는 잡식성 파충류로 동물성 성분이 강한<br>
      	  개사료를 잘먹습니다.</p>
    </div>
  </div>
  <div class="column Turtle">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/8.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>화이트 레오파드 육지거북</h4>
      <p>일반 개체에 비해 체색이 밝으며,스큠의 가장자리에서 퍼지는<br>
      	  방사상의 검은선이 매력적인 개체들입니다.</p>
    </div>
  </div>
  <div class="column Lizard">
    <div class="content">
    <img src="${pageContext.request.contextPath}/img/9.jpg" alt="Mountains" alt="Car" style="width:100%">
      <h4>블러드 트렌슬루센트 비어디</h4>
      <p>순해서 입문종으로 많이 추천되는 만큼 건강하고 사육난이도 또한 쉽습니다.</p>
    </div>
  </div>
<!-- END GRID -->
</div>

<!-- END MAIN -->
</div>
</div>
<script>
filterSelection("all")
function filterSelection(c) {
  var x, i;
  x = document.getElementsByClassName("column");
  if (c == "all") c = "";
  for (i = 0; i < x.length; i++) {
    w3RemoveClass(x[i], "show");
    if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "show");
  }
}

function w3AddClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    if (arr1.indexOf(arr2[i]) == -1) {element.className += " " + arr2[i];}
  }
}

function w3RemoveClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    while (arr1.indexOf(arr2[i]) > -1) {
      arr1.splice(arr1.indexOf(arr2[i]), 1);     
    }
  }
  element.className = arr1.join(" ");
}


// Add active class to the current button (highlight it)
var btnContainer = document.getElementById("myBtnContainer");
var btns = btnContainer.getElementsByClassName("btn");
for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function(){
    var current = document.getElementsByClassName("active");
    current[0].className = current[0].className.replace(" active", "");
    this.className += " active";
  });
}
</script>
	
	</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>	

</body>
</html>
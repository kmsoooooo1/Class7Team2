<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/basic.css?ver=2" rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>
<body>
<!-- side 퀵바 -->
 <aside id="quick" class="fixed">
         <nav>
            <ul>
               <li>
               	<a href="./BasketList.ba">
               		<i class="fas fa-cart-plus"><span>&nbsp&nbsp장바구니</span></i>
               	</a>
               </li>
               <li>
               	<a href="./recentView.me">
               		<i class="fas fa-history"><span>&nbsp&nbsp최근본상품</span></i>
               	</a>
               </li>
               <li>
               	<a href="#" onclick="kakaoChat();" class="kakao_btn">
               		<i class="fas fa-comment-dots"><span>&nbsp&nbsp카톡 상담</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-shipping-fast"><span>&nbsp&nbsp배송 조회</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-heart"><span>&nbsp&nbsp관심상품</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-search"><span>&nbsp&nbsp검색</span></i>
               	</a>
               </li>
            </ul>
         </nav>
      </aside>
<!-- side 퀵바 -->

<div class="h-group">
<div class="header">
      <div class="top_menu">
      <ul>
      <%
         request.setCharacterEncoding("UTF-8");
         
         //로그인 되었는지
         String id = (String) session.getAttribute("id");
         
         if(id == null){   
      %>
        <li> <a href="./MemberJoin.me">
    		  <i class='fas fa-user-edit'><span>회원가입 </span></i>    
         	 </a>
        </li>
        <li> <a href="./MemberLogin.me">
    		  <i class='fas fa-sign-in-alt'><span>로그인</span></i>    
          	 </a>
        </li>
      <% }else if(id.equals("admin")) { %>
        <li> <a href="./Main.ad">
    		  <i class='fas fa-users-cog'><span>관리자 페이지</span></i>    
         	 </a>
        </li>
        <li> <a href="./MemberLogout.me">
        	  <i class='fas fa-sign-out-alt'><span>로그아웃</span></i> 
         	 </a>
        </li>
      <% }else{ %>
        <li> <a href="./MemberPage.me">
        	  <i class='fas fa-user-cog'><span>마이 페이지</span></i>
        	 </a>
        </li>
        <li> <a href="./MemberLogout.me">
   			  <i class='fas fa-sign-out-alt'><span>로그아웃</span></i> 	    
         	 </a>
        </li>
      <% } %> 
   <li><a href="./BoardList.bo?category=0">
        <i class='far fa-bell'><span>공지사항</span></i>
       </a>
   </li>
   <li><a href="./BoardList.bo?category=1">
 		<i class='far fa-edit'><span>상품후기</span></i>  
   	   </a>
   </li>
   <li><a href="./BoardList.bo?category=2">
   		<i class='far fa-comments'><span>QnA</span></i>
   	   </a>
   </li>
   	  </ul>
    </div>
    
    <div id="logo">
      <a href="./Main.me" id="logo" class="title_logo">GALAPAGOS</a>
    </div>  
   <!-- 메인 메뉴 --> 
   <nav id="nav_menu" class="nav_menu"> 
      <ul class="sub_menu">
         <li class="dropdown"><a href="./AnimalList.an?category=파충류&sub_category=도마뱀" class="dropbtn"> 도마뱀 </a>
            <div class="dropdown-content">
               <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=리자드/모니터"> 리자드/모니터 </a>
               <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=레오파드 게코"> 레오파드 게코 </a> 
               <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=크레스티드 게코"> 크레스티드 게코 </a>
               <a href="./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=카멜레온"> 카멜레온 </a>
            </div>
          </li>
        
         <li class="dropdown"> <a href="./AnimalList.an?category=파충류&sub_category=뱀" class="dropbtn"> 뱀 </a> </li>
         
         <li class="dropdown"> <a href="./AnimalList.an?category=파충류&sub_category=거북" class="dropbtn"> 거북 </a> </li>
         
         
         <li class="dropdown"> <a href="./AnimalList.an?category=양서류" class="dropbtn"> 양서류 </a>
            <div class="dropdown-content">
                <a href="./AnimalList.an?category=양서류&sub_category=프로그"> 프로그 </a>
                <a href="./AnimalList.an?category=양서류&sub_category=살라맨더"> 살라맨더 </a>
                <a href="./AnimalList.an?category=양서류&sub_category=팩맨"> 팩맨 </a>
            </div>
         </li>
         
         <li class="dropdown"> <a href="./GoodsList.go?category=먹이" class="dropbtn"> 먹이 </a>
            <div class="dropdown-content">
               <a href="./GoodsList.go?category=먹이&sub_category=칼슘/약품"> 칼슘/약품 </a>
               <a href="./GoodsList.go?category=먹이&sub_category=생먹이"> 생먹이 </a>
               <a href="./GoodsList.go?category=먹이&sub_category=냉동먹이"> 냉동먹이 </a>
               <a href="./GoodsList.go?category=먹이&sub_category=인공사료"> 인공사료 </a>
            </div>
         </li>
         
         <li class="dropdown"> <a href="./GoodsList.go?category=사육용품" class="dropbtn"> 사육용품 </a>
            <div class="dropdown-content">
               <a href="./GoodsList.go?category=사육용품&sub_category=사육장"> 사육장 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=장식/그릇"> 장식/그릇 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=램프"> 램프 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=바닥재"> 바닥재 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=온/습도 관련"> 온/습도 관련 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=보조용품"> 보조용품 </a>
               <a href="./GoodsList.go?category=사육용품&sub_category=수족관"> 수족관 </a>
            </div>
         </li>
         <li class="dropdown"> <a href="./aHospital.bo" class="dropbtn"> 동물병원 정보</a> </li>
      </ul>
   </nav>
   </div>
   </div>
</body>
<script type="text/javascript">
//카카오 채팅 상담 -----------------------------------------------------------------------------------
function kakaoChat() {
	var popupX = (window.screen.width / 6) - (200 / 2); 
	var popupY = (window.screen.height / 4) - (300 / 2);  
	window.open('https://pf.kakao.com/_iLxlxexb','windows','width=600,height=670,left='+popupX+',top='+popupY+',scrollbars=yes');
}


window.onscroll = function() {myFunction()};

var header = document.getElementById("nav_menu");
var sticky = header.offsetTop;

function myFunction() {
  if (window.pageYOffset > sticky) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
}
</script>
</html>
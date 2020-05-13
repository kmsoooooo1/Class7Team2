<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/basic.css" rel="stylesheet">
</head>
<body>
   <header class="title_center"> 
      <a href="./Main.me" id="logo" class="title_logo">GALAPAGOS</a>
   </header>
      <div class="title_right">
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
   <div class="title_center">
   <a href="./BoardList.bo?category=0">공지사항</a>
   <a href="./BoardList.bo?category=1">상품후기</a>
   <a href="./BoardList.bo?category=2">QnA</a>
   </div>
   <!-- 메인 메뉴 --> 
   <nav id="nav_menu"> 
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
   
</body>

</html>
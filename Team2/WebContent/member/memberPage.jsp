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
<!-- 
	   로그인한 사용자의 경우 사용자 ID를 출력,
	   로그인X 사용자의 경우 로그인페이지로 이동 	   
	 -->
	 <%
	   // 세션정보(ID값 가져오기)
	   String id = (String)session.getAttribute("id");
	   // 로그인 유무 판단 처리 
	   
	   if(id == null){
		  response.sendRedirect("./MemberLogin.me");   
	   }   
	 %>
<!-- 회원 이미지 -->	 
 <div>
  <div>
   <div>
    <img src="//img.echosting.cafe24.com/skin/base_ko_KR/member/img_member_default.gif" alt
    onerror="this.src='//img.echosting.cafe24.com/skin/base/member/img_member_default.gif';"
    class="myshop_benefit_group_image_tag"> 
   </div>
 
  <!-- 회원 정보 -->   
  <div>
   <span>
    <span><%=id %></span>
   </span>
   <span>
    <span>
     <img src="" alt="" class="myshop_benefit_group_icon_tag"> 
    </span>
     <span>1%바로 적립</span>
    </span>
   </div>
  </div>
  
  <!-- 회원 이미지 끝 -->
  <div>
   <div>
    <p>
    	환영합니다.   
    <b>
    <span>
    <span>${id }</span>
    </span>
    </b>
    	회원님!
    </p>
    
    <ul>
     <!-- 주문조회 -->
     <li><a href="./OrderList.or">주문내역</a></li>
     <!-- 장바구니 -->
     <li><a href="./BasketList.ba">장바구니
     	  <span class="count">
     	  <span class="">0</span>
     	  </span>
     	 </a>
     </li>
	 <!-- 관심상품 -->
	 <li><a href="#">관심상품
	 	  <span class="count">
	 	  <span class="">0</span>
	 	  </span>
	 	 </a>
	 </li>
	 <!-- 최근 본 상품 -->
	 <li><a href="#">최근 본 상품</a></li>
	 <!-- 내가쓴글 -->
	 <li><a href="./BoardList.bo">내 게시글</a></li>
    </ul>
   </div>
   
   <div>
    <ul>
     <!-- 총주문 -->
     <li>
      <strong>총 주문</strong>
      <strong>
       <span>0원</span>
       	
       <span>(0회)</span> 	
      </strong>      
     </li>
     <!-- 예치금 -->
     <li>
      <strong>예치금</strong>
      <strong>
       <span>0원</span>
      </strong>
       <a href="#">조회</a>
     </li>
     <!-- 가용 적립금 -->
     <li>
      <strong>가용 적립금</strong>
      <strong>
       <span>2,000원</span>
      </strong>
       <a href="#">조회</a>
     </li>
     <!-- 총 적립금 -->
     <li>
      <strong>총적립금</strong>
      <strong>
       <span>2,000원</span>
      </strong>
     </li>
     <!-- 사용 적립금 -->
     <li>
      <strong>사용 적립금</strong>
      <strong>
       <span>0원</span>
      </strong>
     </li>
     <!-- 쿠폰 -->
     <li>
      <strong>쿠폰</strong>
      <strong>
       <span>0개</span>
      </strong>
       <a href="#">조회</a>
     </li>
    </ul>
   </div>
   
   <!-- 회원 수정,탈퇴 버튼 -->
   <div>
    <a href="./MemberUpdate.me">회원정보 수정</a>
    <a href="./MemberDelete.me">회원 탈퇴</a>
   </div>
   <div>
    <h3>회원님의 혜택정보</h3>
   <div>
   <!-- 혜택정보(한국) -->
    <div>
     <p>
      <span>
       "저희 쇼핑몰을 이용해 주셔서 감사합니다."
       <strong>
        <span>
        <span>${id }</span>
        </span>
       </strong>
       "회원님은"
       <strong>
        <span>[1%바로 적립]</span>
       </strong>
       "등급 회원이십니다." 
      </span>
     </p>
    </div>
   </div>
   <!-- 주문처리현황 -->
   <div>
    <h3>
     <span>주문처리 현황</span>
     <span><em>(최근 3개월)</em></span>
    </h3>
   <div>
    <ul>
     <li>
      <span>입금전</span>
      <a href="#">
       <span>0</span>
      </a>
     </li>
     <li>
      <span>배송준비중</span>
      <a href="#">
       <span>0</span>
      </a>
     </li>
     <li>
      <span>배송중</span>
      <a href="#">
       <span>0</span>
      </a>
     </li>
     <li>
      <span>배송완료</span>
      <a href="#">
       <span>0</span>
      </a>
     </li>
    </ul>
    <!-- 취소,교환,반품 -->
    <ul>
     <li>
      <span>취소</span>
       <a href="#">
        <span>0</span>
       </a>
     </li>
     <li>
      <span>교환</span>
       <a href="#">
        <span>0</span>
       </a>
     </li>
     <li>
      <span>반품</span>
       <a href="#">
        <span>0</span>
       </a>
     </li>
    </ul>
   </div>
  </div> 
 
 <!-- 주문 상품 정보 -->
 <div>
  <h3>주문상품정보
   <a href="#"></a>
  </h3>
  <div>
   <table border="1" summary="">
    <caption>주문 상품 정보</caption>
    <tr>
     <th>주문번호</th>
     <th>이미지</th>
     <th>상품정보</th>
     <th>수량</th>
     <th>상품구매금액</th>
     <th>주문처리상태</th>
    </tr>
   </table>
    <p>
     	주문 내역이 없습니다.
    </p>
  </div>
 </div>
 
 <!-- 최근 본 상품 -->
 <div>
  <h3>
  <span>최근 본 상품</span>
   <a href="#"></a>
  </h3>
  <div>
   <table width="100%" border="1" summary="">
    <caption>최근 본 상품 목록</caption>
   </table>
   <p>
   	최근본 상품 내역이 없습니다.
   </p>
  </div>
 </div>
 
 <!-- 내 게시글 -->
 <div>
  <h3>
   <span>내 게시글</span>
    <a href="#"></a>
  </h3>
  <div>
   <table width="100%" border="1" summary="">
    <caption>게시물 관리 목록</caption>
    <tr>
     <th>번호</th>
     <th>분류</th>
     <th>제목</th>
     <th>작성자</th>   
     <th>작성일</th>   
     <th>조회수</th>   
    </tr>
   </table> 
    <p>
    	게시물이 없습니다.
    </p>
  </div>
 </div>
 
 </div>
</div>
</div>	
<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
</body>
</html>
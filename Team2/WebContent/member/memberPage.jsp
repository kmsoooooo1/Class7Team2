<%@page import="java.net.URLDecoder"%>
<%@page import="team2.member.db.MemberDAO"%>
<%@page import="team2.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link href="${pageContext.request.contextPath}/css/mypage.css?ver=2" rel="stylesheet">
<title>마이 페이지</title>
<style type="text/css">


</style>
</head>
<body>
<!-- Header -->
<jsp:include page="/include/header.jsp" />
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
	   
	   // id에 맞는 회원의 이름 화면에 출력
	   MemberDAO mdao = new MemberDAO();
	   MemberDTO mdto = mdao.getMember(id);
	   String name = mdto.getName();
	 %>
	 
 <div class="member_div">
 <h3 class="member_h3">마이쇼핑</h3>
	 <!-- 회원 수정,탈퇴 버튼 -->
  <div class="memberupdate_div">
  <button type="button" class="member_btn" onclick="location.href='./MemberUpdate.me'"><i class='fas fa-user-plus'></i>&nbsp회원정보수정 </button>
  <button type="button" class="member_btn" onclick="location.href='./MemberDelete.me'"><i class="fas fa-user-slash"></i>&nbsp회원 탈퇴 </button>
   
  </div>
<!-- 회원 이미지 -->	 
   <div class="top_div">
   <div class="logo_div">
    <img src="//img.echosting.cafe24.com/skin/base_ko_KR/member/img_member_default.gif" 
    class="myshop_benefit_group_image_tag"> 
   </div>
   <div class="member_top_menu">
   	<div class="welcome_div">
   	 <p>
    	환영합니다.   
    <b>
    <span>
    <span><%=name %></span>
    </span>
    </b>
    	회원님!
    </p>
    </div>
    <ul>
     <!-- 주문조회 -->
     <li><button type="button" class="member_btn"><i class="far fa-calendar-alt"></i>&nbsp주문 내역</button></li>
     <!-- 장바구니 -->
     <li><button type="button" class="member_btn"><i class="fas fa-cart-plus"></i>&nbsp장바구니</button></li>
	 <!-- 관심상품 -->
	 <li><button type="button" class="member_btn"><i class="fas fa-heart"></i>&nbsp관심상품</button></li>
	 <!-- 최근 본 상품 -->
	 <li><button type="button" class="member_btn"><i class="fas fa-history"></i>&nbsp최근 본 상품</button></li>
	 <!-- 내가쓴글 -->
	 <li><button type="button" class="member_btn"><i class="fas fa-user-edit"></i>&nbsp내 게시글</button></li>
    </ul>
   </div>
   </div>
 
  <!-- 회원 정보 -->
  <div class="top_div2">   
    <span><b><%=name %></b></span>
    <span><br>
    </span>
     <span>1%바로 적립</span>
   </div>
  
  <!-- 회원 이미지 끝 -->
   
   
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
        <span><%=name %></span>
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
  <span><h3>최근 본 상품</h3></span>
  <a href="./recentView.me">더보기></a>
  <table border="1">
	<tr>
		<td>이미지</td>
		<td>상품명</td>
		<td>판매가</td>
		<td>옵션정보</td>
		<td>주문</td>
	</tr>
		<%
		// 쿠키 얻어오기
		Cookie[] cook = request.getCookies();
		if(cook!= null){
			for(int i=0; i<cook.length; i++){
				
			// 전송된 쿠키 이름 얻어오기
			String name1 = cook[i].getName();
			// 쿠키 이름에 item이 포함되어 있다면
			if(name1.indexOf("item")!= -1){
		
			// 해당 value얻어오기
			String value = cook[i].getValue();
			
			String item = URLDecoder.decode(value, "UTF-8");
			out.println(item + "<br>");
		
			}
		}
		
		}else{
				%>
				<tr>
					<td colspan="5">최근에 본 상품이 없습니다.</td>
				</tr>
				<%
		}
		%>
	</table>
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
	<jsp:include page="/include/footer.jsp"/>
</body>
</html>
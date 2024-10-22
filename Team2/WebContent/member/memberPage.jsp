<%@page import="team2.order.db.OrderDAO"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@page import="team2.coupon.db.CouponDTO"%>
<%@page import="team2.couponMember.db.CouponMemberDTO"%>
<%@page import="team2.coupon.db.CouponDAO"%>
<%@page import="team2.product.db.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.order.db.OrderDTO"%>
<%@page import="java.util.List"%>
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
	   
	   //////////////////////////////////////////////////
	   	List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");
		List productInfoList = (List) request.getAttribute("productInfoList");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		
		int final_total_price = 0; 	//총 상품금액
		int final_delivery_fee = 0; //총 배송비
		
		//////////////////////
		String sdata = (String)request.getAttribute("sdata");
		
		String[] data = sdata.split(",");
		
		//주문 처리 현황
		for(int i=0; i<data.length; i++){
			System.out.print(data[i]);
		}
		
		//배송 현황 체크
		
// 		if(check == 0){
// 			data[0] = "1";
// 		}else if(check == 1){
// 			data[1] = "1";
// 		}else{
			
// 		}
		// 쿠폰 보유 개수 확인
		int countCouponNum = mdao.countCoupons(id);
		
		// 보유 쿠폰 확인
		CouponDAO cdao = new CouponDAO();
		
		Vector vec = cdao.getMemberCouponsList(id);
		
		ArrayList memberCouponList = (ArrayList) vec.get(0);
		ArrayList couponInfoList = (ArrayList) vec.get(1);
		
		
		//내 게시글
		List<BoardDTO> myBoardlist = (ArrayList<BoardDTO>)request.getAttribute("myBoardlist");
		Criteria cri = (Criteria)request.getAttribute("cri");
		
		// 총 주문 금액 계산
		int order_total_price = 0;
		for(int i=0; i<orderList.size(); i++){
				order_total_price = orderList.get(i).getO_sum_money() + order_total_price;
		}
		
		// 주문횟수 확인
		OrderDAO odao = new OrderDAO();
		int countOrderNum = odao.countOrder(id);
		
		
	 %>
		
 
 <div class="member_div">
 <div class="content">
 <div>
 <h2 class="member_h2">마이쇼핑</h2>
 </div>
	 <!-- 회원 수정,탈퇴 버튼 -->
  <div class="myshop">
  
<!-- 회원 이미지 -->	 
   <div class="top_div">
   <div class="user_left">
   <div class="userImage">
    <img src="//img.echosting.cafe24.com/skin/base_ko_KR/member/img_member_default.gif" 
    class="myshop_benefit_group_image_tag"> 
   </div>
   <div class="userInfo"> 
    <span class="userName"><b><%=name %></b></span>
    <span class="groupName">1% 바로 적립</span>
   </div>
   </div>
   <!-- 회원 정보 -->
   
   <div class="userRight">
   	<div class="quickButton">
   	 <p class="welcome">
    	환영합니다.   
    <b>
    <span>
    <span><%=name %></span>
    </span>
    </b>
    	회원님!
    </p>
    
    <ul>
     <!-- 주문조회 -->
     <li><a href="./OrderList.or">주문 내역</a></li>
     <!-- 장바구니 -->
     <li><a href="./BasketList.ba">장바구니</a></li>
	 <!-- 관심상품 -->
	 <li><a href="./WishList.wl">관심상품</a></li>
	 <!-- 최근 본 상품 -->
	 <li><a href="./recentView.me">최근 본 상품</a></li>
	 <!-- 내가쓴글 -->
	 <li><a href="./myBoard.bo">내 게시글</a></li>
    </ul>
    </div>
    <div class="userButton">
  		<a href="./MemberUpdate.me"><i class='fas fa-user-plus'></i>회원 정보 수정</a>
  		<a href="./MemberDelete.me"><i class="fas fa-user-slash"></i>회원 탈퇴</a>
   
  	</div>
   <div class="mileage_div">
    <ul>
     <!-- 총주문 -->
     <li>
      <strong class="mileage_strong">총 주문</strong>
      <strong class="mileage_strong2">
       <span class="mileage_span"><%=formatter.format(order_total_price) %>원</span>
       	
       <span class="mileage_span2">(<%=countOrderNum %>회)</span> 	
      </strong>      
     </li>
     <!-- 가용 적립금 -->
     <li>
      <strong class="mileage_strong">적립금</strong>
      <strong class="mileage_strong2">
       <span class="mileage_span"><%=formatter.format(mdto.getMileage()) %>원</span>
      </strong>
       <a href="./Mileage.me"
          onclick="window.open(this.href,'_blank','width=900, height=500, top=200, left=600, toolbars=no, scrollbars=yes'); return false;">조회</a>
     </li>
     <!-- 쿠폰 -->
     <li>
      <strong class="mileage_strong">쿠폰</strong>
      <strong class="mileage_strong2">
       <span class="mileage_span"><%=countCouponNum%>개</span>
      </strong>
       <a href="./Coupon.me"
          onclick="window.open(this.href,'_blank','width=900, height=500, top=200, left=600, toolbars=no, scrollbars=yes'); return false;">조회</a>
     </li>
    </ul>
   </div>
   </div>
   </div>
  
  <!-- 회원 이미지 끝 -->
   
   
   
   <div class="benefit_div">
    <h3>회원님의 혜택정보</h3>
   <div>
   <!-- 혜택정보(한국) -->
    <div class="benefit_contents">
     <p>
      <span class="benefit_span" style="font-size: 13px;">
       "저희 쇼핑몰을 이용해 주셔서 감사합니다."
       <strong class="benefit_strong">
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
   </div>
   <!-- 주문처리현황 -->
   <div class="order_div">
    <h3>
     <span>주문처리 현황</span>
     <span class="desc"><em>(최근 3개월)</em></span>
    </h3>
   <div class="contents">
    <ul class="order_ul">
     <li>
      <span class="order_span">입금전</span>
      <a href="#" style="color: black; text-decoration: none;">
       <span><%=data[0] %></span>
      </a>
     </li>
     <li>
      <span class="order_span">배송준비중</span>
      <a href="#" style="color: black; text-decoration: none;">
       <span><%=data[1] %></span>
      </a>
     </li>
     <li>
      <span class="order_span">배송중</span>
      <a href="#" style="color: black; text-decoration: none;">
       <span><%=data[2] %></span>
      </a>
     </li>
     <li>
      <span class="order_span">배송완료</span>
      <a href="#" style="color: black; text-decoration: none;">
       <span><%=data[3] %></span>
      </a>
     </li>
    </ul>
    <!-- 취소,교환,반품 -->
    <ul class="cs">
     <li>
      <span>취소:</span>
       <a href="#">
       </a>
     </li>
     <li>
      <span>교환:</span>
       <a href="#">
       </a>
     </li>
     <li>
      <span>반품:</span>
       <a href="#">
       </a>
     </li>
    </ul>
   </div>
  </div> 
 
 <!-- 주문 상품 정보 -->
 <div class="info_div">
  <h3>주문상품정보
   <a href="./OrderList.or" class="seemore">더보기>></a>
  </h3>
  <div class="contents">
   <table border="1" class="order_table">
    <caption>주문 상품 정보</caption>
    <colgroup>
    	<col style="width: 15%;">
    	<col style="width: 10%;">
    	<col style="width: auto;">
    	<col style="width: 5%;">
    	<col style="width: 20%;">
    	<col style="width: 10%;">
    </colgroup>
    <thead>
    <tr>
     <th scope="col">주문번호</th>
     <th scope="col">이미지</th>
     <th scope="col">상품정보</th>
     <th scope="col">수량</th>
     <th scope="col">상품구매금액</th>
     <th scope="col">주문처리상태</th>
    </tr>
    </thead>
		<%
				if (orderList.size() == 0) {
			%>
			<tr>
				<td class="empty" colspan="6">구매 내역이 없습니다.</td>
			</tr>
			<%
				} else {
					for (int i = 0; i < orderList.size(); i++) {
							OrderDTO odto = (OrderDTO) orderList.get(i);
							ProductDTO pdto = (ProductDTO) productInfoList.get(i);

							//총 상품금액 계산
							if (pdto.getProduct_discount_rate() != 0) {
								final_total_price += (odto.getO_p_amount()
										* (pdto.getProduct_price_sale() + pdto.getProduct_option_price()));
							} else {
								final_total_price += (odto.getO_p_amount()
										* (pdto.getProduct_price_origin() + pdto.getProduct_option_price()));
							}

							//b_code 값들 중에 맨 앞글자 따오기
							char first_letter = odto.getO_p_code().charAt(0);
			%>
			<tr>
				<td class="first">
					<%=orderList.get(0).getO_date()%> <br> 
					<a href="./OrderDetail.or?o_trade_num=<%=odto.getO_trade_num()%>"> [<%=odto.getO_trade_num()%>]
				</a></td>

				<!-- 상품 이미지 -->
				<!-- 상품이 동물일때 -->
				<%
					if (first_letter == 'a') {
				%>
				<td><a
					href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <img
						src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>"
						width="100" height="100">
				</a></td>

				<!-- 상품정보 (옵션이 있을때와 없을때) -->
				<%
					if (odto.getO_p_option().equals("")) {
				%>
				<td><a class="orderInfo_td"
					href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name()%>
				</a></td>
				<%
					} else {
				%>
				<td><a class="orderInfo_td"
					href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + odto.getO_p_option() + "]"%>
				</a></td>
				<%
					}
				%>
				<!-- 상품이 물건일때 -->
				<%
					} else if (first_letter == 'g') {
				%>
				<td><a
					href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <img
						src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>"
						width="100" height="100">
				</a></td>

				<!-- 상품정보 (옵션이 있을때와 없을때) -->
				<%
					if (odto.getO_p_option().equals("")) {
				%>
				<td><a class="orderInfo_td"
					href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name()%>
				</a></td>
				<%
					} else {
				%>
				<td><a class="orderInfo_td"
					href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + odto.getO_p_option() + "]"%>
				</a></td>
				<%
					}
				%>
				<%
					}
				%>

				<!-- 수량 -->
				<td><%=odto.getO_p_amount()%>개</td>

				<!-- 판매가(적립금) -->
				<%
					if (pdto.getProduct_discount_rate() != 0) {
				%>
				<td><%=formatter.format(pdto.getProduct_price_sale() + pdto.getProduct_option_price())%>원
					<br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>)</td>
				<%
					} else {
				%>
				<td><%=formatter.format(pdto.getProduct_price_origin() + pdto.getProduct_option_price())%>원
					<br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>)
				</td>
				<%
					}
				%>

				<!-- 입금상태  o_status가 0이면 입금전 1이면 입금후 2이면 배송중-->
				<%
					if (odto.getO_status() == 0) {
				%>
				<td><span style="color: red;"> 입금전 </span></td>
				<%
					} else if (odto.getO_status() == 1) {
				%>
				<td><span style="color: green;"> 입금완료 </span></td>
				<%
					} else if (odto.getO_status() == 2) {
				%>
				<td><span style="color: blue;"> 배송중 </span></td>
				<%
					} else if (odto.getO_status() == 3) {
				%>
				<td><span style="color: black;"> 배송완료 </span></td>
				<%
					}
				%>

			</tr>

			<%
					}
				}
			%>
		</table>

  </div>
 </div>
 
 <!-- 내 쿠폰 목 -->
 <div class="coupon_div">
  <h3>내 쿠폰 목록
  </h3>
  <div class="contents">
   <table border="1" summary>
    <caption>내 쿠폰 목록</caption>
    <colgroup>
    	<col style="width: 10%;">
    	<col style="width: auto;">
    	<col style="width: 10%;">
    	<col style="width: 10%;">
    	<col style="width: 20%;">
    </colgroup>
    <thead>
    <tr>
     <th scope="col">번호</th>
     <th scope="col">쿠폰명</th>
     <th scope="col">구매금액</th>
     <th scope="col">쿠폰적용 상품</th>
     <th scope="col">사용가능 기간</th>
    </tr>
    </thead>
    <%
    if(couponInfoList.size()>0){ 
		for(int i = 0; i < couponInfoList.size(); i++){
			CouponMemberDTO cmdto = (CouponMemberDTO) memberCouponList.get(i);
			CouponDTO cdto = (CouponDTO) couponInfoList.get(i);
    %>
    <tbody>
    	<tr class="choice_tr1">
			<!-- 쿠폰 번호 -->
			<td>
				<%=couponInfoList.size() - i%>
			</td>
		
			<!-- 할인쿠폰명 -->
			<td>
				<%=cdto.getCo_name()%>
			</td>
			
			<!-- 할인금액 -->
			<td>
				<%=cdto.getCo_rate()%>원
				<input type="hidden" id="co_rate<%=i%>" name="co_rate<%=i%>" value="<%=cdto.getCo_rate()%>">
			</td>
			
			<!-- 사용가능대상 -->
			<td>
				<%=cdto.getCo_target()%>
			</td>
			
			<!-- 사용기한 -->
			<td>
				<%=cdto.getCo_startDate()%>-<%=cdto.getCo_endDate()%>
			</td>
		</tr>
		<%} %>
    </tbody>
    </table>
    <% 
    	
	}else{
    
	%>
   </table>
    <p class="empty">
     	보유하고 계신 쿠폰 내역이 없습니다.
    </p>
   <%} %>
  </div>
 </div>
 
 <!-- 최근 본 상품 -->
 <div class="recent_div">
  <h3>최근 본 상품
  <a href="./recentView.me" class="seemore">더보기>></a>
  </h3>
  <div class="contents">
  <table border="1" class="recent_table">
  <caption>최근 본 상품</caption>
  <colgroup>
    	<col style="width: 20%;">
    	<col style="width: auto;">
    	<col style="width: 15%;">
    	<col style="width: 10%;">
    	<col style="width: 15%;">
    </colgroup>
  	<thead>
	<tr>
		<th scope="col">이미지</th>
		<th scope="col">상품명</th>
		<th scope="col">판매가</th>
		<th scope="col">적립금</th>
		<th scope="col">상품정보</th>
	</tr>
	</thead>
	<tbody>
		<%
		// 쿠키 얻어오기
		Cookie[] cook1 = request.getCookies();
		if(cook1!= null){
			for(int i=0; i<cook1.length; i++){
				
			// 전송된 쿠키 이름 얻어오기
			String name1 = cook1[i].getName();
			// 쿠키 이름에 cookie가 포함되어 있다면
			if(name1.indexOf("cookie")!= -1){
		
			// 해당 value얻어오기
			String value = cook1[i].getValue();
			
			String item = URLDecoder.decode(value, "UTF-8");
			out.println(item);
		
			}
		}
				%>
	</tbody>
	</table>
	<%
		}else{
	%>
				<p class=""> 최근 본 상품이 없습니다.</p>
		<%} %>
 </div>
 </div>
 </div>
 
 <!-- 내 게시글 -->
 <div class="board_div">
  <h3>내 게시글
   <a href="./myBoard.bo" class="seemore">더보기>></a>
  </h3>
  <div class="contents">
   <table border="1" summary>
    <caption>내 게시글</caption>
    <colgroup>
    	<col style="width: 160px;">
    	<col style="width: 100px;">
    	<col style="width: auto;">
    	<col style="width: 60px;">
    	<col style="width: 150px;">
    	<col style="width: 140px;">
    </colgroup>
    <thead>
    <tr>
     <th scope="col">번호</th>
     <th scope="col">분류</th>
     <th scope="col">제목</th>
     <th scope="col">작성자</th>
     <th scope="col">작성일</th>
     <th scope="col">조회수</th>
    </tr>
    </thead>
    			  <%
			  if(myBoardlist.size()>0){
				  for(BoardDTO bdto:myBoardlist){
			  %>
				<tbody>
				  <tr>
				    <td><%=bdto.getB_idx() %></td>
				    <td><%=bdto.getB_category() %></td>
				    <td class="title">
				    <a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
				    	<%=bdto.getB_title() %>
				    	</a>
				    </td>
				    
				    <td><%=bdto.getB_writer() %></td>
				    <td><%=bdto.getB_reg_date() %></td>
				    <td><%=bdto.getB_view() %></td>
				  </tr>
				 </tbody>
			  <%}
			  }else{
				%>
				<tr>
				    <td colspan="6"  class="empty">
				     	게시글이 없습니다.
				    </td>
				</tr>
			<%} %>
	   </table>
<!--     <p class="empty"> -->
<!--      	게시글이 없습니다. -->
<!--     </p> -->
  </div>
 </div>
 
 </div>
</div>
<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
</body>
<script type="text/javascript">

	$(".first").each(function() {
		var rows = $(".first:contains('" + $(this).text() + "')");
		if (rows.length > 1) {
		  rows.eq(0).attr("rowspan", rows.length);
		  rows.not(":eq(0)").remove();
		}
	});
	
</script>
</html>
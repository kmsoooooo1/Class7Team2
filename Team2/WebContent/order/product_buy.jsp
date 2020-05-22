<%@page import="team2.member.db.MemberDTO"%>
<%@page import="team2.product.db.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@page import="team2.basket.db.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="${pageContext.request.contextPath}/css/order.css?ver=2" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<body>

	<%
		List basketList = (List) request.getAttribute("basketList");
		List productInfoList = (List) request.getAttribute("productInfoList");
		
		MemberDTO memberDTO = (MemberDTO) request.getAttribute("memberDTO");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		
		int final_total_price = 0; 	//총 상품금액
		int final_delivery_fee = 0; //총 배송비
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	<div class="container">
	<div class="contents">
	<!-- 구매 테이블 생성 -->
	<div class="h2"><h2>CARTOrder / Payment  주문/결제</h2></div>
	
	
	<table border="1" class="list">
		<input type="hidden" id="selectedCodes" name="selectedCodes" value="">
		<input type="hidden" id="selectedOptions" name="selectedOptions" value="">  
		<input type="hidden" id="selectedDeliveryMethods" name="selectedDeliveryMethods" value="">
	
		<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
		<colgroup>
				<col style="width:10%; ">
				<col style="width:auto; ">
				<col style="width:10%; ">
				<col style="width:10%; ">
				<col style="width:15%; ">
				<col style="width:10%; ">
				<col style="width:10%; ">
		</colgroup>
		<thead>
		<tr>
			<th>이미지</th>
			<th>상품정보</th>
			<th>판매가<br>(적립예정)</th>
			<th>수량</th>
			<th>배송구분</th>
			<th>배송비</th>
			<th>합계</th>
		</tr>
		</thead>
		<%
			for (int i = 0; i < basketList.size(); i++) {
				BasketDTO bkdto = (BasketDTO) basketList.get(i);
				ProductDTO pdto = (ProductDTO) productInfoList.get(i);
				
				//총 상품금액 계산
				final_total_price += (bkdto.getB_amount() * pdto.getProduct_price_sale());
				
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = bkdto.getB_code().charAt(0);
		%>
		<tbody>
		<tr>
			<input type="hidden" id="b_code<%=i%>" name="b_code<%=i%>" value="<%=bkdto.getB_code()%>">
			<input type="hidden" id="b_option<%=i%>" name="b_option<%=i%>" value="<%=bkdto.getB_option()%>">
			<input type="hidden" id="b_delivery_method<%=i%>" name="b_delivery_method<%=i%>" value="<%=bkdto.getB_delivery_method()%>">
			<input type="hidden" id="b_price_origin<%=i%>" name="b_price_origin<%=i%>" value="<%=pdto.getProduct_price_origin()%>">
			<input type="hidden" id="b_price_sale<%=i%>" name="b_price_sale<%=i%>" value="<%=pdto.getProduct_price_sale()%>">
			<input type="hidden" id="b_mileage<%=i%>" name="b_mileage<%=i%>" value="<%=pdto.getProduct_mileage()%>">
			<input type="hidden" id="b_discount_rate<%=i%>" name="b_discount_rate<%=i%>" value="<%=pdto.getProduct_discount_rate()%>">
			<input type="hidden" id="b_category<%=i%>" name="b_category<%=i%>" value="<%=pdto.getCategory()%>">
			
			<!-- 상품 이미지 -->
			<!-- 상품이 동물일때 -->
			<%if(first_letter == 'a'){%>
				<td>
					<a href='./AnimalDetail.an?a_code=<%=bkdto.getB_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
				</td>
				
				<!-- 상품정보 (옵션이 있을때와 없을때) -->
				<%if(bkdto.getB_option().equals("")){%>
					<td>
						<a href='./AnimalDetail.an?a_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name()%> </a>
					</td>
				<%}else{%>
					<td>
						<a href='./AnimalDetail.an?a_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + bkdto.getB_option() + "]"%> </a>
					</td>
				<%}%>
			<!-- 상품이 물건일때 -->
			<%} else if(first_letter == 'g') {%>
				<td>
					<a href='./GoodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
				</td>
				
				<!-- 상품정보 (옵션이 있을때와 없을때) -->
				<%if(bkdto.getB_option().equals("")){%>
					<td>
						<a href='./oodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name()%> </a>
					</td>
				<%}else{%>
					<td>
						<a href='./oodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + bkdto.getB_option() + "]"%> </a>
					</td>
				<%}%>
			<%}%>
			
			
			
			<!-- 판매가(적립금) -->
			<%if(pdto.getProduct_discount_rate() != 0){%>
				<td><%=formatter.format(pdto.getProduct_price_sale())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>)</td>
			<%} else{%>
				<td> <%=formatter.format(pdto.getProduct_price_origin())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>) </td>
			<%}%>
			
			<!-- 수량 -->
			<td>
				<!-- 장바구니 수량  -->
				<span id="b_amount<%=i%>" name="b_amount<%=i%>"><%=bkdto.getB_amount()%></span>개
			</td>
			
			<!-- 배송방법(고속버스 일때와 아닐때 -->
			<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
				<td id="b_delivery_method"><%=bkdto.getB_delivery_method()%> <br>(+14,000원)</td>
			<%} else {%>
				<td id="b_delivery_method"><%=bkdto.getB_delivery_method()%></td>
			<%}%>
			
			<!-- 배송비 
				만약 합계가 50,000원 이상이면 배송비 무료, 이하이면 배송비 3,000원 
				합계가 50,000원 이상인데 배송방법이 고속버스이면 14000원 표시
				합계가 50,000원 이하인데 배송방법이 고속버스이면 17000원 표시	
			-->
			<%if(pdto.getProduct_discount_rate() != 0){%>
				<%if(pdto.getProduct_price_sale() * bkdto.getB_amount() >= 50000 && !bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 배송비 무료 </td>
				<%}else if(pdto.getProduct_price_sale() * bkdto.getB_amount() >= 50000 && bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 14,000원 </td>
				<%}else if(pdto.getProduct_price_sale() * bkdto.getB_amount() < 50000 && bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 17,000원 </td>
				<%} else {%>
					<td> 3,000원 </td>
				<%}%>
			<%} else{%>
				<%if(pdto.getProduct_price_origin() * bkdto.getB_amount() >= 50000 && !bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 배송비 무료 </td>
				<%}else if(pdto.getProduct_price_origin() * bkdto.getB_amount() >= 50000 && bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 14,000원 </td>
				<%}else if(pdto.getProduct_price_origin() * bkdto.getB_amount() < 50000 && bkdto.getB_delivery_method().equals("고속버스")){%>
					<td> 17,000원 </td>
				<%} else {%>
					<td> 3,000원 </td>
				<%}%>
			<%}%>
			
			<!-- 합계
				(고속버스 일때 +14000하기, 아닐때는 수량과 곱하기) 
				(할인율이 있으면 세일된 가격으로 곱하기, 할인율이 없으면 원가로 곱하기) -->
			<%if(pdto.getProduct_discount_rate() != 0){%>
				<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
					<td>
						 <span id="total_product_price<%=i%>"> <%= formatter.format(pdto.getProduct_price_sale() * (bkdto.getB_amount()) + Integer.parseInt("14000"))%>원</span>
						 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=pdto.getProduct_price_sale() * (bkdto.getB_amount()) + Integer.parseInt("14000")%>">
					</td>
				<%} else {%>
					<td>
						 <span id="total_product_price<%=i%>"> <%= formatter.format(pdto.getProduct_price_sale() * bkdto.getB_amount())%>원</span>
						 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=pdto.getProduct_price_sale() * bkdto.getB_amount()%>">
					</td>
				<%}%>
			<%} else{%>
				<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
					<td>
						 <span id="total_product_price<%=i%>"> <%= formatter.format(pdto.getProduct_price_origin() * (bkdto.getB_amount()) + Integer.parseInt("14000"))%>원</span>
						 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_origin() * bkdto.getB_amount()) + Integer.parseInt("14000")%>">
					</td>
				<%} else {%>
					<td>
						<span id="total_product_price<%=i%>"> <%= formatter.format(pdto.getProduct_price_origin() * (bkdto.getB_amount()))%>원</span>
						<input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=pdto.getProduct_price_origin() * bkdto.getB_amount()%>">
					</td>
				<%}%>
			<%}%>
		</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
	<!-- 사용자 정보 입력 테이블 -->
	<div class="orderArea">
	<div class="title"><h3>구매자 정보</h3> <p>*필수입력사항</p></div>
	<table border="1" class="orderlist">
	<colgroup>
		<col style="width:10%;">
		<col style="width: auto;">
	</colgroup>
		<tbody class="addressform">
		<tr>
			<th> 구매하시는 분 </th>
			<td> <input type="text" id="buyer_name" name="buyer_name" placeholder size="15" value="<%=memberDTO.getName()%>"> </td>
		</tr>
		<tr>
			<th> 주소 </th>
			<td> 
				<input type="text" id="buyer_zipcode" name="zipcode" id="zipcode" placeholder size="6" maxlength="6" value="<%=memberDTO.getZipcode()%>" readonly> <button type="button" class="orderstar_btn" onclick="DaumPostcode();">주소검색</button> <br>
				<input type="text" id="buyer_addr1" name="addr1" id="addr1" placeholder size="40" value="<%=memberDTO.getAddr1()%>" readonly> <span>기본주소</span> <br>
				<input type="text" id="buyer_addr2" name="addr2" id="addr2" placeholder size="40" value="<%=memberDTO.getAddr2()%>"> <span>상세주소</span>
			</td>
		</tr>
				<!-- ----- DAUM 우편번호 API 시작 ----- -->
				<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
				  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		<tr>
			<th> 휴대전화 </th>
			<td> <input type="text" id="buyer_phone" name="buyer_phone" value="<%=memberDTO.getPhone()%>"> </td>
		</tr>
		
		<tr>
			<th> 전화번호 </th>
			<td> <input type="text" id="buyer_number" name="buyer_number" value="<%=memberDTO.getPhone()%>"> </td>
		</tr>
		
		<tr>
			<th> 이메일 </th>
			<td> 
				<input type="text" id="buyer_email" name="buyer_email" value="<%=memberDTO.getEmail().substring(0, memberDTO.getEmail().indexOf("@"))%>">@<input type="text" id="email_address_input" name="email_address_input" value="<%=memberDTO.getEmail().substring(memberDTO.getEmail().lastIndexOf("@")+1)%>">
				<select name="email_address" class="emailSelect" onchange="changeEmail(this.value);"> 
					<option value=""> - 이메일 선택 - </option>
					<option value="naver.com"> naver.com </option>
					<option value="daum.net"> daum.net </option>
					<option value="nate.com"> nate.com </option>
					<option value="hotmail.com"> hotmail.com </option>
					<option value="yahoo.com"> yahoo.com </option>
					<option value="직접입력" selected> 직접입력 </option>
				</select> <br>
				
				<span>- 이메일을 통해 주문처리과정을 보내드립니다.	</span> <br>
				<span>- 이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요</span>
			</td>
		</tr>
		</tbody>
	</table>
	</div>
	
	<div class="title"><h3>수령자 정보</h3> <p>*필수입력사항</p></div>
	<table border="1" class="orderlist">
	<colgroup>
		<col style="width:10%;">
		<col style="width: auto;">
	</colgroup>
		<tr>
			<th> 배송지 선택 </th>
			<td> <label> <input type="checkbox" id="chkBoxInfo"> 구매자 정보와 동일 </label> </td>
		</tr>
		
		<tr>
			<th> 수령하시는 분 </th>
			<td> <input type="text" id="rece_name" name="rece_name" placeholder size="15" value=""> </td>
		</tr>
		<tr>
			<th> 주소 </th>
			<td> 
				<input type="text" id="rece_zipcode" name="zipcode" id="zipcode" placeholder size="6" value="" readonly> <button type="button" class="orderstar_btn" onclick="DaumPostcode();">주소검색</button> <br>
				<input type="text" id="rece_addr1" name="addr1" id="addr1" placeholder size="40" value="" readonly> <span>기본주소</span> <br>
				<input type="text" id="rece_addr2" name="addr2" id="addr2" placeholder size="40" value=""> <span>상세주소</span>
			</td>
		</tr>
				<!-- ----- DAUM 우편번호 API 시작 ----- -->
				<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
				  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		<tr>
			<th> 휴대전화 </th>
			<td> <input type="text" id="rece_phone" name="rece_phone" value=> </td>
		</tr>
		
		<tr>
			<th> 전화번호 </th>
			<td> <input type="text" id="rece_number" name="rece_number" value=> </td>
		</tr>
		
		<tr>
			<th> 배송메세지 </th>
			<td> <textarea rows="5" cols="100"></textarea> </td>
		</tr>
	</table>
	
	<table border="1" class="list">
		<tr>
			<th>총 주문금액</th>
			<th>총 배송비</th>
			<th>총 할인</th>
			<th>결제 예정 금액</th>
		</tr>
		<tr>
		
			<!-- 총 주문금액 -->
			<td>
				<span><%=formatter.format(final_total_price)%></span>원 
			</td>
			
			<!-- 총 배송비 -->
			<td>
				<%
					for (int i = 0; i < basketList.size(); i++) {
						BasketDTO bkdto = (BasketDTO) basketList.get(i);
						ProductDTO pdto = (ProductDTO) productInfoList.get(i);
									
						if(bkdto.getB_delivery_method().equals("고속버스")){
							final_delivery_fee += 14000;
						}					
						
						//할인율이 있을때
						if(pdto.getProduct_discount_rate() != 0){
							//tr한줄의 총 금액이 5만원보다 적을때
							if((bkdto.getB_amount() * pdto.getProduct_price_sale()) < 50000){
								final_delivery_fee += 3000;
							}else{
								final_delivery_fee += 0;
							}
						}
						//할인율이 없을때
						else if(pdto.getProduct_discount_rate() == 0){
							//tr한줄의 총 금액이 5만원보다 적을때
							if((bkdto.getB_amount() * pdto.getProduct_price_origin()) < 50000){
								final_delivery_fee += 3000;
							}else{
								final_delivery_fee += 0;
							}
						}
					}
				%>
				<span>+<%=formatter.format(final_delivery_fee)%></span>원
			</td>
			
			<!-- 총 할인 금액 -->
			<td>
				-<span id="total_discount_rate">0</span>원
			</td>
			
			<!-- 결제 에정 금액 -->
			<td>
				<span style="color: red;">=<%=formatter.format(final_total_price + final_delivery_fee)%>원</span>
			</td>
			
		</tr>
	</table>
	
	<!-- 쿠폰 및 적립금 조회 테이블 -->
	<div class="title"><h3>Coupon / Discount 쿠폰/추가할인</h3></div>
	<table border="1" class="orderlist">
		<tr>
			<th> 보유 쿠폰 할인 </th>
			<td> 
				<button type="button" class="orderstar_btn" onclick="toggleCoupons();"> 쿠폰 조회 </button> <span>(쿠폰 허용 상품 / 일부 쿠폰 제외)</span>
			
				<table border="1" id="couponsTable" class="coupon_table" style="display:none; width: 80%; height: 150px; overflow: scroll;">
					<thead>
					<tr>
						<th>이미지</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>수량</th>				
						<th>쿠폰선택</th>
						<th>쿠폰할인</th>						
					</tr>
					</thead>
					<%
						for (int i = 0; i < basketList.size(); i++) {
							BasketDTO bkdto = (BasketDTO) basketList.get(i);
							ProductDTO pdto = (ProductDTO) productInfoList.get(i);
							
							//b_code 값들 중에 맨 앞글자 따오기
							char first_letter = bkdto.getB_code().charAt(0);
					%>
					<tr class="choice_tr">
						<!-- 상품 이미지 -->
						<!-- 상품이 동물일때 -->
						<%if(first_letter == 'a'){%>
							<td>
								<img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="80" height="80">
							</td>
							
							<!-- 상품정보 (옵션이 있을때와 없을때) -->
							<%if(bkdto.getB_option().equals("")){%>
								<td>
									<%=pdto.getProduct_name()%>
								</td>
							<%}else{%>
								<td>
									<%=pdto.getProduct_name() + "<br>[옵션: " + bkdto.getB_option() + "]"%>
								</td>
							<%}%>
						<!-- 상품이 물건일때 -->
						<%} else if(first_letter == 'g') {%>
							<td>
								<img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100">
							</td>
							
							<!-- 상품정보 (옵션이 있을때와 없을때) -->
							<%if(bkdto.getB_option().equals("")){%>
								<td>
									<%=pdto.getProduct_name()%>
								</td>
							<%}else{%>
								<td>
									<%=pdto.getProduct_name() + "<br>[옵션: " + bkdto.getB_option() + "]"%>
								</td>
							<%}%>
						<%}%>
						
						<!-- 판매가(적립금) -->
						<%if(pdto.getProduct_discount_rate() != 0){%>
							<td><%=formatter.format(pdto.getProduct_price_sale())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>)</td>
						<%} else{%>
							<td> <%=formatter.format(pdto.getProduct_price_origin())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>) </td>
						<%}%>
						
						<!-- 수량 -->
						<td>
							<!-- 장바구니 수량  -->
							<span id="b_amount<%=i%>" name="b_amount<%=i%>"><%=bkdto.getB_amount()%></span>개
						</td>
						
						<!-- 쿠폰선택 버튼 -->
						<td> 
							<button type="button" id="searchCouponBtn<%=i%>" onclick="searchCoupon('<%=i%>');"> 쿠폰선택 </button>
							<button type="button" id="cancelCouponBtn<%=i%>" onclick="cancelCoupon('<%=i%>');" style="display: none;"> 다시선택 </button>
						</td>
						
						<!-- 쿠폰할인가  -->
						<td> <span id="discount_rate<%=i%>">-0</span>원 </td>
						
					</tr>
					<%
						}
					%>
				</table>
			</td>
		</tr>
		<tr>
			<th> 보유 적립금 사용 </th>
			<td> 
				<input type="text" id="discount_price" value="0">원
				<input type="checkbox" id="discount_price_chkbox"> <span>최대 사용 (사용가능 적립금 ~(총 구매금액의 7%만 사용가능)원) 총 보유 적립금 ~원</span> <br>
				<span>- 보유 적립금 사용 시 총 상품 금액의 7% 이내로 제한됩니다. 일부 상품은 적립금 사용이 불가합니다.</span> 
			</td>
		</tr>
	</table>
	
	<!-- 결제 정보 테이블 -->
	<div class="title"><h3>Payment info / Agreement 결제 정보/주문자 동의</h3></div>
	<table border="1" class="orderlist">
	<colgroup>
		<col style="width:10%;">
		<col style="width: auto;">
	</colgroup>
		<tr>
			<th> 결제 수단 </th>
			<td> 
				<ul style="list-style:none; margin-bottom: 4%;">
					<li style="float:left;"> <label> <input type="radio" name="payment" value="신용카드" checked onclick="div_show(this.value, '신용카드');"> <span class="payment">신용카드</span> </label> </li>
					<li style="float:left;"> <label> <input type="radio" name="payment" value="무통장입금" onclick="div_show(this.value, '무통장입금');"> <span class="payment">가상계좌(무통장입금)</span> </label> </li>
					<li style="float:left;"> <label> <input type="radio" name="payment" value="카카오페이" onclick="div_show(this.value, '카카오페이');"> <span class="payment">카카오페이</span> </label> </li>
					<li style="float:left;"> <label> <input type="radio" name="payment" value="네이버페이" onclick="div_show(this.value, '네이버페이');"> <span class="payment">네이버페이</span> </label> </li>
				</ul>
			</td>
		</tr>
		
		<tr>
			<th> 결제 안내 </th>
			
				<td id="신용카드"> 
					<select>
						<option> 카드 선택 </option>
						<option> 현대카드 </option>
						<option> 하나카드 </option>
						<option> 카카오뱅크 </option>
						<option> 하나(외환) </option>
						<option> NH채움 </option>
						<option> 우리카드 </option>
						<option> 삼성카드 </option>
					</select>
					<span><br>
						※ 할부는 50,000원 이상만 가능합니다. <br> <br>
						안전결제(ISP)? (국민카드/BC카드/우리카드) <br>
						온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인정보를 입력하지 않고 고객님이 사전에 미리 설정한 안전결제(ISP) 비밀번호만 입력, 결제하도록 하여 개인정보 유출 및 카드 도용을 방지하는 서비스입니다. <br> <br>
						안심 클릭 결제? (삼성/외환/롯데/현대/신한/시티/하나/NH/수협/전북/광주/산업은행/제주은행) <br>
						온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인 정보를 입력하지 않고 고객님이 사전에 미리 설정한 전자 상거래용 안심 클릭 비밀번호를 입력하여 카드 사용자 본인 여부를 확인함으로써 온라인상에서의 카드 도용을 방지하는 서비스입니다. <br>
					</span>
				</td>
				
				<td id="무통장입금" style="display:none;">
					<select>
						<option> ::: 선택해 주세요 ::: </option>
						<option> 기업은행:2135159668464 주식회사갈라파고스 </option>
					</select>
					<input type="text" value="<%=memberDTO.getName()%>" style="text-align: center;" placeholder size="5" disabled> <br>
					<span>가상 계좌 안내계좌 유효 기간 2020년 05월 22일 23시 59분 59초 <br>
					가상계좌는 주문 시 고객님께 발급되는 일회성 계좌번호 이므로 입금자명이 다르더라도 입금 확인이 가능합니다. 
					단, 선택하신 은행을 통해 결제 금액을 1원 단위까지 정확히 맞추셔야 합니다. 가상 계좌의 입금 유효 기간은 주문 후 2일 이내이며, 기간 초과 시 계좌번호는 소멸되어 입금되지 않습니다. 
					구매 가능 수량이 1개로 제한된 상품은 주문 취소 시, 24시간 내 가상 계좌를 통한 재주문이 불가 합니다. 인터넷뱅킹, 텔레뱅킹, ATM/CD기계, 은행 창구 등에서 입금할 수 있습니다. <br>
					ATM 기기는 100원 단위 입금이 되지 않으므로 통장 및 카드로 계좌이체 해주셔야 합니다. 은행 창구에서도 1원 단위 입금이 가능합니다. 자세한 내용은 FAQ를 확인하여 주시기 바랍니다.</span>
				</td>
				
				<td id="카카오페이" style="display:none">
					<span>카카오페이 안내 <br>
					카카오페이는 카카오톡에서 카드를 등록, 간단하게 비밀번호만으로 결제할 수 있는 빠르고 편리한 모바일 결제 서비스입니다. <br>
					-지원 카드 : 모든 카드 등록/결제 가능</span>
				</td>
				
				<td id="네이버페이" style="display:none">
					<span>네이버페이 안내 </span><br>
					<br>
					<span>- 주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수 있습니다.	 <br>
					- 네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를 등록하여 네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다. <br>
					- 결제 가능한 신용카드: 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협, 씨티, 카카오뱅크 <br>
					- 결제 가능한 은행: NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남, 수협, 우체국, 미래에셋대우, 광주, 대구, 전북, 새마을금고, 제주은행, 신협, 하나은행, 케이뱅크, 카카오뱅크, 삼성증권 <br>
					- 네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 별 무이자, 청구할인 혜택을 받을 수 있습니다.</span>
				</td>
		</tr>
		<tr>
			<th> 
				주문자 동의 <br>
				<label> <input type="checkbox" id="chkThirdAgreeAll" onclick="checkThirdAgreeAll();"> 전체 동의 </label> 
			</th>
			<td>
				<label> <input type="checkbox" id="chkThirdAgree" name="chkThirdAgree"> 개인정보 제3자 제공 동의(필수) </label>
				<p> 배송 등 거래를 위해 판매자에게 개인정보가 공유됩니다. <a href="javascript:void(0)" onclick="toggleThirdAgree();" return false;> <span id="thirdAgreeBtn"> 자세히 </span>  </a> </p>
				
					<div id="thirdAgreeDetail" style="display:none;  background-color: lightblue; width: 100%; height: 150px; overflow: scroll;">
						갈라파고스의 회원계정으로 상품 및 서비스를 구매하고자 할 경우, 갈라파고스는 거래 당사자간 원활한 의사소통 및 배송, 상담 등 거래이행을 위하여 필요한 최소한의 개인정보만을 갈라파고스 입점업체 판매자 및 배송업체에 아래와 같이 공유하고 있습니다. <br>
						1. 갈라파고스는 귀하께서 갈라파고스 입점업체 판매자로부터 상품 및 서비스를 구매하고자 할 경우, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 24조의 2(개인정보 공유동의 등)에 따라 아래와 같은 사항은 안내하고 동의를 받아 귀하의 개인정보를 판매자에게 공유합니다. "개인정보 제3자 공유 동의"를 체크하시면 개인정보 공유에 대해 동의한 것으로 간주합니다. <br>
						2. 개인정보를 공유받는자 : 위클리웨어 <br>
						3. 공유하는 개인정보 항목 <br>
						- 구매자 정보: 성명, 전화번호, ID, 휴대전화 번호, 메일주소, 상품 구매정보 <br>
						- 수령자 정보: 성명, 전화번호, 휴대전화 번호, 배송지 주소 <br>
						4. 개인정보를 공유받는 자의 이용 목적 : 판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및 불만처리, 상품과 경품 배송을 위한 배송지 확인 등 <br>
						5. 개인정보를 공유받는 자의 개인정보 보유 및 이용 기간 : 개인정보 수집 및 이용 목적 달성 시까지 보관합니다. <br>
						6. 동의 거부 시 불이익 : 본 개인정보 공유에 동의하지 않으시는 경우, 동의를 거부할 수 있으며, 이 경우 거래가 제한됩니다. <br>
					</div>
				
				<label> <input type="checkbox" id="chkThirdAgree" name="chkThirdAgree"> 위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수) </label>
			</td>
		</tr>
	</table>
	
	<input type="button" class="order_btn" value="PAYMENT(결제하기)">
	
	<!-- 이용 안내 -->
	<div class="help">
		<h3>이용안내</h3>
		<div class="inner">
			<h4>WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.</h4>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol>
			<h4>아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</h4>
			<ol>
				<li>KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</li>
				<li>결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능 <br>
					(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)</li>
				<li>최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.<br>
					(무통장, 휴대폰결제 포함)</li>
			</ol> 
			<h4>세금계산서 발행 안내</h4>
			<ol>
				<li>부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</li>
				<li>세금계산서는 사업자만 신청하실 수 있습니다.</li>
				<li>배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
				<li>[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</li>
				<li>[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
			</ol> 
			<h4>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</h4>
			<ol>
				<li>변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며 신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
				<li>상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
			</ol> 
			<h4>현금영수증 이용안내</h4>
			<ol>
				<li>현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</li>
				<li>현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</li>
				<li>발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
				<li>현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</li>
				<li>현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
			</ol> 
		</div>	
	</div>
	</div>
	</div>

	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>
	
</body>

<script type="text/javascript">

	//장바구니 리스트 가져오기
	var basketList = [];
	<c:forEach items="${basketList}" var="basketList">
		basketList.push("${basketList}");
	</c:forEach>
	
	var selectedCodes = ""; 			
	var selectedOptions = ""; 			
	var selectedDeliveryMethods = ""; 	

    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }
    
    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#addr2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).open();
    }

    
    //구매자가 구매자정보와 동일 체크박스를 클릭했을시 수령인에 동일한 정보 넣기
    $("#chkBoxInfo").click(function(){
    	//만약 체크박스가 체크가 안된상태에서 체크를 한다면 구매자와 동일한 정보 넣기
    	if($(this).is(":checked")){
    		$('#rece_name').val($('#buyer_name').val());
    		$('#rece_zipcode').val($('#buyer_zipcode').val());
    		$('#rece_addr1').val($('#buyer_addr1').val());
    		$('#rece_addr2').val($('#buyer_addr2').val());
    		$('#rece_phone').val($('#buyer_phone').val());
    		$('#rece_number').val($('#buyer_number').val());
    	}
    	//만약 체크박스가 체크가 된 상태에서 체크를 한다면 빈 String 값 넣기
    	else{
    		$('#rece_name').val("");
    		$('#rece_zipcode').val("");
    		$('#rece_addr1').val("");
    		$('#rece_addr2').val("");
    		$('#rece_phone').val("");
    		$('#rece_number').val("");
    	}
    });
    
    //이메일 select option을 선택했을시
    function changeEmail(emailValue){
    	if(emailValue == "직접입력"){
    		$('#email_address_input').val("");
    		document.getElementById("email_address_input").focus();
    	}else{
    		$('#email_address_input').val(emailValue);
    	}
    }
    
    //결제수단 radio 버튼 클릭시 해당 value에 맞는 div show하기
    function div_show(v, id){
    	document.getElementById('신용카드').style.display = "none";
    	document.getElementById('무통장입금').style.display = "none";
    	document.getElementById('카카오페이').style.display = "none";
    	document.getElementById('네이버페이').style.display = "none";
    	if(v == "신용카드"){
    		document.getElementById(id).style.display = "";
    	}else if(v == "무통장입금"){
    		document.getElementById(id).style.display = "";
    	}else if(v == "카카오페이"){
    		document.getElementById(id).style.display = "";
    	}else if(v == "네이버페이"){
    		document.getElementById(id).style.display = "";
    	}
    }
    
    //제3자 동의 자세히 버튼 눌렸을때 내용 뜨게하는 함수
    function toggleThirdAgree(){
    	
    	thirdAgreeBtn_val = document.getElementById('thirdAgreeBtn').innerText;
    
    	if(thirdAgreeBtn_val === "자세히"){
    		document.getElementById('thirdAgreeBtn').innerHTML = "닫기";
        	document.getElementById('thirdAgreeDetail').style.display = "";
    	}else if(thirdAgreeBtn_val === "닫기"){
    		document.getElementById('thirdAgreeBtn').innerHTML = "자세히";
        	document.getElementById('thirdAgreeDetail').style.display = "none";
    	}
    }
    
    //체크박스 전체동의 눌렸을시
    function checkThirdAgreeAll() {
    	var chk = $('#chkThirdAgreeAll').is(":checked");
    	if(chk){
    		//안눌려진 상태에서 체크했을때
    		$("input[name='chkThirdAgree']").prop("checked", true);
    	}else{
    		//눌려진 상태에서 체크했을때
    		$("input[name='chkThirdAgree']").prop("checked", false);
    	}
    }
    
    //쿠폰조회 버튼 눌렸을때
    function toggleCoupons(){
    	document.getElementById("couponsTable").style.display="";
    }
    
    //쿠폰조회 버튼 눌렸을시
    function searchCoupon(i){

    	//장바구니에 담긴 모든 상품 한번 훑어서 selected 된 값만 input hidden 값에 넣기
		for(var j=0; j<basketList.length; j++){
			//selectedCodes 안에 사용자가 선택한 codes들 담기
			selectedCodes += ($('#b_code'+j).val() + ", ");
			selectedOptions += ($('#b_option'+j).val() + ", ");
			selectedDeliveryMethods += ($('#b_delivery_method'+j).val() + ", ");
		}

		//추가된 values 변수를 태그에 담기
		document.getElementById("selectedCodes").value = selectedCodes;
		document.getElementById("selectedOptions").value = selectedOptions;
		document.getElementById("selectedDeliveryMethods").value = selectedDeliveryMethods;
		
		var total_discount_rate = document.getElementById("total_discount_rate").innerHTML;
		
		var num = i;
		
		window.open('${pageContext.request.contextPath}/order/searchCoupon.jsp?b_category=' + $('#b_category'+i).val() + '&num=' + num + '&total_discount_rate=' + total_discount_rate, '_blank','width=800,height=700',false);
    }
    
    //쿠폰 다시선택 버튼 눌렸을때
    function cancelCoupon(i){ 
    	
    	//장바구니에 담긴 모든 상품 한번 훑어서 selected 된 값만 input hidden 값에 넣기
		for(var j=0; j<basketList.length; j++){
			//selectedCodes 안에 사용자가 선택한 codes들 담기
			selectedCodes += ($('#b_code'+j).val() + ", ");
			selectedOptions += ($('#b_option'+j).val() + ", ");
			selectedDeliveryMethods += ($('#b_delivery_method'+j).val() + ", ");
		}

		//추가된 values 변수를 태그에 담기
		document.getElementById("selectedCodes").value = selectedCodes;
		document.getElementById("selectedOptions").value = selectedOptions;
		document.getElementById("selectedDeliveryMethods").value = selectedDeliveryMethods;
		
		var previous_point = Number(document.getElementById("discount_rate" + i).innerHTML);
		
		var total_discount_rate = Number(document.getElementById("total_discount_rate").innerHTML);
		
		total_discount_rate -= previous_point;
		
		document.getElementById("total_discount_rate").innerHTML = total_discount_rate;
		
		var total_discount_rate = document.getElementById("total_discount_rate").innerHTML;
		
		var num = i;
		
		document.getElementById("discount_rate" + i).innerHTML = 0;
		
		window.open('${pageContext.request.contextPath}/order/searchCoupon.jsp?b_category=' + $('#b_category'+i).val() + '&num=' + num + '&total_discount_rate=' + total_discount_rate, '_blank','width=800,height=700',false);
    }
    
    
    
</script> 

</html>
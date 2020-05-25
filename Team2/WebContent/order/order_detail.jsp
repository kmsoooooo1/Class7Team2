<%@page import="team2.order.db.OrderDTO"%>
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
<link href="${pageContext.request.contextPath}/css/order.css?ver=2" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<body>

	<%
		List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");
		List productInfoList = (List) request.getAttribute("productInfoList");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		
		int final_total_price = 0; 	//총 상품금액
		int final_delivery_fee = 0; //총 배송비
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<div class="container">
	<div class="contents">
	<!-- 장바구니 테이블 생성 -->
	<div class="h2"><h2>주문 상세 조회</h2></div>
	
		<!-- 주문정보 -->
		<div>
			<div class="title"><h3>주문 정보</h3></div>
			<table border="1" class="orderlist">
				<colgroup>
					<col style="width:10%;">
					<col style="width: auto;">
				</colgroup>
				<tr>
					<th>주문번호</th>
					<td><strong><%=orderList.get(0).getO_trade_num()%></strong></td>
				</tr>
				<tr>
					<th>주문일자</th>
					<td><strong><%=orderList.get(0).getO_date()%></strong></td>
				</tr>
				<tr>
					<th>주문자</th>
					<!-- 입금상태  o_status가 0이면 입금전 1이면 입금후 2이면 배송중-->
					<%if(orderList.get(0).getO_status() == 0) {%>
						<td> 
							<span style="color: red;"> 입금전 </span> 
							<!-- 입금완료(임시) -->
							<button type="button" style="margin-left: 10px;" onclick="changeO_status()"> 입금완료(임시) </button>
						</td>
					<%} else if(orderList.get(0).getO_status() == 1) {%>
						<td> <span style="color: green;"> 입금완료 </span> </td>
					<%} else if(orderList.get(0).getO_status() == 2) {%>
						<td> <span style="color: blue;"> 배송중 </span> </td>
					<%} else if (orderList.get(0).getO_status() == 3) {%>
						<td><span style="color: black;"> 배송완료 </span></td>
					<%}%>
					
					
					
				</tr>
			</table>
		</div>
	
		
		
		<!-- 결제 정보 -->
		<div>
			<div class="title"><h3>결제 정보</h3></div>
			
			<table border="1" class="orderlist">
			<colgroup>
				<col style="width:10%;">
				<col style="width: auto;">
			</colgroup>
				<tr>
					<th>최종결제금액</th>
					<td><%=formatter.format(orderList.get(0).getO_sum_money())%>원</td>
				</tr>
				<tr>
					<th style="height: 80px;"> 결제수단 </th>
					<td> 
						<%=orderList.get(0).getO_trade_type() %> 
						입금자: <%=orderList.get(0).getO_trade_payer() %><br>
						계좌번호 : 기업은행 2135159668464 (주식회사갈라파고스)
					</td>
				</tr>
			</table>
		</div>

		<div class="orderListArea">
			<div class="title"><h3> 주문 상품 정보 </h3></div>
		<table border="1" class="orderlist">
			<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
			<colgroup>
				<col style="width:15%; ">
				<col style="width:auto; ">
				<col style="width:10%; ">
				<col style="width:15%; ">
				<col style="width:10%; ">
				<col style="width:10%; ">
				<col style="width:10%; ">
				<col style="width:10%; ">
			</colgroup>
			<thead>
			<tr>
				<th scope="col">이미지</th>
				<th scope="col">상품정보</td>
				<th scope="col">판매가<br>(적립예정)</th>
				<th scope="col">수량</th>
				<th scope="col">배송구분</th>
				<th scope="col">배송비</th>
				<th scope="col">합계</th>
			</tr>
			</thead>
			<%
				if(orderList.size() == 0){
			
			%>
				</table>
				<p class="empty">구매내역이 비어있습니다.</p>
			<%
				}
				for (int i = 0; i < orderList.size(); i++) {
					OrderDTO odto = (OrderDTO) orderList.get(i);
					ProductDTO pdto = (ProductDTO) productInfoList.get(i);
					
					//총 상품금액 계산
					if(pdto.getProduct_discount_rate() != 0){
						final_total_price += (odto.getO_p_amount() * (pdto.getProduct_price_sale() + pdto.getProduct_option_price()));
					}else{
						final_total_price += (odto.getO_p_amount() * (pdto.getProduct_price_origin() + pdto.getProduct_option_price()));						
					}
					
					
					//b_code 값들 중에 맨 앞글자 따오기
					char first_letter = odto.getO_p_code().charAt(0);
			%>
			<tbody>
			<tr>
				
				<!-- 상품 이미지 -->
				<!-- 상품이 동물일때 -->
				<%if(first_letter == 'a'){%>
					<td>
						<a href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
					</td>
					
					<!-- 상품정보 (옵션이 있을때와 없을때) -->
					<%if(odto.getO_p_option().equals("")){%>
						<td>
							<a href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name()%> </a>
						</td>
					<%}else{%>
						<td>
							<a href='./AnimalDetail.an?a_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + odto.getO_p_option() + "]"%> </a>
						</td>
					<%}%>
				<!-- 상품이 물건일때 -->
				<%} else if(first_letter == 'g') {%>
					<td>
						<a href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
					</td>
					
					<!-- 상품정보 (옵션이 있을때와 없을때) -->
					<%if(odto.getO_p_option().equals("")){%>
						<td>
							<a href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name()%> </a>
						</td>
					<%}else{%>
						<td>
							<a href='./GoodsDetail.go?g_code=<%=odto.getO_p_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + odto.getO_p_option() + "]"%> </a>
						</td>
					<%}%>
				<%}%>
				
				
			
				<!-- 판매가(적립금) -->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<td><%=formatter.format(pdto.getProduct_price_sale() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>)</td>
				<%} else{%>
					<td> <%=formatter.format(pdto.getProduct_price_origin() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>) </td>
				<%}%>
				
				<!-- 수량 -->
				<td>
					<%=odto.getO_p_amount()%>개 
				</td>
				
				<!-- 배송방법(고속버스 일때와 아닐때 -->
				<%if(odto.getO_p_delivery_method().equals("고속버스")) {%>
					<td id="b_delivery_method"><%=odto.getO_p_delivery_method()%> <br>(+14,000원)</td>
				<%} else {%>
					<td id="b_delivery_method"><%=odto.getO_p_delivery_method()%></td>
				<%}%>
				
				<!-- 배송비 
					만약 합계가 50,000원 이상이면 배송비 무료, 이하이면 배송비 3,000원 
					합계가 50,000원 이상인데 배송방법이 고속버스이면 14000원 표시
					합계가 50,000원 이하인데 배송방법이 고속버스이면 17000원 표시	
				-->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<%if(pdto.getProduct_price_sale() * odto.getO_p_amount() >= 50000 && !odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 배송비 무료 </td>
					<%}else if(pdto.getProduct_price_sale() * odto.getO_p_amount() >= 50000 && odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 14,000원 </td>
					<%}else if(pdto.getProduct_price_sale() * odto.getO_p_amount() < 50000 && odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 17,000원 </td>
					<%} else {%>
						<td> 3,000원 </td>
					<%}%>
				<%} else{%>
					<%if(pdto.getProduct_price_origin() * odto.getO_p_amount() >= 50000 && !odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 배송비 무료 </td>
					<%}else if(pdto.getProduct_price_origin() * odto.getO_p_amount() >= 50000 && odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 14,000원 </td>
					<%}else if(pdto.getProduct_price_origin() * odto.getO_p_amount() < 50000 && odto.getO_p_delivery_method().equals("고속버스")){%>
						<td> 17,000원 </td>
					<%} else {%>
						<td> 3,000원 </td>
					<%}%>
				<%}%>
				
				<!-- 합계
					(고속버스 일때 +14000하기, 아닐때는 수량과 곱하기) 
					(할인율이 있으면 세일된 가격으로 곱하기, 할인율이 없으면 원가로 곱하기) -->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<%if(odto.getO_p_delivery_method().equals("고속버스")) {%>
						<td>
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * (odto.getO_p_amount()) + Integer.parseInt("14000"))%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * (odto.getO_p_amount()) + Integer.parseInt("14000")%>">
						</td>
					<%} else {%>
						<td>
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * odto.getO_p_amount())%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * odto.getO_p_amount()%>">
						</td>
					<%}%>
				<%} else{%>
					<%if(odto.getO_p_delivery_method().equals("고속버스")) {%>
						<td>
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * (odto.getO_p_amount()) + Integer.parseInt("14000"))%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * odto.getO_p_amount()) + Integer.parseInt("14000")%>">
						</td>
					<%} else {%>
						<td>
							<span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * (odto.getO_p_amount()))%>원</span>
							<input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * odto.getO_p_amount()%>">
						</td>
					<%}%>
				<%}%>
			</tr>
	
			<%
				}
			%>
		</tbody>
		</table>
		</div>

		<!-- 배송지 정보 -->
		<div class="title"><h3> 배송지 정보 </h3></div>

		<table border="1" class="orderlist">
		<colgroup>
			<col style="width:10%;">
			<col style="width: auto;">
		</colgroup>
			<tr> 
				<th> 받으시는분 </th>
				<td> <%=orderList.get(0).getO_receive_name() %> </td>
			</tr>
			
			<tr>
				<th> 우편번호 </th>
				<td> <%=orderList.get(0).getO_receive_zipcode() %> </td>
			</tr>
			
			<tr>
				<th> 주소 </th>
				<td> <%=orderList.get(0).getO_receive_addr1() + " " + orderList.get(0).getO_receive_addr2() %> </td>
			</tr>
				
			<tr>
				<th> 휴대전화 </th>
				<td> <%=orderList.get(0).getO_receive_mobile() %> </td>
			</tr>
			
			<tr>
				<th> 일반전화 </th>
				<td> <%=orderList.get(0).getO_receive_phone() %> </td>
			</tr>
			
			<tr>
				<th> 배송메세지 </th>
				<td> <%=orderList.get(0).getO_memo() %> </td>
			</tr>
	
		</table>		

	<div class="help">
		<h3>이용안내</h3>
		<div class="inner">
			<ol>
				<li>비회원 주문의 경우, 주문번호를 꼭 기억하세요. 주문번호로 주문조회가 가능합니다.</li>
				<li>배송은 결제완료 후 지역에 따라 3일 ~ 7일 가량이 소요됩니다.</li>
				<li>상품별 자세한 배송과정은 주문조회를 통하여 조회하실 수 있습니다.</li>
				<li>주문의 취소 및 환불, 교환에 관한 사항은 이용안내의 내용을 참고하십시오.</li>
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
				<li>변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며</li>
				<li>신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
				<li>상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
			</ol>
			<h4>현금영수증 이용안내</h4>
			<ol>
				<li>현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체,에스크로, 예치금)에 대해 발행이 됩니다.</li>
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

	function changeO_status(){
		alert("테스트");
	}

</script>
</html>
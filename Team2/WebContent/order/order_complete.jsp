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
	<div class="h2"><h2>ORDER COMPLETE</h2></div>
	
		체크 로고
	
		고객님이 주문이 완료되었습니다.
		주문내역 및 배송에 관한 안내는 주문조회를 통하여 확인 가능합니다.
		
		주문번호: <%=orderList.get(0).getO_trade_num()%>
		주문일자: <%=orderList.get(0).getO_date()%>

		<div class="orderListArea">
		<table border="1" class="list">
			<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
			<colgroup>
				<col style="width:5%; ">
				<col style="width:10%; ">
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
				<th scope="col"> <input type="checkbox" id="chkBoxAll" name="chkBoxAll"> </th>
				<th scope="col">이미지</th>
				<th scope="col">상품정보</td>
				<th scope="col">판매가<br>(적립예정)</th>
				<th scope="col">수량</th>
				<th scope="col">배송구분</th>
				<th scope="col">배송비</th>
				<th scope="col">합계</th>
				<th scope="col">주문관리</th>
			</tr>
			</thead>
			<%
				if(orderList.size() == 0){
			
			%>
				</table>
				<p class="empty">장바구니가 비었습니다.</p>
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
				<!-- 체크박스 -->
				<td> <input type="checkbox" id="chkBox<%=i%>" value="<%=i%>"> </td>
				
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
					<!-- 장바구니 수량  --> 
					<input type="text" id="b_amount<%=i%>" name="b_amount<%=i%>" value="<%=odto.getO_p_amount()%>" maxlength="3" size="3"  onchange='amountChange(<%=i%>)'>개
					<!-- 수량 +/- 버튼 -->
					<input type="button" id="amountPlus" name="amountPlus" value="+" onclick='plus(<%=i%>);'> 
					<input type="button" id="amountMinus" name="amountMinus" value="-" onclick='minus(<%=i%>)'> <br>
				</td>
				
				<!-- 배송방법(고속버스 일때와 아닐때 -->
				<%if(odto.getO_delivery_method().equals("고속버스")) {%>
					<td id="b_delivery_method"><%=odto.getO_delivery_method()%> <br>(+14,000원)</td>
				<%} else {%>
					<td id="b_delivery_method"><%=odto.getO_delivery_method()%></td>
				<%}%>
				
				<!-- 배송비 
					만약 합계가 50,000원 이상이면 배송비 무료, 이하이면 배송비 3,000원 
					합계가 50,000원 이상인데 배송방법이 고속버스이면 14000원 표시
					합계가 50,000원 이하인데 배송방법이 고속버스이면 17000원 표시	
				-->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<%if(pdto.getProduct_price_sale() * odto.getO_p_amount() >= 50000 && !odto.getO_delivery_method().equals("고속버스")){%>
						<td> 배송비 무료 </td>
					<%}else if(pdto.getProduct_price_sale() * odto.getO_p_amount() >= 50000 && odto.getO_delivery_method().equals("고속버스")){%>
						<td> 14,000원 </td>
					<%}else if(pdto.getProduct_price_sale() * odto.getO_p_amount() < 50000 && odto.getO_delivery_method().equals("고속버스")){%>
						<td> 17,000원 </td>
					<%} else {%>
						<td> 3,000원 </td>
					<%}%>
				<%} else{%>
					<%if(pdto.getProduct_price_origin() * odto.getO_p_amount() >= 50000 && !odto.getO_delivery_method().equals("고속버스")){%>
						<td> 배송비 무료 </td>
					<%}else if(pdto.getProduct_price_origin() * odto.getO_p_amount() >= 50000 && odto.getO_delivery_method().equals("고속버스")){%>
						<td> 14,000원 </td>
					<%}else if(pdto.getProduct_price_origin() * odto.getO_p_amount() < 50000 && odto.getO_delivery_method().equals("고속버스")){%>
						<td> 17,000원 </td>
					<%} else {%>
						<td> 3,000원 </td>
					<%}%>
				<%}%>
				
				<!-- 합계
					(고속버스 일때 +14000하기, 아닐때는 수량과 곱하기) 
					(할인율이 있으면 세일된 가격으로 곱하기, 할인율이 없으면 원가로 곱하기) -->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<%if(odto.getO_delivery_method().equals("고속버스")) {%>
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
					<%if(odto.getO_delivery_method().equals("고속버스")) {%>
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
		
		<table border="1" class="list">
			<tr>
				<th>총 상품금액</th>
				<th>총 배송비</th>
				<th>결제 예정 금액</th>
			</tr>
			<tr>
			
				<!-- 총 상품금액 -->
				<td>
					<span><%=formatter.format(final_total_price)%></span>원 
				</td>
				
				<!-- 총 배송비 -->
				<td>
					<%
						for (int i = 0; i < orderList.size(); i++) {
							OrderDTO odto = (OrderDTO) orderList.get(i);
							ProductDTO pdto = (ProductDTO) productInfoList.get(i);
										
							if(odto.getO_delivery_method().equals("고속버스")){
								final_delivery_fee += 14000;
							}					
							
							//할인율이 있을때
							if(pdto.getProduct_discount_rate() != 0){
								//tr한줄의 총 금액이 5만원보다 적을때
								if((odto.getO_p_amount() * pdto.getProduct_price_sale()) < 50000){
									final_delivery_fee += 3000;
								}else{
									final_delivery_fee += 0;
								}
							}
							//할인율이 없을때
							else if(pdto.getProduct_discount_rate() == 0){
								//tr한줄의 총 금액이 5만원보다 적을때
								if((odto.getO_p_amount() * pdto.getProduct_price_origin()) < 50000){
									final_delivery_fee += 3000;
								}else{
									final_delivery_fee += 0;
								}
							}
						}
					%>
					<span>+<%=formatter.format(final_delivery_fee)%></span>원
				</td>
				
				<!-- 결제 에정 금액 -->
				<td>
					<span>=<%=formatter.format(final_total_price + final_delivery_fee)%></span>원
				</td>
				
			</tr>
		</table>

	<br>

	<div class="help">
		<h3>이용안내</h3>
		<div class="inner">
			<h4>장바구니 이용안내</h4>
			<ol>
				<li>해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
				<li>해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
				<li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
				<li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
				<li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
				<li>파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
			</ol>
			<h4>무이자할부 이용안내</h4>
			<ol>
				<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
				<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
				<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			</ol>
		</div>
	</div>
	
	</div>
	</div>
	
	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>

</body>
</html>
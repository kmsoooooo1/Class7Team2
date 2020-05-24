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
	
		<h2>ORDER DETAILS</h2>
		
		<h3> 주문 상품 정보 </h3>
		<table border="1" class="list">
			<tr>
				<td> 주문일자<br>[주문번호] </td>
				<td> 이미지 </td>
				<td> 상품정보 </td>
				<td> 수량 </td>
				<td> 상품구매금액 </td>
				<td> 주문처리상태 </td>
				<td> 취소/교환/반품 </td>
			</tr>
			
			<%
				if(orderList.size() == 0){
			%>
				<tr>
					<td style="text-align: center;"> 구매 내역이 없습니다. </td>
				</tr>
			<%
				}else {
			%>
			<tr>
					<td rowspan="<%=orderList.size()%>"> 
						<%=orderList.get(0).getO_date()%> <br>
						<a href="#"> [<%=orderList.get(0).getO_trade_num()%>] </a>
					</td>
			<% 
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
				
				<!-- 수량 -->
				<td>
					<%=odto.getO_p_amount()%>개 
				</td>
			
				<!-- 판매가(적립금) -->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<td><%=formatter.format(pdto.getProduct_price_sale() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>)</td>
				<%} else{%>
					<td> <%=formatter.format(pdto.getProduct_price_origin() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * odto.getO_p_amount())%>원</span>) </td>
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
				
				<td>
				 - 
				</td>
			
				</tr>
			</tr>

			<%
					}
				}
			%>
			
		</table>
		
	</div>
	</div>
	
	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>

</body>
</html>
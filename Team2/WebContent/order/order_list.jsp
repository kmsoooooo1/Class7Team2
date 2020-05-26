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
		
		List<OrderDTO> trade_num_List = (List<OrderDTO>) request.getAttribute("trade_num_List");
		
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
				<th> 주문일자<br>[주문번호] </th>
				<th> 이미지 </th>
				<th> 상품정보 </th>
				<th> 수량 </th>
				<th> 상품구매금액 </th>
				<th> 주문처리상태 </th>
				<th> 취소/교환/반품 </th>
			</tr>
			
			<%
				if(orderList.size() == 0){
			%>
				<tr>
					<td colspan="7" style="text-align: center;"> 구매 내역이 없습니다. </td>
				</tr>
			<%
				}else {
					
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
			
				<tr>
					<td class="first"> 
						<%=orderList.get(0).getO_date()%> <br>
						<a href="./OrderDetail.or?o_trade_num=<%=odto.getO_trade_num()%>"> [<%=odto.getO_trade_num()%>] </a>
					</td>
				
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
					
					<!-- 입금상태  o_status가 0이면 입금전 1이면 입금후 2이면 배송중-->
					<%if(odto.getO_status() == 0) {%>
						<td> <span style="color: red;"> 입금전 </span> </td>
					<%} else if(odto.getO_status() == 1) {%>
						<td> <span style="color: green;"> 입금완료 </span> </td>
					<%} else if(odto.getO_status() == 2) {%>
						<td> <span style="color: blue;"> 배송중 </span> </td>
					<%} else if (odto.getO_status() == 3) {%>
						<td><span style="color: black;"> 배송완료 </span></td>
					<%}%>
					
					<td>
					 - 
					</td>
				
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
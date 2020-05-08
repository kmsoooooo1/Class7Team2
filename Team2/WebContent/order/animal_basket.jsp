<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@page import="team2.basket.db.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>

	<%
		List basketList = (List) request.getAttribute("basketList");
		List animalList = (List) request.getAttribute("animalList");
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>


	<!-- 장바구니 테이블 생성 -->
	<table border="1">
		<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
		<tr>
			<td> <input type="checkbox"> </td>
			<td>이미지</td>
			<td>상품정보</td>
			<td>판매가</td>
			<td>수량</td>
			<td>적립금</td>
			<td>배송구분</td>
			<td>합계</td>
			<td>선택</td>
		</tr>
		<%
			for (int i = 0; i < basketList.size(); i++) {
				BasketDTO bkdto = (BasketDTO) basketList.get(i);
				AnimalDTO adto = (AnimalDTO) animalList.get(i);
				
				//###,###,###원 표기하기 위해서 format 바꾸기
				DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		%>
		<tr>
			<input type="hidden" id="b_code" name="b_code" value="<%=bkdto.getB_code()%>">
			<input type="hidden" id="b_option" name="b_option" value="<%=bkdto.getB_option()%>">
			<input type="hidden" id="b_delivery_method" name="b_delivery_method" value="<%=bkdto.getB_delivery_method()%>">
			
			<!-- 체크박스 -->
			<td> <input type="checkbox"> </td>
			
			<!-- 상품 이미지 -->
			<td>
				<a href='./AnimalsDetail.an?g_code=<%=bkdto.getB_code()%>'> <img src="./upload/multiupload/<%=adto.getA_thumbnail()%>" width="100" height="100"> </a>
			</td>
			
			<!-- 상품정보 (옵션이 있을때와 없을때) -->
			<%if(bkdto.getB_option().equals("")){%>
				<td>
					<%=adto.getA_morph()%>
				</td>
			<%}else{%>
				<td>
					<%=adto.getA_morph() + "<br>[옵션: " + bkdto.getB_option() + "]"%>
				</td>
			<%}%>
			
			<!-- 판매가 -->
			<%if(adto.getA_discount_rate() != 0){%>
				<td><%=formatter.format(adto.getA_price_sale())%>원</td>
			<%} else{%>
				<td><%=formatter.format(adto.getA_price_origin())%>원</td>
			<%}%>
			
			<!-- 수량 -->
			<td>
				<!-- 장바구니 수량  -->
				<input type="text" id="b_amount_<%=bkdto.getB_code()%>_<%=bkdto.getB_option()%>_<%=bkdto.getB_delivery_method()%>" name="b_amount_<%=bkdto.getB_code()%>_<%=bkdto.getB_option()%>_<%=bkdto.getB_delivery_method()%>" value="<%=bkdto.getB_amount()%>" maxlength="3" size="3">개
				<!-- 수량 +/- 버튼 -->
				<input type="button" id="amountPlus" name="amountPlus" value="+" onkeyup='plus(<%=bkdto.getB_code()%>, <%=bkdto.getB_option()%>, <%=bkdto.getB_delivery_method()%> );'>
				<input type="button" id="amountMinus" name="amountMinus" value="-"> <br>
				<button type="button" id="modibtn" name="modiBtn"> 수정 </button>
			</td>
			
			<!-- 적립금 -->
			<td> 적 <%=formatter.format(adto.getA_mileage())%>원</td>
			
			<!-- 배송방법(고속버스 일때와 아닐때 -->
			<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
				<td id="b_delivery_method"><%=bkdto.getB_delivery_method()%> <br>(+14,000원)</td>
			<%} else {%>
				<td id="b_delivery_method"><%=bkdto.getB_delivery_method()%></td>
			<%}%>
			
			<!-- 각 열의 총 합계
				(고속버스 일때 +14000하기, 아닐때는 수량과 곱하기) 
				(할인율이 있으면 세일된 가격으로 곱하기, 할인율이 없으면 원가로 곱하기) -->
			<%if(adto.getA_discount_rate() != 0){%>
				<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
					<td>
						 <%= formatter.format(adto.getA_price_sale() * Integer.parseInt(bkdto.getB_amount()) + Integer.parseInt("14000"))%>원
					</td>
				<%} else {%>
					<td>
						 <%= formatter.format(adto.getA_price_sale() * Integer.parseInt(bkdto.getB_amount()))%>원
					</td>
				<%}%>
			<%} else{%>
				<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
					<td>
						 <%= formatter.format(adto.getA_price_origin() * Integer.parseInt(bkdto.getB_amount()) + Integer.parseInt("14000"))%>원
					</td>
				<%} else {%>
					<td>
						 <%= formatter.format(adto.getA_price_origin() * Integer.parseInt(bkdto.getB_amount()))%>원
					</td>
				<%}%>
			<%}%>
			
			<td>
				<input type="button" value="주문하기"> <br> 
				<input type="button" value="관심상품 등록"> <br> 
				<input type="button" value="삭제"> <br>
			</td>
		</tr>

		<%
			}
		%>
	</table>

	<p>할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.</p>
	<hr>
	<input type="button" value="삭제하기">
	<input type="button" value="관심상품등록">
	<input type="button" value="상품 조르기">
	<input type="button" value="장바구니 비우기">
	<input type="button" value="견적서 출력">
	<br>
	<br>
	<table border="1">
		<tr>
			<td>총 상품금액</td>
			<td>총 배송비</td>
			<td>결제 예정 금액</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<br>
	<input type="button" value="전체상품주문">
	<input type="button" value="선택상품주문">
	<input type="button" value="쇼핑계속하기">
	<br>

	<table border="1">
		<tr>
			<td>이용안내</td>
		</tr>
		<td>장바구니 이용안내<br>
			<ol>
				<li>해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
				<li>해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
				<li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
				<li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
				<li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
				<li>파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
			</ol> 무이자할부 이용안내<br>
			<ol>
				<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면
					됩니다.</li>
				<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
				<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			</ol>
		</td>
	</table>


	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>
</body>

<script type="text/javascript">
		
	//증가함수 클릭시
	function plus(b_code, b_option, b_delivery_method){
		
		alert(b_code);
		alert(b_option);
		alert(b_delivery_method);
		
		var new_amount = parseInt($("#b_amount_" + b_code + b_option + b_delivery_method).val());
		
		if(new_amount == 1000) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_amount = parseInt("999");
			$("#b_amount_"+ b_code + b_option + b_delivery_method).val(new_amount);
		} else {
			new_amount += 1;
			$("#b_amount_"+ b_code + b_option + b_delivery_method).val(new_amount);
		}
	}
	
	//감소함수 클릭시
	$("#amountMinus").click(function(){
		
		var b_code = $('#b_code').val();
		var b_option = $('#b_option').val();
		var b_delivery_method = $('#b_delivery_method').val();
		
		var new_amount = parseInt($("#b_amount_" + b_code + b_option + b_delivery_method).val());
		
		if(new_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_amount = parseInt("1");
			$("#b_amount_"+ b_code + b_option + b_delivery_method).val(new_amount);
		}else {
			new_amount -= 1;
			$("#b_amount_"+ b_code + b_option + b_delivery_method).val(new_amount);
		}
	});
	
	//수정하기 버튼 클릭시
	$("#modibtn").click(function(){
		
		var b_code = $('#b_code').val();
		var b_option = $('#b_option').val();
		var b_delivery_method = $('#b_delivery_method').val();
		
		var new_amount = parseInt($("#b_amount_" + b_code + b_option + b_delivery_method).val());
		
		var confirmCheck = confirm("수량을 수정하시겠습니까?");
		
		if(confirmCheck){
			location.href="BasketModify.ba?b_amount="+$("#b_amount").val()+"&b_code="+$("#b_code").val()+"&b_option="+$("#b_option").val()+"&b_delivery_method="+$("#b_delivery_method").val();
		} else {
			location.href="BasketList.ba";
		}
	});
	
	
</script>
</html>
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
<title>Insert title here</title>
</head>
<body>

	<%
		List basketList = (List) request.getAttribute("basketList");
		List productInfoList = (List) request.getAttribute("productInfoList");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		
		int final_total_price = 0; 	//총 상품금액
		int final_delivery_fee = 0; //총 배송비
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- 장바구니 테이블 생성 -->
	CART
	<form action="" method="post" name="fr"> 
	
		<input type="hidden" id="selectedCodes" name="seletedCodes" value="">
		<input type="hidden" id="selectedOptions" name="selectedOptions" value="">  
		<input type="hidden" id="selectedDeliveryMethods" name="selectedDeliveryMethods" value="">
		
		<table border="1">
			<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
			<tr>
				<td> <input type="checkbox" id="chkBoxAll" name="chkBoxAll"> </td>
				<td>이미지</td>
				<td>상품정보</td>
				<td>판매가<br>(적립예정)</td>
				<td>수량</td>
				<td>배송구분</td>
				<td>배송비</td>
				<td>합계</td>
				<td>주문관리</td>
			</tr>
			<%
				if(basketList.size() == 0){
			
			%>
				<tr>
					<td colspan="9"> 장바구니가 비어있습니다. </td>
				</tr>
			<%
				}
				for (int i = 0; i < basketList.size(); i++) {
					BasketDTO bkdto = (BasketDTO) basketList.get(i);
					ProductDTO pdto = (ProductDTO) productInfoList.get(i);
					
					//총 상품금액 계산
					if(pdto.getProduct_discount_rate() != 0){
						final_total_price += (bkdto.getB_amount() * (pdto.getProduct_price_sale() + pdto.getProduct_option_price()));
					}else{
						final_total_price += (bkdto.getB_amount() * (pdto.getProduct_price_origin() + pdto.getProduct_option_price()));						
					}
					
					
					//b_code 값들 중에 맨 앞글자 따오기
					char first_letter = bkdto.getB_code().charAt(0);
			%>
			<tr>
				<input type="hidden" id="b_code<%=i%>" name="b_code<%=i%>" value="<%=bkdto.getB_code()%>">
				<input type="hidden" id="b_option<%=i%>" name="b_option<%=i%>" value="<%=bkdto.getB_option()%>">
				<input type="hidden" id="b_delivery_method<%=i%>" name="b_delivery_method<%=i%>" value="<%=bkdto.getB_delivery_method()%>">
				<input type="hidden" id="b_price_origin<%=i%>" name="b_price_origin<%=i%>" value="<%=pdto.getProduct_price_origin()%>">
				<input type="hidden" id="b_price_sale<%=i%>" name="b_price_sale<%=i%>" value="<%=pdto.getProduct_price_sale()%>">
				<input type="hidden" id="b_mileage<%=i%>" name="b_mileage<%=i%>" value="<%=pdto.getProduct_mileage()%>">
				<input type="hidden" id="b_discount_rate<%=i%>" name="b_discount_rate<%=i%>" value="<%=pdto.getProduct_discount_rate()%>">
				<input type="hidden" id="b_amount_<%=i%>_DB" name="b_amount_<%=i%>_DB" value="<%=pdto.getProduct_amount()%>">
				
				<!-- 체크박스 -->
				<td> <input type="checkbox" id="chkBox<%=i%>" value="<%=i%>"> </td>
				
				<!-- 상품 이미지 -->
				<!-- 상품이 동물일때 -->
				<%if(first_letter == 'a'){%>
					<td>
						<!-- 만약 해당상품의 재고가 없으면 soldout 표시뜨게 하기 -->
						<%if(pdto.getProduct_amount() == 0) {%>
							<a href='./AnimalDetail.an?a_code=<%=bkdto.getB_code()%>'> <img src="https://cdn.imweb.me/upload/58364fef00b40.jpg" width="100" height="100" style="opacity: 0.5; position: absolute; background-color: white;"> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
						<%} else {%>
							<a href='./AnimalDetail.an?a_code=<%=bkdto.getB_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
						<%}%>
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
						<!-- 만약 해당상품의 재고가 없으면 soldout 표시뜨게 하기 -->
						<%if(pdto.getProduct_amount() == 0) {%>
							<a href='./GoodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <img src="https://cdn.imweb.me/upload/58364fef00b40.jpg" width="100" height="100" style="opacity: 0.5; position: absolute; background-color: white;"> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
						<%} else {%>
							<a href='./GoodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
						<%}%>
					</td>
					
					<!-- 상품정보 (옵션이 있을때와 없을때) -->
					<%if(bkdto.getB_option().equals("")){%>
						<td>
							<a href='./GoodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name()%> </a>
						</td>
					<%}else{%>
						<td>
							<a href='./GoodsDetail.go?g_code=<%=bkdto.getB_code()%>'> <%=pdto.getProduct_name() + "<br>[옵션: " + bkdto.getB_option() + "]"%> </a>
						</td>
					<%}%>
				<%}%>
				
				
			
				<!-- 판매가(적립금) -->
				<%if(pdto.getProduct_discount_rate() != 0){%>
					<td><%=formatter.format(pdto.getProduct_price_sale() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>)</td>
				<%} else{%>
					<td> <%=formatter.format(pdto.getProduct_price_origin() + pdto.getProduct_option_price())%>원 <br> (적 <span id="total_product_mileage<%=i%>"><%=formatter.format(pdto.getProduct_mileage() * bkdto.getB_amount())%>원</span>) </td>
				<%}%>
				
				<!-- 수량 -->
				<td>
					<!-- 장바구니 수량  --> 
					<input type="text" id="b_amount<%=i%>" name="b_amount<%=i%>" value="<%=bkdto.getB_amount()%>" maxlength="3" size="3"  onchange='amountChange(<%=i%>)'>개
					<!-- 수량 +/- 버튼 -->
					<input type="button" id="amountPlus" name="amountPlus" value="+" onclick='plus(<%=i%>);'>
					<input type="button" id="amountMinus" name="amountMinus" value="-" onclick='minus(<%=i%>)'> <br>
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
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * (bkdto.getB_amount()) + Integer.parseInt("14000"))%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * (bkdto.getB_amount()) + Integer.parseInt("14000")%>">
						</td>
					<%} else {%>
						<td>
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * bkdto.getB_amount())%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_sale() + pdto.getProduct_option_price()) * bkdto.getB_amount()%>">
						</td>
					<%}%>
				<%} else{%>
					<%if(bkdto.getB_delivery_method().equals("고속버스")) {%>
						<td>
							 <span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * (bkdto.getB_amount()) + Integer.parseInt("14000"))%>원</span>
							 <input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * bkdto.getB_amount()) + Integer.parseInt("14000")%>">
						</td>
					<%} else {%>
						<td>
							<span id="total_product_price<%=i%>"> <%= formatter.format((pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * (bkdto.getB_amount()))%>원</span>
							<input type="hidden" id="total_product_price<%=i%>_input" name="total_product_price<%=i%>_input" value="<%=(pdto.getProduct_price_origin() + pdto.getProduct_option_price()) * bkdto.getB_amount()%>">
						</td>
					<%}%>
				<%}%>
				
				<td>
					<input type="button" value="삭제하기" onclick='deleteCell(this, <%=i%>);'> <br>
				</td>
			</tr>
	
			<%
				}
			%>
		</table>
		<button type="button" onclick="deleteSoldout()"> 품절삭제 </button>
		<button type="button" onclick="deleteSelected()"> 선택삭제 </button>
		
		<hr>
		
		<table border="1">
			<tr>
				<td>총 상품금액</td>
				<td>총 배송비</td>
				<td>결제 예정 금액</td>
			</tr>
			<tr>
			
				<!-- 총 상품금액 -->
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
				
				<!-- 결제 에정 금액 -->
				<td>
					<span>=<%=formatter.format(final_total_price + final_delivery_fee)%></span>원
				</td>
				
			</tr>
		</table>
		<br>
		<button type="button" onclick="orderAll();"> 전체상품주문 </button>
		<button type="button" onclick="orderSelected();"> 선택상품주문 </button>
		<input type="button" value="쇼핑계속하기">
	</form>
	
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

	//장바구니 페이지가 처음 로딩되었을때 세팅하기
	$(document).ready(function(){
		
		//전체체크박스 제어
		$("#chkBoxAll").prop('checked', true);
	
		var check = $("#chkBoxAll").is(":checked"); //최상위 체크박스 체크여부
		//만약 최상위 체크박스가 체크되어있으면 전체 선택
		if(check){
			$("input[type='checkbox']").prop('checked', true);
		}
		//만약 최상위 체크박스가 체크되어있으면 전체 해제
		else{
			$("input[type='checkbox']").prop('checked', false);
		}
	});
	
	//장바구니 리스트 가져오기
	var basketList = [];
	<c:forEach items="${basketList}" var="basketList">
		basketList.push("${basketList}");
	</c:forEach>	
	
	//체크박스 제어 ----------------------------------------------------------------------------------------------------
	
	//사용자가 최상위 체크박스를 선택했을시 모든 체크박스 선택되게 하는 함수
	$("#chkBoxAll").click(function(){
		var check = $(this).is(":checked");
		//만약 최상위 체크박스가 체크되어있으면 전체 선택
		if(check){
			$("input[type='checkbox']").prop('checked', true);
		}
		//만약 최상위 체크박스가 체크되어있으면 전체 해제
		else{
			$("input[type='checkbox']").prop('checked', false);
		}
	});
	
	//정보 수정 제어 --------------------------------------------------------------------------------------------------
	//수량 수정했을때 호출되어야하는 함수
	function amountAjax(id_number){
		//DB에 접근하여 해당코드와 동일한 데이터 수량 수정하기
		$.ajax({
			type:'get',
			url:'./BasketModify.ba',
			data:'b_amount='+$('#b_amount'+id_number).val() + '&b_code='+$('#b_code'+id_number).val()+'&b_option='+$('#b_option'+id_number).val()+'&b_delivery_method='+$('#b_delivery_method'+id_number).val(),
			dataType: 'html',
			success:function(data) {
   				window.location.reload(); //현재 페이지 새로고침
   			},error:function(request,status,error){
			 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	}
	
	//총 상품금액 나타내게 하는 함수
	function changeTotalAmount(id_number){
		var total_product_price = document.getElementById('total_product_price' + id_number + '_input').value;
	}
	
	//사용자가 키보드로 수량을 수정했을시
	function amountChange(id_number){
		
		var new_amount = parseInt($("#b_amount" + id_number).val()); 	//사용자가 새로 수정하는 수량
		
		//사용자가 키보드로 input에 0보다 작은수를 입력했을시
		if(new_amount < 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_amount = parseInt("1");
			$("#b_amount" + id_number).val(new_amount);
		} else{
			//DB에 들어가서 수량 수정하는 함수 호출
			amountAjax(id_number);	
		}
		
		//업데이트된 총 상품금액 나타내게 하는 함수
		changeTotalAmount(id_number);
	}
	
	//사용자가 '+'를 눌렸을시
	function plus(id_number){
		
		//현재 상품의 수량이 0이면 재고부족 alert 띄우기
		if($('#b_amount_' + id_number + '_DB').val() == 0){
			alert("재고가 부족합니다.");
		} else{
			var new_amount = parseInt($("#b_amount" + id_number).val()); 	//사용자가 새로 수정하는 수량
			
			//사용자가 수량 999에서 +를 눌렀을시
			if(new_amount == 999) {
				alert("상품의 최대 구매량은 999개입니다.");
				new_amount = parseInt("999");
				$("#b_amount" + id_number).val(new_amount);
			} else {
				new_amount++;
				$("#b_amount" + id_number).val(new_amount);
				
				//DB에 들어가서 수량 수정하는 함수 호출
				amountAjax(id_number);
			}
			//업데이트된 총 상품금액 나타내게 하는 함수
			changeTotalAmount(id_number);
		}
	}
	
	//사용자가 '-'를 눌렸을시
	function minus(id_number){
		
		var new_amount = parseInt($("#b_amount" + id_number).val()); 	//사용자가 새로 수정하는 수량
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_a_amount = parseInt("1");
			$("#b_amount" + id_number).val(new_amount);
		} else {
			new_amount--;
			$("#b_amount" + id_number).val(new_amount);
			
			//DB에 들어가서 수량 수정하는 함수 호출
			amountAjax(id_number);
		}
		//업데이트된 총 상품금액 나타내게 하는 함수
		changeTotalAmount(id_number);
	}
	
	//사용자가 상품정보를 제거했을시
	function deleteCell(obj, id_number){
		//삭제 여부 물어보기
		var checkDelete = confirm("상품을 삭제 하시겠습니까?");
		if(checkDelete){
			//DB에 접근하여 해당코드와 동일한 데이터 삭제하기
			$.ajax({
				type:'get',
				url:'./BasketDelete.ba',
				data:'b_code='+$('#b_code'+id_number).val()+'&b_option='+$('#b_option'+id_number).val()+'&b_delivery_method='+$('#b_delivery_method'+id_number).val(),
				dataType: 'html',
				success:function(data) {
	   				window.location.reload(); //현재 페이지 새로고침
	   			},error:function(request,status,error){
				 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		} else {
			return false;
		}
	}
	
	//사용자가 품절삭제 버튼을 눌렸을때 호출되는 함수
	function deleteSoldout() {
		
		//만약 장바구니가 비어있으면 alert 뜨게 하기
		if(basketList.length == 0){
			alert("장바구니가 비어있습니다.");
		}
		
		//사용자에게 삭제 여부 물어보기
		var checkDelete = confirm("품절상품을 삭제하시겠습니까?");
		
		if(checkDelete){
			//장바구니에 담긴 모든 상품 한번 훑어보기
			for(var i=0; i<basketList.length; i++){
			
				var checkAmount = $('#b_amount_' + i + '_DB').val(); //DB에 들어가있는 실제 재고량
				
				//재고량이 0이면 해당 상품 장바구니에서 삭제 시키기
				if(checkAmount == 0){
					(function(i) {
						$.ajax({
							type:'get',
							url:'./BasketDelete.ba',
							data:'b_code='+$('#b_code'+i).val()+'&b_option='+$('#b_option'+i).val()+'&b_delivery_method='+$('#b_delivery_method'+i).val(),
							dataType: 'html',
							async: false,
							success:function(data) {

				   			},error:function(request,status,error){
							 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
							}
						});
					})(i);
				}
			}
			window.location.reload(); //현재 페이지 새로고침	
		}else{
			return false;
		}
	}
	
	//사용자가 선택삭제 버튼을 눌렸을때 호출되는 함수
	function deleteSelected() {
		
		//만약 장바구니가 비어있으면 alert 뜨게 하기
		if(basketList.length == 0){
			alert("장바구니가 비어있습니다.");
		}
		
		//사용자에게 삭제 여부 물어보기
		var checkDelete = confirm("선택한 상품을 삭제하시겠습니까?");
		
		if(checkDelete){
			//장바구니에 담긴 모든 상품 한번 훑어보기
			for(var i=0; i<basketList.length; i++){
				//각열의 체크박스가 체크되어 있으면 true 아니면 false
				if(document.getElementById('chkBox'+i).checked){
					(function(i) {
						$.ajax({
							type:'get',
							url:'./BasketDelete.ba',
							data:'b_code='+$('#b_code'+i).val()+'&b_option='+$('#b_option'+i).val()+'&b_delivery_method='+$('#b_delivery_method'+i).val(),
							dataType: 'html',
							async: false,
							success:function(data) {
				   				
				   			},error:function(request,status,error){
							 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
							}
						});
					})(i);
				}
			}
			window.location.reload(); //현재 페이지 새로고침	
		}else{
			return false;
		}
	}
	
	//사용자가 전체상품 주문하기를 눌렸을때 호출되는 함수
	function orderAll() {
		
		//만약 장바구니가 비어있으면 alert 뜨게 하기
		if(basketList.length == 0){
			alert("장바구니가 비어있습니다.");
		}
		
		//장바구니에 담긴 모든 상품 한번 훑어보기
		for(var i=0; i<basketList.length; i++){
			
			var checkAmount = $('#b_amount_' + i + '_DB').val(); //DB에 들어가있는 실제 재고량
			//재고량이 0이면 해당 상품 장바구니에서 삭제 시키기
			if(checkAmount == 0){
				var checkSoldout = confirm("선택하신 제품들 중 품절 등의 사유로 주문이 불가합니다. \n주문불가 상품을 제외하고 상품을 주문하시겠습니까?");
				if(checkSoldout){
					//품절된 상품이 있는지 없는지 체크하고 있으면 품절상품 자동으로 삭제
					deleteSoldout();
					//구매 전 정보 입력창으로 이동하기
					location.href='./OrderStar.or';
				}
				else{
					return false;
				}
				return false;
			}
			else{
				//구매 전 정보 입력창으로 이동하기
				location.href='./OrderStar.or';
			}
		}
	}
	
	var selectedCodes = ""; 			//사용자가 장바구니에서 선택한 상품 코드들 차례대로 담는 변수
	var selectedOptions = ""; 			//사용자가 장바구니에서 선택한 상품 옵션들 차례대로 담는 변수
	var selectedDeliveryMethods = ""; 	//사용자가 장바구니에서 선택한 상품 배송방법 차례대로 담는 변수
	
	//사용자가 선택한상품 주문하기를 눌렀을때 호출되는 함수
	function orderSelected(){
		
		//만약 장바구니가 비어있으면 alert 뜨게 하기
		if(basketList.length == 0){
			alert("장바구니가 비어있습니다.");
		}
		
		//장바구니에 담긴 모든 상품 한번 훑어서 selected 된 값만 input hidden 값에 넣기
		for(var i=0; i<basketList.length; i++){
			//각열의 체크박스가 체크되어 있으면 true 아니면 false
			if(document.getElementById('chkBox'+i).checked){
				//selectedCodes 안에 사용자가 선택한 codes들 담기
				selectedCodes += ($('#b_code'+i).val() + ", ");
				selectedOptions += ($('#b_option'+i).val() + ", ");
				selectedDeliveryMethods += ($('#b_delivery_method'+i).val() + ", ");
			} 
		}
		
		//추가된 values 변수를 태그에 담기
		document.getElementById("selectedCodes").value = selectedCodes;
		document.getElementById("selectedOptions").value = selectedOptions;
		document.getElementById("selectedDeliveryMethods").value = selectedDeliveryMethods;
		
 		document.fr.action="./OrderStarSelected.or";
 		document.fr.submit();

	}
	

	
</script>
</html>
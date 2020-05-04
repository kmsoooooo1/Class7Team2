<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title> 테스트 </title>
</head>
<body>

	<%
		String id = (String) session.getAttribute("id");
		if(id == null){
			id = "";
		}
	
		//AnimalDetailAction 객체에서 저장된 정보를 저장 
		AnimalDTO animalDetail = (AnimalDTO) request.getAttribute("animalDetail");
	
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price_origin = formatter.format(animalDetail.getA_price_origin());
		String newformat_mileage = formatter.format(animalDetail.getA_mileage());
		String newformat_price_sale = formatter.format(animalDetail.getA_price_sale());
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<form action="" method="post" name="fr"> 
		
		<!-- 상품 기본 정보 파트 ------------------------------------------------------------------------------------------ -->
		<div id="menu0">
			<!-- hidden 값들(코드, 오리지날 판매가, 할인된 판매가, 할인율, 모프, 적립금  -->
			<input type="hidden" name="a_code" value="<%=animalDetail.getA_code()%>">
			<input type="hidden" id="a_price_origin" name="a_price_origin" value="<%=animalDetail.getA_price_origin()%>">
			<input type="hidden" id="a_price_sale" name="a_price_sale" value="<%=animalDetail.getA_price_sale()%>">
			<input type="hidden" id="a_discount_rate" name="a_discount_rate" value="<%=animalDetail.getA_discount_rate()%>">
			<input type="hidden" id="a_morph" name="a_morph" value="<%=animalDetail.getA_morph()%>">
			<input type="hidden" id="a_mileage" name="a_mileage" value="<%=animalDetail.getA_mileage()%>">
		
			<table border="0">
				<tr>
					<td> <img src="./upload/multiupload/<%=animalDetail.getA_thumbnail()%>" width="500" height="500"> </td>
					<td>
						<!-- 종 이름 -->
						<%if(animalDetail.getA_amount() == 0){%>
							<span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span>
							<h4> <%=animalDetail.getA_morph()%> </h4>
						<%}else{%>
							<h4> <%=animalDetail.getA_morph()%> </h4>
						<%}%>
						<hr>
						<!-- 판매가, 적립금, 할인판매가 -->
						<table border="1">
							<tr>
								<td> 판매가 </td>
								<td> 
									<%=newformat_price_origin%>원 
									<% if(animalDetail.getA_discount_rate() != 0) {//만약 할인율이 있으면 %> 
										<%=animalDetail.getA_discount_rate()%>% OFF 
									<%}%> 
								</td> 
							</tr>
							<tr>
								<td> 적립금 </td>
								<td> <%=newformat_mileage%>원 </td>
							</tr>
							<% if(animalDetail.getA_discount_rate() != 0) {//만약 할인율이 있으면 %> 
							<tr>
								<td> 할인판매가  </td>
								<td> <%=newformat_price_sale%>원 (<%=animalDetail.getA_discount_rate()%>% 할인율) </td>
							</tr>
							<%}%>
						</table> 
						<hr>
						<!-- 배송방법 -->
						배송방법
							<select id="delivery_method" name="delivery_method" onchange="changeDeliMethod();">
								<option value="default"> -[필수]배송방법을 선택해 주세요 - </option>
								<option value="default"> --------------- </option>
								<option value="일반포장"> 일반포장 </option>
								<option value="퀵서비스"> 퀵서비스(착불) </option>
								<option value="지하철"> 지하철택배(착불) </option>
								<option value="고속버스"> 고속버스택배 (+14,000원) </option>
								<option value="매장방문"> 매장방문수령 </option>				
							</select>  
						<hr>
						<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
						<table border="1">
							<tr>
								<td> 상품명 </td>
								<td> 상품수 </td>
								<td> 가격 </td>
							</tr>
							<!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
							<tbody id="final_product_info_table"><span id="delivery_method_option"></span></tbody>

							<tr>
								<td colspan="3"> TOTAL : <span id="total_price"></span>원 (<span id="total_amount"></span>개) </td>
							</tr>
						</table>
						<hr>
						<%if(animalDetail.getA_amount() == 0){%>
							<span> 품절 </span>
							<button type="button"> 관심상품 </button>
							<br>
							<button type="button"> 카카오톡 상담 </button>
						<%}else{%>
							<button type="button"> <a href="javascript:valueOrderChecked()"> 바로구매 </a> </button>
							<button type="button"> <a href="javascript:valueBasketChecked()"> 장바구니 </a> </button>
							<button type="button"> 관심상품 </button>
							<br>
							<button type="button"> 카카오톡 상담 </button>
						<%}%>
					</td>
				</tr>
			</table>
		</div>

		<br>
		<hr>
	</form>
	
	<!-- 상품 관련 상품들 파트 ------------------------------------------------------------------------------------------ -->
	<div id="menu2">
		<div>
			RECOMMEND ITEMS <br>
			본 상품의 구매자 분들은 아래 상품들도 함께 구매하셨습니다.
		</div>
	</div>
	
	<br>
	<hr>
		
	<!-- 상품 상세 정보 파트 ------------------------------------------------------------------------------------------ -->
	<div id="menu1">
		<!-- 소메뉴 -->
		<div>
			<ul style="list-style: none;">
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('0')"> 기본 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('1')"> 디테일 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('2')"> 추천 상품 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('3')"> REVIEW </button> </li>
				<li> <button onclick="menuMove('4')"> Q & A </button> </li>
			</ul>
		</div>
	
		<p> <%=animalDetail.getContent()%> </p>
	</div>
	
	<br>
	<hr>

	<!-- 상품 REVIEW 파트 -------------------------------------------------------------------------------------------->
	<div id="menu3">
		<!-- 소메뉴 -->
		<div>
			<ul style="list-style: none;">
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('0')"> 기본 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('1')"> 디테일 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('2')"> 추천 상품 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('3')"> REVIEW </button> </li>
				<li> <button onclick="menuMove('4')"> Q & A </button> </li>
			</ul>
		</div>
		
		REVIEW <br>
		상품의 사용후기를 적어주세요.
		<table border="1">
			<tr>
				<td> 
					제목: 잘받았습니다. <br>
					내용: 꼼꼼히 싸주시고 좋습니다. 
				</td> 
				<td>
					작성자: testID
				</td>
				<td>
					작성날짜: 2020-04-30
				</td>
			</tr>
		</table>
		<button type="button"> 리뷰작성 </button>
		<button type="button"> 모두보기 </button>
	</div>
	
	<br>
	<hr>
	
	<!-- 상품 Q&A 파트 ------------------------------------------------------------------------------------------ -->
	<div id="menu4">
		<!-- 소메뉴 -->
		<div>
			<ul style="list-style: none;">
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('0')"> 기본 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('1')"> 디테일 정보 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('2')"> 추천 상품 </button> </li>
				<li style="float: left; margin-right: 10px;"> <button onclick="menuMove('3')"> REVIEW </button> </li>
				<li> <button onclick="menuMove('4')"> Q & A </button> </li>
			</ul>
		</div>
	
		Q & A <br>
		상품에 대해 궁금한 점을 해결해 드립니다. 
		<table border="1">
			<tr>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 작성자 </td>
				<td> 작성일 </td>
				<td> 조회 </td>
			</tr>
			<tr>
				<td> 41 </td>
				<td> 질문[1] </td>
				<td> 김민수 </td>
				<td> 2020-04-27 </td>
				<td> 8 </td>
			</tr>
			<tr>
				<td> 40 </td>
				<td> 질문2[2] </td>
				<td> 김민수 </td>
				<td> 2020-04-27 </td>
				<td> 9 </td>
			</tr>
		</table>
		<button type="button">상품문의하기</button>
		<button type="button">모두보기</button>
	</div>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
<script type="text/javascript">

	//사용자가 배송방법을 선택했을시------------------------------------------------------------------------------
	function changeDeliMethod(){
		
		var a_morph = document.getElementById('a_morph').value;					//모프
		var a_price_origin = document.getElementById('a_price_origin').value;	//오리지날 판매가
		var a_discount_rate = document.getElementById('a_discount_rate').value;	//할인율
		var a_price_sale = document.getElementById('a_price_sale').value;		//할인된 판매가
		var a_mileage = document.getElementById('a_mileage').value;				//적립금
		
		var delivery_method = document.getElementById('delivery_method').value;	//배송방법
		
		var objRow;
		objRow = document.all["final_product_info_table"].insertRow();
		
		//배송방법을 선택했을시 선택한 항목 selected으로 바꾸기
		$('#delivery_method option[value="'+ delivery_method +'"]').attr('selected', true);
		
		var delivery_method_option = document.getElementById('delivery_method_option').value;
		if(delivery_method_option == undefined) { //배송방법이 정의되지 않았다면
			delivery_method_option = ""; //빈 공백 추가
		}
		
		//배송방법이 selected 된 option 체크하는 each 구문
		$('#delivery_method option').each(function() {
			//만약 옵션의 값과 
			
		});
		
		
		//배송방법 항목 가지고 오기
		var delivery_method = document.getElementById('delivery_method').value;
		//사용자가 올바른 배송방법을 선택 하지 않았을시
		if(delivery_method == "default"){
			document.getElementById("final_product_info_table").style.display = "none";
		}
		//사용자가 올바른 배송방법을 선택했을시 새로운 cell 추가하기
		else {
			//모프 - 첫번째 td(cell) 항목
			var objCell_morph = objRow.insertCell();
			objCell_morph.innerHTML = "<span>" + a_morph + "</span> <br>" + "<span id='delivery_method_option'>[옵션:" + delivery_method + "]</span>";
			
			//상품수 - 두번째 td(cell) 항목
			var objCell_amount = objRow.insertCell();
			objCell_amount.innerHTML = "<input type='text' id='a_amount' name='a_amount' value='1' maxlength='3' size='3' onchange='amountChange();'>" 
										+ " <input type='button' id='amountPlus' name='amountPlus' value='+' onclick='plus();'> " 
										+ " <input type='button' id='amountMinus' name='amountMinus' value='-' onclick='minus();'> ";		
			
			//가격, 적립금 - 세번째 td(cell) 항목
			var objCell_price = objRow.insertCell();
				//만약 적립금이 0이 아니면
				if(a_discount_rate != 0){
					objCell_price.innerHTML = "<span id='total_product_price'>" 
											+ a_price_sale.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "<span id='total_product_mileage'>(적" + a_mileage + "원)</span>";
				}
				//만약 적립금이 0이면
				else{
					objCell_price.innerHTML = "<span id='total_product_price'>" 
											+ a_price_origin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "<span id='total_product_mileage'>(적" + a_mileage + "원)</span>";
				}
			
			//만약 최종 상품 정보에 정보가 추가되어있으면(같은 배송방법으로 추가되면 이라는 말과 같음)
// 			var delivery_method = document.getElementById('delivery_method').value; //추가되어있는 td안에 옵션(배송정보) 값
// 			if(delivery_method)
		}
	}

	//주문수량 변경시----------------------------------------------------------------------------------------
	var a_price_origin = document.getElementById('a_price_origin').value;	//오리지날 판매가
	var a_discount_rate = document.getElementById('a_discount_rate').value;	//할인율
	var a_price_sale = document.getElementById('a_price_sale').value;		//할인된 판매가
	
	var final_price;	//수정된 수량 * 금액 = 최종금액
	
	//주문 전 수량 변경시 함수(키보드로 입력시)
	function amountChange(){
		var new_a_amount = document.getElementById('a_amount').value;	//사용자가 새로 수정하는 수량
		//사용자가 키보드로 input에 0보다 작은수를 입력했을시
		if(new_a_amount < 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_a_amount = parseInt("1");
			$("#a_amount").val(new_a_amount);
		}
	}
	
	//사용자가 '+'를 눌렸을시
	function plus(){
		var new_a_amount = document.getElementById('a_amount').value;	//사용자가 새로 수정하는 수량
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_a_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_a_amount = parseInt("999");
			$("#a_amount").val(new_a_amount);
		}else {
			new_a_amount++;
			$("#a_amount").val(new_a_amount);
			//만약 할인율(a_discount_rate)이 0이 아니면
			if(a_discount_rate != 0) {
				//할인된 판매가로 최종 판매가 계산하기
				final_price = a_price_sale * new_a_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
			}
			//할인율이 0이면
			else{
				//오리지날 판매가로 최종 판매가 계산하기
				final_price = a_price_origin * new_a_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
		}
	}
	
	//사용자가 '-'를 눌렸을시
	function minus(){
		var new_a_amount = document.getElementById('a_amount').value;	//사용자가 새로 수정하는 수량
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_a_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_a_amount = parseInt("1");
			$("#a_amount").val(new_a_amount);
		}else {
			new_a_amount--;
			$("#a_amount").val(new_a_amount);
			//만약 할인율(a_discount_rate)이 0이 아니면
			if(a_discount_rate != 0) {
				//할인된 판매가로 최종 판매가 계산하기
				final_price = a_price_sale * new_a_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
			//할인율이 0이면
			else{
				//오리지날 판매가로 최종 판매가 계산하기
				final_price = a_price_origin * new_a_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
		}
	}
	
	//구매하기, 장바구니 버튼 눌렸을시 ------------------------------------------------------------------------------------

	//장바구니 버튼을 클릭했을시
	function valueBasketChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == "default"){
			alert("배송옵션을 선턱해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("장바구니에 담으시겠습니까?");
			if(isBasket) {
				document.fr.action="";
				document.fr.submit();
			} else {
				return false;
			}
		}
	}
	
	//구매하기 버튼을 클릭했을시
	function valueOrderChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == "default"){
			alert("배송옵션을 선턱해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("구매하시겠습니까?");
			if(isBasket) {
				document.fr.action="";
				document.fr.submit();
			} else {
				return false;
			}
		}
	}
	
	//소메뉴 눌렸을시 ------------------------------------------------------------------------------------
	
	//소메뉴에서 클릭했을시 특정 div로 스크롤 이동시키는 함수 ex) 기본 정보 눌렸을시 기본정보div로 이동하기
	function menuMove(seq){
        var offset = $("#menu" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 300);
    }
	
	
</script>
</html>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");
		if(id == null){
			id = "";
		}
		
		GoodsDTO goodsDetail = (GoodsDTO) request.getAttribute("goodsDetail");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price_origin = formatter.format(goodsDetail.getG_price_origin());
		String newformat_mileage = formatter.format(goodsDetail.getG_mileage());
		String newformat_price_sale = formatter.format(goodsDetail.getG_price_sale());
		
	%>
	
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<form action="" method="post" name="fr">
	   <!-- 상품 기본 정보 파트 -->
	   <div id="menu0">
	      <!-- hidden 값들(코드, 오리지날 판매가, 할인된 판매가, 할인율  -->
	      <input type="hidden" name="g_code" value="<%=goodsDetail.getG_code()%>">
	      <input type="hidden" id="g_price_origin" name="g_price_origin" value="<%=goodsDetail.getG_price_origin()%>">
	      <input type="hidden" id="g_price_sale" name="g_price_sale" value="<%=goodsDetail.getG_price_sale()%>">
		  <input type="hidden" id="g_discount_rate" name="g_discount_rate" value="<%=goodsDetail.getG_discount_rate()%>">
		  
		  <table border="0">
		     <tr>
		     	<td> <img src="./upload/multiupload/<%=goodsDetail.getG_thumbnail()%>" width="500" height="500"> </td>
		        <td>
		        	<!-- 상품명 -->
		        	<%if(goodsDetail.getG_amount() == 0){ %>
		        	  <span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span>
		        	  <h4> <%=goodsDetail.getG_name() %> </h4>
		        	<%}else{ %>
		        	  <h4> <%=goodsDetail.getG_name() %> </h4>
		        	<%} %>    
		        	
		        	<hr>
		        	
		        	<!-- 판매가, 적립금, 할인판매가 -->
		        	<table border="1">
		        	  <tr>
		        	    <td> 판매가 </td>
		        	    <td>
		        	       <%=newformat_price_origin%>원 
		        	       <%if(goodsDetail.getG_discount_rate() != 0){ //할인율 있으면 %>
		        	          <%=goodsDetail.getG_discount_rate() %>% OFF
		        	       <%} %>   
		        	    </td>
		        	  </tr>
		        	  
		        	  <tr>
		        	    <td> 적립금 </td>
		        	    <td> <%=newformat_mileage%>원 </td>
		        	  </tr>
		        	  
		        	  <%if(goodsDetail.getG_discount_rate() != 0){ //할인율 있으면 %>
		        	  <tr>
		        	     <td> 할인판매가 </td>
		        	     <td> <%=newformat_price_sale%>원 (<%=goodsDetail.getG_discount_rate() %>% 할인율) </td>
		        	  </tr>
		        	  <%} %>
		        	</table>
		        	
		        	<hr>
		        	
		        	<!-- 배송(일반배송, 선택배송) 구분 -->
		        	<!-- 일반 배송일 때, -->
		        	<%if(goodsDetail.getG_delivery().equals("일반배송")){ %>
		        	<table border="1">
		        	<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
		        	  <tr>
		        	    <td> 상품명 </td>
		        	    <td> 상품수 </td>
		        	    <td> 가격 </td>
		        	  </tr>
		        	  <!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
		        	  <div id="final_product_info">
		        	    <tr>
		        	      <td> <%=goodsDetail.getG_name() %> </td>
		        	      <td>
		        	        <!-- 주문 전 수량 -->
		        	        <input type="text" id="g_amount" name="g_amount" value="1" maxlength="3" size="3" onchange="amountChange();">
		        	        <!-- 수량 +,- 버튼 -->
		        	        <input type="button" id="amountPlus" name="amountPlus" value="+" onclick="plus();">  
		        	        <input type="button" id="amountMinus" name="amountMinus" value="-" onclick="minus();">  
		        	      </td>
		        	      <td>
		        	        <span id="total_product_price">
		        	          <%if(goodsDetail.getG_discount_rate() != 0){%>
		        	            <%=goodsDetail.getG_price_sale() %>원
		        	          <%}else{ %>
		        	            <%=goodsDetail.getG_price_origin() %>원 
		        	          <%} %>   
		        	        </span> <br>
		        	        <span id="total_product_mileage">적 <%=goodsDetail.getG_mileage() %>원  </span>
		        	      </td>
		        	    </tr>
		        	  </div>
		        	  
		        	  <tr>
						<td colspan="3"> TOTAL : <span id="total_price"></span>원 (<span id="total_amount"></span>개) </td>
					  </tr>
		        	
		        	</table>
		        	<%}else{ %>
		        	<!-- 선택 배송일 때, -->
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
        	  		
        	  		<table border="1">
		        	<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
		        	  <tr>
		        	    <td> 상품명 </td>
		        	    <td> 상품수 </td>
		        	    <td> 가격 </td>
		        	  </tr>
		        	  <!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
		        	  <div id="final_product_info">
		        	    <tr>
		        	      <td> <%=goodsDetail.getG_name() %> </td>
		        	      <td>
		        	        <!-- 주문 전 수량 -->
		        	        <input type="text" id="g_amount" name="g_amount" value="1" maxlength="3" size="3" onchange="amountChange();">
		        	        <!-- 수량 +,- 버튼 -->
		        	        <input type="button" id="amountPlus" name="amountPlus" value="+" onclick="plus();">  
		        	        <input type="button" id="amountMinus" name="amountMinus" value="-" onclick="minus();">  
		        	      </td>
		        	      <td>
		        	        <span id="total_product_price">
		        	          <%if(goodsDetail.getG_discount_rate() != 0){%>
		        	            <%=goodsDetail.getG_price_sale() %>원
		        	          <%}else{ %>
		        	            <%=goodsDetail.getG_price_origin() %>원 
		        	          <%} %>   
		        	        </span> <br>
		        	        <span id="total_product_mileage">적 <%=goodsDetail.getG_mileage() %>원  </span>
		        	      </td>
		        	    </tr>
		        	  </div>
		        	  
		        	  <tr>
						<td colspan="3"> TOTAL : <span id="total_price"></span>원 (<span id="total_amount"></span>개) </td>
					  </tr>
		        	
		        	</table>
		        	
		        	<%} %>
		        	
		        	<hr>
		        	
		        	<%if(goodsDetail.getG_amount() == 0){ %>
		        	    <span> 품절 </span>
		        	    <button type="button"> 관심상품 </button>
					    <br>
					    <button type="button"> 카카오톡 상담 </button>
		        	<%}else{ %>
		        	    <button type="button"> <a href="javascript:valueOrderChecked()"> 바로구매 </a> </button>
						<button type="button"> <a href="javascript:valueBasketChecked()"> 장바구니 </a> </button>
						<button type="button"> 관심상품 </button>
						<br>
						<button type="button"> 카카오톡 상담 </button>
		        	<%} %>
		        
		        </td>
		     </tr>
		  </table>
	   </div>
	   
	   <br>
	   <hr>
	</form>

	<!-- 상품 관련 상품들 파트 ---------------------------------------------------------------------->
	<div id="menu2">
		<div>
			RECOMMEND ITEMS <br>
			본 상품의 구매자 분들은 아래 상품들도 함께 구매하셨습니다.
		</div>
	</div>

	<br>
	<hr>
	
	<!-- 상품 상세 정보 파트 ----------------------------------------------------------------------------->
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
	
		<p> <%=goodsDetail.getContent()%> </p>
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
	
	<!-- 상품 Q&A 파트 ------------------------------------------------------------>
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

	//사용자가 배송방법을 선택했을시
	function changeDeliMethod(){
		
	}

	//주문수량 변경 시
	var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
	var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
	var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가

	var final_price;	//수정된 수량 * 금액 = 최종금액
	
	//주문 전 수량 변경시 함수(키보드로 입력시)
	function amountChange(){
		var new_g_amount = document.getElementById('g_amount').value;	//사용자가 새로 수정하는 수량
		
		//사용자가 키보드로 input에 0보다 작은수를 입력했을시
		if(new_g_amount < 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount").val(new_g_amount);
		}
	}
	
	//사용자가 '+'를 눌렸을시
	function plus(){
		var new_g_amount = document.getElementById('g_amount').value;	//사용자가 새로 수정하는 수량
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_g_amount = parseInt("999");
			$("#g_amount").val(new_g_amount);
		}else {
			new_g_amount++;
			$("#g_amount").val(new_g_amount);
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				//할인된 판매가로 최종 판매가 계산하기
				final_price = g_price_sale * new_g_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
			//할인율이 0이면
			else{
				//오리지날 판매가로 최종 판매가 계산하기
				final_price = g_price_origin * new_g_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}

		}
	}
	
	//사용자가 '-'를 눌렸을시
	function minus(){
		var new_g_amount = document.getElementById('g_amount').value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_g_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount").val(new_g_amount);
		}else {
			new_g_amount--;
			$("#g_amount").val(new_g_amount);
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				//할인된 판매가로 최종 판매가 계산하기
				final_price = g_price_sale * new_g_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
			//할인율이 0이면
			else{
				//오리지날 판매가로 최종 판매가 계산하기
				final_price = g_price_origin * new_g_amount;
				//계산된 값 span 태그에 넣기
				document.getElementById("total_product_price").innerHTML = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			}
		}
	}	
	
	//구매하기, 장바구니 버튼 눌렸을시 ------------------------------------------
	
	//장바구니 버튼을 클릭했을시
	function valueBasketChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == "default"){
			alert("배송옵션을 선택해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("장바구니에 담으시겠습니까?");
			if(isBasket) {
				document.fr.action="";
				document.fr.sbmit();
			} else {
				return false;
			}
		}
	}
	
	//구매하기 버튼을 클릭했을시
	function valueOrderChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == "default"){
			alert("배송옵션을 선택해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("구매하시겠습니까?");
			if(isBasket) {
				document.fr.action="";
				document.fr.sbmit();
			} else {
				return false;
			}
		}
	}
	
	//소메뉴 눌렸을시 --------------------------------------------------------------
	function menuMove(seq){
        var offset = $("#menu" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 300);
    }
	
	
</script>




</html>
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
	
	<!-- 구매 테이블 생성 -->
	Order / Payment  주문/결제
	<table border="1">
		<!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
		<tr>
			<td>이미지</td>
			<td>상품정보</td>
			<td>판매가<br>(적립예정)</td>
			<td>수량</td>
			<td>배송구분</td>
			<td>배송비</td>
			<td>합계</td>
		</tr>
		<%
			for (int i = 0; i < basketList.size(); i++) {
				BasketDTO bkdto = (BasketDTO) basketList.get(i);
				ProductDTO pdto = (ProductDTO) productInfoList.get(i);
				
				//총 상품금액 계산
				final_total_price += (bkdto.getB_amount() * pdto.getProduct_price_sale());
				
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
	</table>
	
	<hr>
	
	<!-- 사용자 정보 입력 테이블 -->
	구매자 정보 	*필수입력사항
	<table border="1">
		<tr>
			<td> 구매하시는 분 </td>
			<td> <input type="text" id="buyer_name" name="buyer_name" value="<%=memberDTO.getName()%>"> </td>
		</tr>
		<tr>
			<td> 주소 </td>
			<td> 
				<input type="text" id="buyer_zipcode" name="zipcode" id="zipcode" value="<%=memberDTO.getZipcode()%>" readonly> <button type="button" onclick="DaumPostcode();">주소검색</button> <br>
				<input type="text" id="buyer_addr1" name="addr1" id="addr1" value="<%=memberDTO.getAddr1()%>" readonly> 기본주소 <br>
				<input type="text" id="buyer_addr2" name="addr2" id="addr2" value="<%=memberDTO.getAddr2()%>"> 상세주소
			</td>
		</tr>
				<!-- ----- DAUM 우편번호 API 시작 ----- -->
				<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
				  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		<tr>
			<td> 휴대전화 </td>
			<td> <input type="text" id="buyer_phone" name="buyer_phone" value="<%=memberDTO.getPhone()%>"> </td>
		</tr>
		
		<tr>
			<td> 전화번호 </td>
			<td> <input type="text" id="buyer_number" name="buyer_number" value="<%=memberDTO.getPhone()%>"> </td>
		</tr>
		
		<tr>
			<td> 이메일 </td>
			<td> 
				<input type="text" id="buyer_email" name="buyer_email" value="<%=memberDTO.getEmail()%>">@<input type="text" name="" value=""> <br>
				- 이메일을 통해 주문처리과정을 보내드립니다.	 <br>
				- 이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요
			</td>
		</tr>
	</table>
	
	<br>
	
	수령자 정보		*필수입력사항
	<table border="1">
	
		<tr>
			<td> 배송지 선택 </td>
			<td> <input type="checkbox" id="chkBoxInfo"> 구매자 정보와 동일 </td>
		</tr>
		
		<tr>
			<td> 수령하시는 분 </td>
			<td> <input type="text" id="rece_name" name="rece_name" value=""> </td>
		</tr>
		<tr>
			<td> 주소 </td>
			<td> 
				<input type="text" id="rece_zipcode" name="zipcode" id="zipcode" value="" readonly> <button type="button" onclick="DaumPostcode();">주소검색</button> <br>
				<input type="text" id="rece_addr1" name="addr1" id="addr1" value="" readonly> 기본주소 <br>
				<input type="text" id="rece_addr2" name="addr2" id="addr2" value=""> 상세주소
			</td>
		</tr>
				<!-- ----- DAUM 우편번호 API 시작 ----- -->
				<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
				  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		<tr>
			<td> 휴대전화 </td>
			<td> <input type="text" id="rece_phone" name="rece_phone" value=> </td>
		</tr>
		
		<tr>
			<td> 전화번호 </td>
			<td> <input type="text" id="rece_number" name="rece_number" value=> </td>
		</tr>
		
		<tr>
			<td> 배송메세지 </td>
			<td> <textarea rows="10" cols="100"></textarea> </td>
		</tr>
	</table>
	
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
	<input type="button" value="PAYMENT(결제하기)">
	<br>

	<table border="1">
		<tr>
			<td>이용안내</td>
		</tr>
		<td>
			WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol>
			WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol> 
			WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol> 
			WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol> 
			WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
			<ol>
				<li>안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</li>
				<li>Service Pack 2에 대한 Microsoft사의 상세안내</li>
				<li>결제보안을 위한 KCP Active-X가 자동설치되지 않을경우 수동설치하시기 바랍니다.</li>
			</ol> 
		</td>
	</table>


	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>
	
</body>

<script type="text/javascript">

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
    
    
</script> 

</html>
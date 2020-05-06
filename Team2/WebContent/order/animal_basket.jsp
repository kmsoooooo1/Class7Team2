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
<title>Insert title here</title>
</head>
<body>


	<%
		List basketList = (List)request.getAttribute("basketList");
		List AnimalList = (List)request.getAttribute("AnimalList");
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	
	<!-- 장바구니 테이블 생성 -->
  <table border="1">
  <!-- 번호,사진,제품명,크기,색상, 수량, 가격, 취소 -->
  <tr>
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
 	//for(int i=0;i<basketList.size();i++){
	  BasketDTO bkdto = new BasketDTO();
	  AnimalDTO adto = new AnimalDTO(); 
	  %>
	     <tr>
		    <td>
		      <img src="./upload/multiupload/<%=adto.getA_thumbnail()%>"
		          width="80" height="80"
		      >
		    </td>
		    <td><%=adto.getA_thumbnail()+"<br>["+bkdto.getB_option()+"]" %></td>
		    <td><%=adto.getA_price_sale() %></td>
		    <td><%=bkdto.getB_amount() %></td>
		    <td><%=adto.getA_mileage() %></td>
		    <td><%=bkdto.getB_option() %></td>
		    <td><%=adto.getA_price_sale() * bkdto.getB_amount() %></td>
		    <td>
				<input type="button" value="주문하기"><br>    
				<input type="button" value="관심상품 등록"><br>	    
				<input type="button" value="삭제"><br>  
		    </td>
		 </tr>
		 
	  <%
  //}  
  %>
  		 <tr>
  		 	<td>[기본배송] 상품구매금액 + 배송비 = 합계 : 원</td>
  		 </tr>
  	</table>
  	
  	<p>할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.</p>
  	<hr>
  	<input type="button" value="삭제하기">
  	<input type="button" value="관심상품등록">
  	<input type="button" value="상품 조르기">
  	<input type="button" value="장바구니 비우기">
  	<input type="button" value="견적서 출력">
  	<br><br>
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
  		<td>
  			장바구니 이용안내<br>
  			<ol>
			<li> 해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다. </li>
			<li> 해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
			<li> 선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다. </li>
			<li> [쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다. </li>
			<li> 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다. </li>
			<li> 파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다. </li>
			</ol>
			무이자할부 이용안내<br>
			<ol>
			<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
			<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
			<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			</ol>
		</td>
  	</table>
  
  
	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
</body>
</html>
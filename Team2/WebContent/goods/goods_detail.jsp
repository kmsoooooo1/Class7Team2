<%@page import="team2.board.db.BoardDTO"%>
<%@page import="team2.board.db.BoardDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<%

		String id = (String) session.getAttribute("id");
		if(id == null){
			id = "";
		}
		
		// GoodsDetailAction 객체에서 저장된 정보를 저장
		List<GoodsDTO> detailList = (List<GoodsDTO>) request.getAttribute("detailList");
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price_origin = formatter.format(detailList.get(0).getG_price_origin());
		String newformat_mileage = formatter.format(detailList.get(0).getG_mileage());
		String newformat_price_sale = formatter.format(detailList.get(0).getG_price_sale());
		
		// 할인율 유무에 따라 최근 본 상품 페이지에 가격표시
		int price = 0;
		
		// 할인율이 있으면
		if(detailList.get(0).getG_discount_rate() != 0){
			price = detailList.get(0).getG_price_sale();
			// 할인율이 없으면
		}else{
			price = detailList.get(0).getG_price_origin();
		}
		
		// 상품에 대한 정보를 쿠키에 담기
		// 쿠키에 한글은 저장되지 않으므로 encode함수로 인코딩해야 한다.
		Cookie cook = new Cookie("item"+detailList.get(0).getG_code(), URLEncoder.encode(
				
				  "<tr> <td> <a href='./goodsDetail.go?g_code="+detailList.get(0).getG_code()+"'> <img src='./upload/multiupload/"+detailList.get(0).getG_thumbnail()+"' width='150' height='150'></a> </td>" 
				+ "<td>"+ detailList.get(0).getG_name()+"</td>"
				+ "<td>"+ price +"</td>"
				+ "<td> <select><option selected disabled>- [필수]배송방법을 선택해 주세요 -</option><option disabled> --------------- </option>"
				+ "<option> 일반포장 </option><option>퀵서비스(착불)</option><option>지하철택배(착불)</option>"
				+ "<option> 고속버스택배 (+14,000원) </option><option> 매장방문수령 </option></select> </td>"
				+ "<td> <input type='button' value='담기'><br> <input type='button' value='주문'><br> <input type='button' value='삭제'></td> </tr>","UTF-8")); 
		cook.setMaxAge(60*60); // 한시간 유지
		response.addCookie(cook);

	%>

	<!-- Main Content -->
	<form action="" method="post" name="fr">
	
		<!-- 상품 기본 정보 파트 -->
	   <div id="menu0">
			<!-- hidden 값들(코드, 오리지날 판매가, 할인된 판매가, 할인율  -->
			<input type="hidden" name="product_code" value="<%=detailList.get(0).getG_code()%>">
			<input type="hidden" id="g_price_origin" name="g_price_origin" value="<%=detailList.get(0).getG_price_origin()%>">
			<input type="hidden" id="g_price_sale" name="g_price_sale" value="<%=detailList.get(0).getG_price_sale()%>">
			<input type="hidden" id="g_discount_rate" name="g_discount_rate" value="<%=detailList.get(0).getG_discount_rate()%>">
			<input type="hidden" id="g_mileage" name="g_mileage" value="<%=detailList.get(0).getG_mileage()%>">
			<input type="hidden" id="g_name" name="g_name" value="<%=detailList.get(0).getG_name()%>">
			<input type="hidden" id="g_delivery" name="g_delivery" value="<%=detailList.get(0).getG_delivery() %>">
			<input type="hidden" id="g_option" name="g_option" value="<%=detailList.get(0).getG_option() %>">
		  	
		  
			<!-- 사용자가 추가한 배송방법들의 value들을 모두 저장하는 input hidden -->
			<input type="hidden" id="selectedValues" name="selectedValues" value="">
			
			<!-- 사용자가 추가한 배송방법들의 수량들 예를 들어 일반배송의 수량(실시간으로 수정할수도 있으니)을 저장하는 input hidden -->
			<input type="hidden" id="selectedAmounts" name="selectedAmounts" value="">
		  
			<table border="0">
		     <tr>
		     	<td> <img src="./upload/multiupload/<%=detailList.get(0).getG_thumbnail()%>" width="500" height="500"> </td>
		        <td>
		        	<!-- 상품명(미완성@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@) -->
<%-- 		        	<% --%>
<!--  		        		GoodsDTO gdto = new GoodsDTO(); -->
		        	
<!--  		        		if(gdto.getG_amount() == 0){ -->
<%-- 		        	%> --%>
<!-- 		        	  <span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span> -->
<%-- 		        	  <h4> <%=detailList.get(0).getG_name() %> </h4> --%>
<%-- 		        	<%}else{ %> --%>
<%-- 		        	  <h4> <%=detailList.get(0).getG_name() %> </h4> --%>
<%-- 		        	<%} %>     --%>

<%-- 					<c:forEach var="detailList" items="${detailList }"> --%>
<%-- 						<c:out value="${detailList.g_amount }"/> --%>
<%-- 						<c:if test="${detailList.g_amount eq 0}"> --%>
<!-- 							<span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span> -->
<%-- 							<h4> <%=detailList.get(0).getG_name() %> </h4> --%>
<%-- 						</c:if> --%>
<%-- 					</c:forEach> --%>
					
<%-- 					<% --%>
<!--  						for(int i=0; i<detailList.size(); i++){ -->
<!--  							GoodsDTO gdto = detailList.get(i); -->
<!-- 							String test = Integer.toString(gdto.getG_amount()); -->
<!--  							if(! test.contains("0")) { -->
<%-- 					%> --%>
<%-- 								<h4> <%=detailList.get(0).getG_name() %> </h4> --%>
<%-- 					<%	 --%>
<!--  							}else { -->
							
<!--  								break;	 -->
<!--  							} -->
<!--  						} -->
<%-- 					%> --%>
					
					<h4> <%=detailList.get(0).getG_name() %> </h4>
				
		        	<hr>
		        	
		        	<!-- 판매가, 적립금, 할인판매가 -->
		        	<table border="1">
		        	  <tr>
		        	    <td> 판매가 </td>
		        	    <td>
		        	       <%=newformat_price_origin%>원 
		        	       <%if(detailList.get(0).getG_discount_rate() != 0){ //할인율 있으면 %>
		        	          <%=detailList.get(0).getG_discount_rate() %>% OFF
		        	       <%} %>   
		        	    </td>
		        	  </tr>
		        	  
		        	  <tr>
		        	    <td> 적립금 </td>
		        	    <td> <%=newformat_mileage%>원 </td>
		        	  </tr>
		        	  
		        	  <%if(detailList.get(0).getG_discount_rate() != 0){ //할인율 있으면 %>
		        	  <tr>
		        	     <td> 할인판매가 </td>
		        	     <td> <%=newformat_price_sale%>원 (<%=detailList.get(0).getG_discount_rate() %>% 할인율) </td>
		        	  </tr>
		        	  <%} %>
		        	</table>
		        	
		        	<hr>
		        	
		        	
		        	<!-- 배송(일반배송, 선택배송) 구분 -->
		        	<!-- 일반 배송이고 옵션이 없는 경우 -->
		        	<%if(detailList.get(0).getG_delivery().equals("일반배송") && detailList.get(0).getG_option().equals("")){ %>
		        	<table border="1">
		        	<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
		        	  <tr>
		        	    <td> 상품명 </td>
		        	    <td> 상품수 </td>
		        	    <td> 가격 </td>
		        	  </tr>
		        	  <!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
					  <!-- <tbody id="final_product_info_table"></tbody> -->
					  <%
						for(int i=0; i<detailList.size(); i++){
							GoodsDTO goodsDetail = (GoodsDTO)detailList.get(i);
					  %>
						  <tr>
							  	<td>
							  		<%=goodsDetail.getG_name()%>
							  	</td>
							  	<!-- 상품 수량 -->
							  	<td>
							  		<input type="text" id="g_amount_<%=goodsDetail.getG_delivery()%>" name="g_amount_<%=goodsDetail.getG_delivery()%>" value=1 maxlength="3" size="3" onkeyup='amountChange("<%=goodsDetail.getG_delivery()%>");'>
							  		<input type="button" id="amountPlus" name="amountPlus" value="+" onclick='plusnormal("<%=goodsDetail.getG_delivery()%>");'>
							  		<input type="button" id="amountMinus" name="amountMinus" value="-" onclick='minusnormal("<%=goodsDetail.getG_delivery()%>");'>
							  		<!-- <input type="button" id="deleteCell" name="deleteCell" value="x" onclick='delCell(this,"<%=goodsDetail.getG_delivery()%>");'>  -->
							  	</td>
							  	<!-- 상품 판매가(할인율 있을때와 없을때와 -->
							  	<%if(goodsDetail.getG_discount_rate() != 0) {%>
							  		<td>
							  			<span id="total_product_price_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_price_sale())%>원</span>
							  			<br>
							  			(적 <span id="total_product_mileage_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_mileage())%>원</span>)
							  		</td>
							  		<input type="hidden" id="total_product_price_<%=goodsDetail.getG_delivery()%>_input" value="<%=goodsDetail.getG_price_sale()%>">
							  		
						 
							  	<%} else { // 할인율 없을 때%>
							  		<td>
							  			<span id="total_product_price_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_price_origin())%>원</span>
							  			<br>
							  			(적 <span id="total_product_mileage_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_mileage())%>원</span>)
							  		</td>
							  		<input type="hidden" id="total_product_price_<%=goodsDetail.getG_delivery()%>_input" value="<%=goodsDetail.getG_price_origin()%>">
					    
							  	<%}%>
						</tr>
						  
						<%if(goodsDetail.getG_discount_rate() != 0){ %>
						    <tr>
								<td colspan="3"> TOTAL : <span id="final_total_price_normal"><%=formatter.format(goodsDetail.getG_price_sale())%></span>원 (<span id="final_total_amount">1</span>개) </td>
							</tr>
						<%}else{ %>
							<tr>
								<td colspan="3"> TOTAL : <span id="final_total_price_normal"><%=formatter.format(goodsDetail.getG_price_origin())%></span>원 (<span id="final_total_amount">1</span>개) </td>
							</tr>
						<%} %>
								
					<%} // for문 닫기 %>
		        	</table>
		        	
		    
		        	<!-- 일반 배송이고 옵션이 있는 경우 --------------------------------------------->
		        	<%}else if(detailList.get(0).getG_delivery().equals("일반배송") && !detailList.get(0).getG_option().equals("")){ %>
						<!-- 옵션을 셀렉트박스로 가져오기 -->
			        	옵션선택	
				        <!-- 상품 옵션값들 나타내기 -->

						  <select id="option_method" name="option_method" onchange="changeOptionMethod();">
						  	<option value="" selected disabled>-[필수] 선택하시오-</option>
				        	<option disabled>------------------------------</option>
			        		<c:forEach var="detailList" items="${detailList }">
			        			<c:if test="${detailList.g_amount eq 0}">
				        			<option value="${detailList.g_option}" disabled>
					        			  ${detailList.g_option} 
					        			  <c:if test="${detailList.g_option_price ne 0}">
					        			    (+<span id="g_option_price">${detailList.g_option_price}</span>원)
					        			  </c:if>
					        			  [품절]
				        			</option>
			        			 </c:if>
 
								<c:if test="${detailList.g_amount ne 0}">
				        			<option value="${detailList.g_option}">
					        			  ${detailList.g_option} 
					        			  <c:if test="${detailList.g_option_price ne 0}">
					        			    (+<span id="g_option_price">${detailList.g_option_price}</span>원)
					        			  </c:if>
				        			</option>
			        			 </c:if>  
			        		  
			        		</c:forEach>
						</select>
				      <hr>
						
						<!-- 옵션 선택 시, 주문현황 나오게 하기 -->
						 <table border="1">
							<tr>
								<td> 상품명 </td>
								<td> 상품수 </td>
								<td> 가격 </td>
							</tr>
							<!-- 옵션을 선택했을시 최종 상품 정보 나타내기 -->
							<tbody id="final_product_info_table_option"></tbody>
							
							<tr>
								<td colspan="3"> TOTAL : <span id="final_total_price"></span>원 (<span id="final_total_amount"></span>개) </td>
							</tr>
						</table>
		        		
		        		
		        	<%}else{ %>
		        	<!-- 선택 배송일 때, -->
		        	배송방법
		        	  <select id="delivery_method" name="delivery_method" onchange="changeDeliMethod();">
		        	    <option value="" selected disabled> -[필수]배송방법을 선택해 주세요 - </option>
						<option disabled> --------------- </option>
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
		        	 <tbody id="final_product_info_table"></tbody>

						<tr>
							<td colspan="3"> TOTAL : <span id="final_total_price"></span>원 (<span id="final_total_amount"></span>개) </td>
						</tr>
        	
		        	</table>
		        	
		        	<%} %>
		        	
		        	<hr>
		        	
		        	
		        	<!-- 미완성@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		        	<%if(detailList.get(0).getG_amount() == 0){ %>
		        	    <span> 품절 </span>
		        	    <button type="button"> 관심상품 </button>
					    <br>
					    <button type="button" onclick="kakaoChat();"> 카카오톡 상담 </button>
		        	<%}else{ %>
		        	    <button type="button"> <a href="javascript:valueOrderChecked()"> 바로구매 </a> </button>
						<button type="button"> <a href="javascript:valueBasketChecked()"> 장바구니 </a> </button>
						<button type="button"> 관심상품 </button>
						<br>
						<button type="button" onclick="kakaoChat();"> 카카오톡 상담 </button>
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
	
		<p> <%=detailList.get(0).getContent()%> </p>
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
		
		<%
			BoardDAO bdao = new BoardDAO();
			List<BoardDTO> bList = bdao.getPList(1, detailList.get(0).getG_code());
		
		%>
		
		<table border="1">
			<tr>
				<th>글쓴이</th>
				<th>제목</th>
				<th>작성일자</th>
				<th>조회수</th>
			</tr>
			
		<%if(bList.size()>0){
			for(BoardDTO dto : bList){%>
			<tr>
				<td> 
					<%=dto.getB_writer() %>
				</td> 
				<td>
					<%=dto.getB_title() %>
				</td>
				<td>
					<%=dto.getB_reg_date() %>
				</td>
				<td>
					<%=dto.getB_view() %>
				</td>
			</tr>
		<%	}
		  }else{ %>
		    <tr>
		  		<td colspan='4'>작성된 글이 없습니다.</td>
		  	</tr>
		<%} %> 
		</table>
		
		<button type="button"  onclick="location.href='./Insert.bo?C=1&CODE=<%=detailList.get(0).getG_code() %>'"> 리뷰작성 </button>
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
		
	<%
		bList = bdao.getPList(2, detailList.get(0).getG_code());
		bdao.closeDB();
	
	%>	
		<table border="1">
			<tr>
				<th>제목 </th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
	<%
		if(bList.size()>0){
			for(BoardDTO dto:bList){
	%>		
	
			<tr>
				<td><%=dto.getB_title() %></td>
				<td><%=dto.getB_writer() %></td>
				<td><%=dto.getB_reg_date() %></td>
				<td><%=dto.getB_view() %></td>
			</tr>
	<%
			}
		}else{
	%>
			<tr>
				<td colspan="4">작성된 글이 없습니다.</td>
			</tr>
	<%
		}
	%>
		</table>
		<button type="button" onclick="location.href='./Insert.bo?C=2&CODE=<%=detailList.get(0).getG_code()%>'">상품문의하기</button>
		<button type="button">모두보기</button>
	</div>



	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
<script type="text/javascript">

	//상품의 배송방법이 일반배송이고 옵션이 있는경우
	if($('#g_delivery').val() == '일반배송' && $('#g_option').val()) { 

		var total_price; //추가되는 tr의 총 판매가
		var final_total_price = 0; // 선택배송이고, 최종 total 판매가 계산하기 위한 변수
		
		// 일반배송이고, 최종 total 판매가 계산하기 위한 변수
		if(<%=detailList.get(0).getG_discount_rate() != 0%>){
			var final_total_price_normal = <%=detailList.get(0).getG_price_sale()%>;   
		}else{
			var final_total_price_normal = <%=detailList.get(0).getG_price_origin()%>;
		}
		 
		var final_total_amount = 0; //최종 total 수량 계산하기 위한 변수
		
		var count = 0; //사용자가 배송방법을 추가하거나 없앨때 늘어나고 줄어드는 변수
		
		var selectedValues = ""; //사용자가 선택한 배송방법들을 차례대로 담는 변수
		
		var selectedAmounts = ""; //사용자가 선택한 배송방법의 수량들을 차례대로 담는 변수
		
		var selectedArray = new Array(); //사용자가 선택한 배송방법들을 담기 위한 Array 
		
		function changeOptionMethod(){
			
			var option_method = document.getElementById('option_method').value; // 선택한 옵션
			
			var g_name = document.getElementById('g_name').value; // 상품명
			var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
			var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
			var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
			var g_option_price = document.getElementById('g_option_price').innerHTML;
			
			
			// 만약 추가 가격이 있는 옵션을 선택하면 판매가격에 g_option_price에 저장된 값 저장하기
			
			
			
			var objRow;
			objRow = document.all["final_product_info_table_option"].insertRow();
			
			//사용자가 올바른 옵션을 선택 하지 않았을시
			if(option_method == null){
				document.getElementById("final_product_info_table_option").style.display = "none";
			}
			//사용자가 올바른 옵션을 선택했을시 새로운 cell 추가하기
			else {
				//상품명 - 첫번째 td(cell) 항목
				var objCell_name = objRow.insertCell();
				objCell_name.innerHTML = "<span id='objCell_name'>" + g_name + "</span> <br>" + "<span id='option_method_option'>[옵션:" + option_method + "]</span>";
				
				//상품수 - 두번째 td(cell) 항목
				var objCell_amount = objRow.insertCell();
				objCell_amount.innerHTML = "<input type='text' id='g_amount_" + option_method + "' name='g_amount_" + option_method + "' value='1' maxlength='3' size='3' onkeyup='amountOptionChange(" + "\"" + option_method + "\"" + ");'>" 
											+ " <input type='button' id='amountPlus' name='amountPlus' value='+' onclick='plusOption(" + "\"" + option_method + "\"" + ");'> " 
											+ " <input type='button' id='amountMinus' name='amountMinus' value='-' onclick='minusOption(" + "\"" + option_method + "\"" + ");'> "
											+ " <input type='button' id='deleteCell' name='deleteCell' value='x' onclick='delOptionCell(this, " + "\"" + option_method + "\"" + ");'> ";		
				
				//가격, 적립금 - 세번째 td(cell) 항목
				var objCell_price = objRow.insertCell();
				//만약 적립금이 0이 아니면
				if(g_discount_rate != 0){
					objCell_price.innerHTML = "<span id='total_product_price_" + option_method + "' >" 
											+ g_price_sale.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + option_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + option_method + "_input" + "' name='total_product_price_" + option_method + "_input' value=" + g_price_sale + ">";
				}
				//만약 적립금이 0이면
				else{
					objCell_price.innerHTML = "<span id='total_product_price_" + option_method + "'>" 
											+ g_price_origin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + option_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + option_method + "_input" + "' name='total_product_price_" + option_method + "_input' value=" + g_price_origin + ">";
				}
			}
	
		}
	
	}
	
	
	//사용자가 배송방법을 선택했을시-------------------------------------------
	
	function changeDeliMethod(){
		
		var delivery_method = document.getElementById('delivery_method').value;	//배송방법
		
		var g_name = document.getElementById('g_name').value; // 상품명
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		
		//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
		if(delivery_method == '고속버스'){
			//할인율이 있으면
			if(g_discount_rate != 0){
				g_price_sale = parseInt(g_price_sale) + parseInt(14000);
			}
			//없으면
			else{
				g_price_origin = parseInt(g_price_origin) + parseInt(14000);
			}	
		}
		
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var objRow;
		objRow = document.all["final_product_info_table"].insertRow();
		
		//사용자가 올바른 배송방법을 선택 하지 않았을시
		if(delivery_method == null){
			document.getElementById("final_product_info_table").style.display = "none";
		}
		//사용자가 올바른 배송방법을 선택했을시 새로운 cell 추가하기
		else{
			// 상품명 - 첫번째 td(cell) 항목
			var objCell_name = objRow.insertCell();
			objCell_name.innerHTML = "<span id='objCell_name'>" + g_name + "</span> <br>" + "<span id='delivery_method_option'>[옵션:" + delivery_method + "]</span>";
			
			// 상품수 - 두번째 td(cell) 항목
			var objCell_amount = objRow.insertCell();
			objCell_amount.innerHTML = "<input type='text' id='g_amount_" + delivery_method + "' name='g_amount_" + delivery_method + "' value='1' maxlength='3' size='3' onkeyup='amountChange(" + "\"" + delivery_method + "\"" + ");'>" 
										+ " <input type='button' id='amountPlus' name='amountPlus' value='+' onclick='plus(" + "\"" + delivery_method + "\"" + ");'> " 
										+ " <input type='button' id='amountMinus' name='amountMinus' value='-' onclick='minus(" + "\"" + delivery_method + "\"" + ");'> "
										+ " <input type='button' id='deleteCell' name='deleteCell' value='x' onclick='delCell(this, " + "\"" + delivery_method + "\"" + ");'> ";		
			
			//가격, 적립금 - 세번째 td(cell) 항목
			var objCell_price = objRow.insertCell();
			//만약 적립금이 0이 아니면
			if(g_discount_rate != 0){
				objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "' >" 
										+ g_price_sale.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
										+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
										+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + g_price_sale + ">";
			}
			//만약 적립금이 0이면
			else{
				objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "'>" 
										+ g_price_origin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
										+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
										+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + g_price_origin + ">";
			}
										
		}
		
		//select option 태그안에 사용자가 선택한 배송방법 비활성화 시키기
		$("select option[value*='"+ delivery_method +"']").attr('disabled',true);
		
		//final_total_price 태그 제어
		total_price = $('#total_product_price_' + delivery_method + '_input').val(); //하나의 tr(배송)의 총 판매가
		
		//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
		final_total_price += Number(total_price);
		
		//태그에 추가하기
		$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
		//final_total_amount 태그 제어
		total_amount = $('#g_amount_' + delivery_method).val(); //하나의 tr(배송)의 총 수량
		final_total_amount += Number(total_amount);
		
		//태그에 추가하기
		$('#final_total_amount').text(final_total_amount);
		
		//사용자가 select option 에서 selected 한 값 selectedValues input hidden value에 차례대로 넣기
		selectedValues += (delivery_method + ",");
		//추가된 values 변수를 태그에 담기
		$("#selectedValues").val(selectedValues);
		
		count += Number("1");
		
		//추가된 배송방법 selectedArray에 추가하기
		selectedArray.push(delivery_method);
		
		//----- 키보드로 주문수량 변경시 모든 옵션의 총 수량 제어 ---------------------------------------------------
		
		//사용자가 수량 input 태그에 마우스를 클릭했을시 입력되어있던 수량을 저장하기
		$('#g_amount_' + delivery_method).on('focusin', function(){
			//console.log("저장된 value : " + $(this).val());
			
			//사용자가 키보드로 입력하기 전 수량
			$(this).data('val', $(this).val()); 
 		});
		
		//사용자가 수량 input 태그에 키보드로 새로운 수량을 입력했을시
		$('#g_amount_' + delivery_method).on('change', function(){
			final_total_amount = document.getElementById('final_total_amount').innerHTML; //총 수량 (span 태그 안에 있는 값) 가져오기
			final_total_amount = Number(final_total_amount); //문자열을 숫자로 형변환
			
			var previousAmount = $(this).data('val'); 	//사용자가 키보드로 입력하기 전 수량
		    var currentAmount = $(this).val();			//사용자가 키보드로 입력 한 수량
			
		  //사용자가 키보드로 input에 0보다 작은수를 입력했을시
		  if(currentAmount < 1){
			  alert("상품의 최소 구매량은 1개입니다.");
			  currentAmount = parseInt("1");
			  $("#g_amount_" + delivery_method).val(currentAmount);
		  }else{
			//변경 전 수량이 변경 후 수량보다 클때
			if(previousAmount > currentAmount){
				//final_total_amount 태그 제어
				final_total_amount -= (previousAmount - currentAmount);
				
				//만약 할인율이 0이 아니면
				if(g_discount_rate != 0){
					//final_total_price 태그 제어
		   			final_total_price -= (g_price_sale * (previousAmount - currentAmount));

					//태그에 추가하기
					$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				}
				//할인율이 0이면
				else{
					//final_total_price 태그 제어
		   			final_total_price -= (g_price_origin * (previousAmount - currentAmount));

					//태그에 추가하기
					$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				}
				
			}
			//변경 전 수량이 변경 후 수량보다 작을때
			else if(previousAmount < currentAmount){
				//final_total_amount 태그 제어
				final_total_amount += (currentAmount - previousAmount);
				
				//만약 할인율이 0이 아니면
				if(g_discount_rate != 0){
					//final_total_price 태그 제어
		   			final_total_price += (g_price_sale * (currentAmount - previousAmount));

					//태그에 추가하기
					$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				}
				//할인율이 0이면
				else{
					//final_total_price 태그 제어
		   			final_total_price += (g_price_origin * (currentAmount - previousAmount));

					//태그에 추가하기
					$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				}
			}
			
		  }
		    
		  $('#final_total_amount').text(final_total_amount);
		    
		});
		
	}

	//주문수량 변경 시-----------------------------------------------------------------------------
	var delivery_method = document.getElementById('delivery_method').value;	//배송방법
	
	var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
	var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
	var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
	var g_mileage = document.getElementById('g_mileage').value;				//적립금


	//주문수량 키보드로 변경시 tr한줄의 총 금액과 마일리지 및 모든 옵션의 총 금액 제어 ----------------------------------------------------------
	function amountChange(delivery_method){
		
		var delivery_method = document.getElementById('delivery_method').value;	//배송방법
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금

		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
	
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		
		//만약 할인율(a_discount_rate)이 0이 아니면
		if(g_discount_rate != 0){
			//계산된 값 span 태그에 넣기, 단 옵션이 고속버스 일때는 14000을 따로 더해야한다.
			if(delivery_method == '고속버스'){
				total_price = Number((g_price_sale * new_g_amount) + 14000);
			}else{
				total_price = Number(g_price_sale * new_g_amount);
			}
			
			//각 tr의 총 가격 span 태그에 값 넣기
			document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			//input hidden 값에 수정된 총 가격 넣기
			$('#total_product_price_' + delivery_method + "_input").val(total_price);
			
			//최종 마일리지 계산하기 
			final_mileage = g_mileage * new_g_amount;
			//계산된 마일리지 span 태그에 넣기
			document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			
		}
		//할인율이 0이면
		else{
			//계산된 값 span 태그에 넣기, 단 옵션이 고속버스 일때는 14000을 따로 더해야한다.
			if(delivery_method == '고속버스'){
				total_price = Number((g_price_origin * new_g_amount) + 14000);
			}else{
				total_price = Number(g_price_origin * new_g_amount);
			}
			
			//각 tr의 총 가격 span 태그에 값 넣기
			document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			//input hidden 값에 수정된 총 가격 넣기
			$('#total_product_price_' + delivery_method + "_input").val(total_price);	
			
			//최종 마일리지 계산하기 
			final_mileage = g_mileage * new_g_amount;
			//계산된 마일리지 span 태그에 넣기
			document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			
		}
		
	}
	
	//배송방법 선택배송일 때--------------------------------------------------------
	//사용자가 '+'를 눌렸을시
	function plus(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_g_amount = parseInt("999");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			
			new_g_amount++;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			final_total_amount += Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += Number(g_price_sale);
				
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);	
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += Number(g_price_origin);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}

		}
	}
	
	//배송방법 일반배송일 때--------------------------------------------------------
	//사용자가 '+'를 눌렸을시
	function plusnormal(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_g_amount = parseInt("999");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			
			new_g_amount++;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			final_total_amount += Number("1");
			$('#final_total_amount').text(final_total_amount+1);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price_normal += Number(g_price_sale);
			
				//태그에 추가하기
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);	
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price_normal += Number(g_price_origin);
				//태그에 추가하기
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}

		}
	}
	
	
	
	//선택배송일 때--------------------------------------------------
	//사용자가 '-'를 눌렸을시
	function minus(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_g_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			new_g_amount--;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			final_total_amount -= Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price -= Number(g_price_sale);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price -= Number(g_price_origin);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
		}
	}	
	
	//일반배송일 때--------------------------------------------------
	//사용자가 '-'를 눌렸을시
	function minusnormal(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_g_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			new_g_amount--;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			final_total_amount -= Number("1");
			$('#final_total_amount').text(final_total_amount+1);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price_normal -= Number(g_price_sale);
				//태그에 추가하기
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price_normal -= Number(g_price_origin);
				//태그에 추가하기
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
		}
	}	
	
	
	// 사용자가 상품정보 제거했을 시----------------------------------------------
	function delCell(obj, delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//만약 할인율(g_discount_rate)이 0이 아니면
		if(g_discount_rate != 0){
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');
		}
		//할인율이 0이면
		else{
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');
		}
		
		count -= Number("1");
		
		//selectedArray에 삭제하고 싶은 배송방법을 삭제하기
		selectedArray.splice(selectedArray.indexOf(delivery_method),1);
		
	}
	
	
	
	//구매하기, 장바구니 버튼 눌렸을시 ------------------------------------------
	
	//장바구니 버튼을 클릭했을시
	function valueBasketChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == ""){
			alert("배송옵션을 선택해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("장바구니에 담으시겠습니까?");
			if(isBasket) {
				//submit 되기 전에 최종 입력한 수량들을 selectedAmount input hidden value에 차례대로 넣기
				//selectedAmounts += ($('#g_amount_' + delivery_method).val() + ",");
				
				for(var i=0; i<count; i++){
					//selectedArray[i] -> 선택된 배송방법의 value들
					selectedAmounts += ($('#g_amount_' + selectedArray[i]).val() + ",")
				}
				
				//추가된 values 변수를 태그에 담기
				$("#selectedAmounts").val(selectedAmounts);
				
				document.fr.action="./BasketAdd.ba";
				document.fr.submit();
			} else {
				return false;
			}
		}
	}
	
	//구매하기 버튼을 클릭했을시
	function valueOrderChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == ""){
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
	
	//소메뉴에서 클릭했을시 특정 div로 스크롤 이동시키는 함수 ex) 기본 정보 눌렸을시 기본정보div로 이동하기
	function menuMove(seq){
        var offset = $("#menu" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 300);
    }
							  	
	// 카카오 채팅 상담 -----------------------------------------------------------------------------------
	function kakaoChat() {
		var popupX = (window.screen.width / 6) - (200 / 2); 
		var popupY = (window.screen.height / 4) - (300 / 2);  
		window.open('https://pf.kakao.com/_iLxlxexb','windows','width=600,height=670,left='+popupX+',top='+popupY+',scrollbars=yes');
	}
	
	
</script>

</html>
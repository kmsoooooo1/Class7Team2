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
		        	
		        	
		        
		        </td>
		     </tr>
		  
		  
		  </table>
	   
	   
	   </div>
	
	
	
	</form>





	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>
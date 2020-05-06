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
 // for(int i=0;i<basketList.size();i++){
	  BasketDTO bkdto = new BasketDTO();
	  AnimalDTO adto = new AnimalDTO(); 
	  %>
	     <tr>
		    <td>
		      <img src="./upload/multiupload/<%=adto.getA_thumbnail()%>"
		          width="80" height="80"
		      >
		    </td>
		    <td></td>
		    <td><%=adto.getA_price_sale() %></td>
		    <td><%=bkdto.getB_amount() %></td>
		    <td></td>
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
  
  </table>
	
</body>
</html>
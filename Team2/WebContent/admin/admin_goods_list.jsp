<%@page import="team2.goods.db.GoodsDTO"%>
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
	<h1>WebContent/admin/admin_goods_list.jsp/</h1>
	
	<%
		//GoodsListAction 객체에서 저장된 정보 저장
		List<GoodsDTO> goodsList = (List<GoodsDTO>) request.getAttribute("goodsList");
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<table border="1">
		<tr>
		   <th></th>
		   <th>썸네일</th>
		   <th>카테고리</th>
		   <th>서브 카테고리</th>
		   <th>서-서브 카테고리</th>
		   <th>상품 이름</th>
		   <th>상품 코드</th>
		   <th>수량</th>
		   <th>판매가</th>
		   <th>할인율(%)</th>
		   <th>할인 판매가</th>
		   <th>적립금</th>
		   <th>조회수</th>
		   <th>등록일자</th>
		   <th>수정하기</th>
		   <th>삭제하기</th>
		</tr>
		
		<%
			for(int i=0; i<goodsList.size(); i++){
				GoodsDTO gdto = goodsList.get(i);
		%>
		
		<tr>
		   <td><%=gdto.getNum() %></td>
		   <td><img src="./upload/multiupload/<%=gdto.getG_thumbnail()%>" width="50" height="50"></td>
		   <td><%=gdto.getCategory() %></td>
		   <td><%=gdto.getSub_category() %></td>
		   <td><%=gdto.getSub_category_index() %></td>
		   <td><%=gdto.getG_name() %></td>
		   <td><%=gdto.getG_code() %></td>
		   <td><%=gdto.getG_amount() %></td>
		   <td><%=gdto.getG_price_origin() %></td>
		   <td><%=gdto.getG_discount_rate()%></td>
		   <td><%=gdto.getG_price_sale() %></td>
		   <td><%=gdto.getG_mileage() %></td>
		   <td><%=gdto.getG_view_count() %></td>
		   <td><%=gdto.getDate() %></td>
		   <td><a href=""><button type="button"> 수정 </button></a></td>
		   <td><a href=""><button type="button"> 삭제 </button></a></td>
		</tr>
		
		<%} %>
		
	</table>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
</body>
</html>
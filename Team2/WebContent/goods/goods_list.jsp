<%@page import="java.text.DecimalFormat"%>
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
	
	<%
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		String sub_category_index = request.getParameter("sub_category_index");
		
		// GoodsListAction 객체에서 저장된 정보를 저장
		List<GoodsDTO> goodsList = (List<GoodsDTO>)request.getAttribute("goodsList");
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<%if(category.equals("먹이")){ %>
	<div>
	   <ul>
	      <li><a href="./GoodsList.go?category=먹이"> 전체보기 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=칼슘/약품"> 칼슘/약품 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=생먹이"> 생먹이 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=냉동먹이"> 냉동먹이 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=인공사료"> 인공사료 </a></li>
	   </ul>
	</div>
	<%} else if(category.equals("사육용품")){ %>
	<div>
	   <ul>
	      <li><a href="./GoodsList.go?category=사육용품"> 전체보기 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=사육장"> 사육장 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=장식/그릇"> 장식/그릇 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=램프"> 램프 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=바닥재"> 바닥재 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=온/습도 관련"> 온/습도 관련 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=보조용품"> 보조용품 </a></li>
	      <li><a href="./GoodsList.go?category=먹이&sub_category=수족관"> 수족관 </a></li>
	   </ul>
	</div>
	<%} %>
	
	<span> Total <%=goodsList.size() %> items </span>
	
	<hr>
	
	<table border="1">
		<%
			int size = goodsList.size();
			int col = 4;
			int row = (size/col) + (size%col>0? 1:0);
			int num = 0;
			
			for(int a = 0; a < row; a++){
		%>
		<tr>
			<%
				for(int i=0; i<col; i++){
					GoodsDTO gdto = goodsList.get(num);
					//###,###,###원 표기하기 위해서 format 바꾸기
					DecimalFormat formatter = new DecimalFormat("#,###,###,###");
					String newformat_price_origin = formatter.format(gdto.getG_price_origin());
					String newformat_price_sale = formatter.format(gdto.getG_price_sale());
				
			%>
			<td colspan="2">
				<a href='./GoodsDetail.go?g_code=<%=gdto.getG_code()%>'><img src="./upload/multiupload/<%=gdto.getG_thumbnail()%>" width="300" height="300"> </a><br>
				<a href='./GoodsDetail.go?g_code=<%=gdto.getG_code()%>'><%=gdto.getG_name() %></a> 
				<hr>
				<%if(gdto.getG_discount_rate() != 0){ // 만약 할인율 있으면 %>
					<span style="text-decoration: line-through;"> <%=newformat_price_origin %>원 </span> <br>
					<span style="color: #f0163a; font-weight: bold;"> 할인판매가 : <%=newformat_price_sale %>원 </span> <br>
				<%}else{ //할인 안하면 %>
					<%=newformat_price_origin %>원 <br>
				<%} %>
				
				<!-- 만약 수량이 0이면 soldout 문구 띄우기 -->
				<%if(gdto.getG_amount() == 0){ %>
					<span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span>
				<%} %>
				
			</td>
			<%
				num ++;
				if(size <= num) break;
				
				}
			%>
		</tr>
		<%} %>
	</table>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
	
</body>
</html>
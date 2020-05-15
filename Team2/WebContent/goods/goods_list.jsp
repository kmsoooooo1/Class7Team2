<%@page import="team2.admin.goods.action.GoodsDeleteAction"%>

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
<link href="${pageContext.request.contextPath}/css/product_list.css" rel="stylesheet">
</head>
<body>
	
	<%
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		String sub_category_index = request.getParameter("sub_category_index");
		String g_code = request.getParameter("g_code");
		
		// GoodsListAction 객체에서 저장된 정보를 저장
		List<GoodsDTO> goodsList = (List<GoodsDTO>)request.getAttribute("goodsList");
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<div class="container">
		<div class="menu">
			<%if(category.equals("먹이")){ %>
			 <input type="button" value="전체보기" class="a_btn"
			 	onclick="location.href='./GoodsList.go?category=먹이'">
			 <input type="button" value="칼슘/약품" class="a_btn"
			 	onclick="location.href='./GoodsList.go?category=먹이&sub_category=칼슘/약품"'">
			 <input type="button" value="생먹이" class="a_btn"
			 	onclick="location.href='./GoodsList.go?category=먹이&sub_category=생먹이'">
			 <input type="button" value="냉동먹이" class="a_btn"
			 	onclick="location.href='./GoodsList.go?category=먹이&sub_category=냉동먹이'">
			 <input type="button" value="인공사료" class="a_btn"
			 	onclick="location.href='./GoodsList.go?category=먹이&sub_category=인공사료'">	
			<%} else if(category.equals("사육용품")){ %>
			 <input type="button" value="전체보기" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=사육용품'">
			 <input type="button" value="사육장" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=사육장'">
			 <input type="button" value="장식/그릇" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=장식/그릇'">
			 <input type="button" value="램프" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=램프'">
			 <input type="button" value="바닥재" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=바닥재'">
			 <input type="button" value="온/습도 관련" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=온/습도 관련'">
			 <input type="button" value="보조용품" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=보조용품'">
			 <input type="button" value="수족관" class="a_btn"
			 		onclick="location.href='./GoodsList.go?category=먹이&sub_category=수족관'">
			<%} %>
		</div>
		<span class="a_amount"> Total <%=goodsList.size() %> items </span>
		<ul class="ul_wrap">
		<%
		if(goodsList.size()>0){
			for(int i=0; i<goodsList.size(); i++){
				GoodsDTO gdto = goodsList.get(i);
				//###,###,###원 표기하기 위해서 format 바꾸기
				DecimalFormat formatter = new DecimalFormat("#,###,###,###");
				String newformat_price_origin = formatter.format(gdto.getG_price_origin());
				String newformat_price_sale = formatter.format(gdto.getG_price_sale());		
		%>
			<li>
				<div class="list_wrap">
				<a href='./GoodsDetail.go?g_code=<%=gdto.getG_code()%>'><img class="list_img" src="./upload/multiupload/<%=gdto.getG_thumbnail()%>" width="300" height="300"></a><br>
				<a href='./GoodsDetail.go?g_code=<%=gdto.getG_code()%>'><%=gdto.getG_name() %></a><br>
				<%if(gdto.getG_discount_rate() != 0){ // 만약 할인율 있으면 %>
					<span style="text-decoration: line-through;"> <%=newformat_price_origin %>원 </span><br>
					<span style="color: #f0163a; font-weight: bold;"> 할인판매가 : <%=newformat_price_sale %>원 </span><br>
				<%}else{ //할인 안하면 %>
					<%=newformat_price_origin %>원
				<%} %>
				<!-- 만약 수량이 0이면 soldout 문구 띄우기 -->
				<%if(gdto.getG_amount() == 0){ %>
					<span style="background-color: #cd6860; color: white; font-size: 6px; border: 1px solid #cd6860;"> SOLD OUT </span>
				<%}%>
				</div>
			</li>
			<%}
		}else{ %>
			<li>
				<div class="list_wrap">
					해당되는 동물이 없습니다.
				</div>
			</li>
	<%	} %>
		</ul>
		<ul id="pageList">
			<li>1</li>
			<li>2</li>
			<li>3</li>
		</ul>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
	
</body>
</html>
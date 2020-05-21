<%@page import="team2.wishlist.db.WishlistDTO"%>
<%@page import="team2.product.db.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/wishlist.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<%
		List wishList = (List) request.getAttribute("wishList");
		List productInfoList = (List) request.getAttribute("productInfoList");
		
	%>
	
	<!-- 관심상품 리스트 생성 -->

	
	<div class="container">
	
	<div class="div_name">
	<h2>Wish List</h2>
	</div>
	
	
	<ul class="ul_wrap">
	
	<%
		int size = productInfoList.size();
		int col = 4;
		int row = (size/col) + (size%col>0? 1:0);
		int num = 0;
		
		for(int a=0; a<row; a++){
			
			for(int i=0; i<col; i++){
				
				WishlistDTO wldto = (WishlistDTO)wishList.get(num);
				ProductDTO pdto = (ProductDTO)productInfoList.get(num);
				
				char first_letter = wldto.getW_code().charAt(0);
				
				//###,###,###원 표기하기 위해서 format 바꾸기
				DecimalFormat formatter = new DecimalFormat("#,###,###,###");
				String newformat_price_origin = formatter.format(pdto.getProduct_price_origin());
				String newformat_price_sale = formatter.format(pdto.getProduct_price_sale());
				String newformat_discount_rate = formatter.format(pdto.getProduct_discount_rate());
		
		%>
		
		<li>
		<div class="list_wrap">
			<input type="hidden" id="w_code<%=num%>" name="w_code<%=num%>" value="<%=wldto.getW_code()%>">
			<%if(first_letter == 'g'){ %>
				<input type="checkbox" class="chkBox" id="chkBox<%=num%>" name="chkBox" value="<%=num%>" style="display: none;"> 
				<label for="chkBox<%=num%>"></label>
				
					<div class="div_info"> 
						<a href="./GoodsDetail.go?g_code=<%=wldto.getW_code()%>"><img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a> 
					</div> 
					
					<div class="div_info">
						<a href="./GoodsDetail.go?g_code=<%=wldto.getW_code()%>"><%=pdto.getProduct_name()%></a> <br>
						<%if(pdto.getProduct_discount_rate() != 0){ //할인율 있으면%>
							<span style="text-decoration: line-through;"><%=newformat_price_origin%></span>원 
							<span style="color: #f0163a;"><%=newformat_price_sale%></span>원  
							<%=newformat_discount_rate%>% 
						<%}else{// 할인율 없으면 %>	
							<%=newformat_price_origin%>원 
							<%=newformat_discount_rate%>% 
						<%} %>
					</div>
					
			<%}else if(first_letter == 'a'){ %>
				<input type="checkbox" class="chkBox" id="chkBox<%=num%>" name="chkBox" value="<%=num%>" style="display: none;"> 
				<label for="chkBox<%=num%>"></label>
				
					<div class="div_info"> 
						<a href="./AnimalDetail.an?a_code=<%=wldto.getW_code()%>"><img src="./upload/multiupload/<%=pdto.getProduct_thumbnail()%>" width="100" height="100"> </a>
					</div>
					
					<div class="div_info">
						<a href="./AnimalDetail.an?a_code=<%=wldto.getW_code()%>"><%=pdto.getProduct_name()%></a> <br>
						<%if(pdto.getProduct_discount_rate() != 0){ //할인율 있으면%>
							<span style="text-decoration: line-through;"><%=newformat_price_origin%></span>원
							<span style="color: #f0163a;"><%=newformat_price_sale%></span>원  
							<%=newformat_discount_rate%>% 
						<%}else{// 할인율 없으면 %>	
							<%=newformat_price_origin%>원 
							<%=newformat_discount_rate%>% 
						<%} %>
					</div>
				
			<%} %>
		
		</div>
		</li>	
		
	
		<% 	
				num++;
				if(size <= num) break;
				
			}	
		%>
	
	<%} //for문 닫음 %>
	
	</ul>
	
	<div id="btn1"> <button type="button" onclick="checkBoxOn();">편집</button> </div>
	<div id="btn2" style="display: none;">
		<button onclick="dellChkBox();">삭제</button>
		<button onclick="cancel();">취소</button>
	</div>


	
	<ul id="pageList">
		<li>1</li>
		<li>2</li>
		<li>3</li>
	</ul>
	
	</div>
	
	
	
	<!-- Footer -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>
	

</body>

<script type="text/javascript">
	// 관심상품 리스트 가져오기
	var wishList = [];
	<c:forEach items="${wishList}" var="wishList">
		wishList.push("${wishList}");
	</c:forEach>
	
	// 편집 버튼 클릭 시 체크박스 on
	function checkBoxOn(){
		$("input[name='chkBox']:checkbox").show();
		$("#btn1").hide();
		$("#btn2").show();
	}
	
	function cancel(){

		$("input[name='chkBox']:checkbox").hide();
		$("#btn1").show();
		$("#btn2").hide();
	}
	
	function dellChkBox(){
		// 만약 관심상품이 없으면 alert뜨게 하기
		if(wishList.length == 0){
			alert("관심상품이 등록되어있지 않습니다.");
			return false;
		}
		
		// 사용자에게 삭제여부 물어보기
		var checkDelete = confirm("선택한 상품을 삭제하시겠습니까?");
		
		if(checkDelete){
			//관심상품에 담긴 모든 상품 불러오기
			for(var i=0; i<wishList.length; i++){
				// 각 상품의 체크박스가 체크되어 있으면 true, 아니면 false
				var w_code = document.getElementById('w_code'+i).value;
				if(document.getElementById('chkBox'+i).checked){
					(function(i){
						$.ajax({
							type:'get',
							url:'./WishListDelete.wl',
							data: 'w_code='+$('#w_code'+i).val(),
							dataType: 'html',
							async: false,
							success:function(data){
								
							},error:function(request,status,error){
								alert("code="+ request.status + ", message=" + request.responseText + ", error=" + error);
							}
						});
					})(i);
				}
			}
			window.location.reload(); //현재 페이지 새로고침
		}else{
			return false;
		}
	}
	
	

</script>
</html>
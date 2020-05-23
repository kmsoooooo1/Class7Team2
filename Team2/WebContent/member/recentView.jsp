<%@page import="team2.animal.db.AnimalDAO"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link href="${pageContext.request.contextPath}/css/mypage.css?ver=2" rel="stylesheet">
<title>최근 본 상품</title>
<style type="text/css">
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
<div class="member_div">
 <div class="content">
	<h3 class="recent_h3">최근 본 상품</h3>
	
<div class="recent_div">
  <h3>
  <a href="./recentView.me" class="seemore">더보기>></a>
  </h3>
  <div class="contents">
  <table border="1" summary>
  <caption>최근 본 상품</caption>
  <colgroup>
    	<col style="width: 100px;">
    	<col style="width: auto;">
    	<col style="width: 220px;">
    	<col style="width: 140px;">
    	<col style="width: 210px;">
    </colgroup>
  	<thead>
	<tr>
		<th scope="col">이미지</th>
		<th scope="col">상품명</th>
		<th scope="col">판매가</th>
		<th scope="col">옵션정보</th>
		<th scope="col">주문</th>
	</tr>
	</thead>
	<tbody>
		<%
		// 쿠키 얻어오기
		Cookie[] cook = request.getCookies();
		if(cook!= null){
			for(int i=0; i<cook.length; i++){
				
			// 전송된 쿠키 이름 얻어오기
			String name1 = cook[i].getName();
			// 쿠키 이름에 item이 포함되어 있다면
			if(name1.indexOf("item")!= -1){
		
			// 해당 value얻어오기
			String value = cook[i].getValue();
			
			String item = URLDecoder.decode(value, "UTF-8");
			out.println(item);
		
			}
		}
				%>
	</tbody>
	</table>
	<%
		}else{
	%>
				<p class=""> 최근 본 상품이 없습니다.</p>
		<%} %>
 </div>
 </div>

</div>
</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>
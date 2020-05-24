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
<link href="${pageContext.request.contextPath}/css/wishlist.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>최근 본 상품</title>
<style type="text/css">
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<div class="container">
	<div class="div_name">
	<h2>최근 본 상품</h2>
	</div>
	
	<ul class="ul_wrap">
	<div class="list_wrap">
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
		}
		%>
	</div>
	</ul>
	<div class="div_btn">
		<div id="btn1"> <button type="button" class="btns" onclick="checkBoxOn();">편집</button> </div>
		<div id="btn2" style="display: none;">
			<button class="btns" onclick="dellChkBox();">삭제</button>
			<button class="btns" onclick="cancel();">취소</button>
		</div>
	</div>

	
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
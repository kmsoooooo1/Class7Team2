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
<title>최근 본 상품</title>
<style type="text/css">
.recent_div{
	text-align: center;
}

.recent_table{
	width: 40%;
	margin: auto;
}

.recent_h3{
	text-align: center;
}

img{
}


</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	<h3 class="recent_h3">RECENTLY VIEWED</h3>
	
<div class="recent_div">
<table border="1" class="recent_table">
	<tr>
		<td>이미지</td>
		<td>상품명</td>
		<td>판매가</td>
		<td>옵션정보</td>
		<td>주문</td>
	</tr>
		<%
		// 쿠키 얻어오기
		Cookie[] cook = request.getCookies();
		if(cook!= null){
			for(int i=0; i<cook.length; i++){
				
			// 전송된 쿠키 이름 얻어오기
			String name = cook[i].getName();
			// 쿠키 이름에 item이 포함되어 있다면
			if(name.indexOf("item")!= -1){
		
			// 해당 value얻어오기
			String value = cook[i].getValue();
			
			String item = URLDecoder.decode(value, "UTF-8");
			out.println(item + "<br>");
		
			}
			}
		}else{
				%>
				<tr>
					<td>최근에 본 상품이 없습니다.</td>
				</tr>
				<%
		}
		%>
</table>
</div>


	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>
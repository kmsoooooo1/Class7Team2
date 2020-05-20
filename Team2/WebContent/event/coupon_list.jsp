<%@page import="java.util.List"%>
<%@page import="team2.coupon.db.CouponDTO"%>
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
		List<CouponDTO> couponList = (List<CouponDTO>) request.getAttribute("couponList");
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<div class="container">
		<ul class="ul_wrap" style="text-align: center;">
			<%	if(couponList.size() > 0){
				for (int i = 0; i <couponList.size(); i++) {
					CouponDTO cdto = couponList.get(i);
			%>
				<li style="margin: 50px; list-style:none;">
					<div class="list_wrap">
		  				<img class="list_img" src="./upload/event/<%=cdto.getCo_image()%>" width="700" height="150">
					</div>
				</li>
			<%	}
			}else{%>
				<li style="margin: 50px; list-style:none;">
					<div class="list_wrap">
						이벤트 쿠폰이 없습니다
					</div>
				</li>
		<%} %>
		</ul>
	</div>
	
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>

</body>
</html>
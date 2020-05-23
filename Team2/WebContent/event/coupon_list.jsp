<%@page import="java.util.List"%>
<%@page import="team2.coupon.db.CouponDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>
	
	<%
		List<CouponDTO> couponList = (List<CouponDTO>) request.getAttribute("couponList");
		String id = (String) session.getAttribute("id");
		if(id == null){
			id = "";
		}
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<div class="container">
		<input type="hidden" id="id" name="id" value="<%=id%>"> 
		<ul class="ul_wrap" style="text-align: center;">
			<%	if(couponList.size() > 0){
				for (int i = 0; i <couponList.size(); i++) {
					CouponDTO cdto = couponList.get(i);
			%>
				<input type="hidden" id="co_num<%=i%>" name="co_num" value="<%=cdto.getNum()%>">
				<li style="margin: 50px; list-style:none;">
					<div class="list_wrap">
		  				<a href="javascript:void(0)" onclick="addCoupon(<%=i%>);"> <img class="list_img" src="./upload/event/<%=cdto.getCo_image()%>" width="700" height="150"> </a>
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
<script type="text/javascript">

	function addCoupon(i){
		//로그인된 상태면
		if(document.getElementById('id').value){
			//coupon_member DB에 접근하여 해당 num의 쿠폰 값을 저장하기
			$.ajax({
				type:'get',
				url:'./CouponAddMember.co',
				data:'c_num='+$('#co_num'+i).val(),
				dataType: 'html',
				success:function(data) {
					if(data == -1){
						alert("이미 발급받은 쿠폰입니다.");
					}else if(data == 1){
						alert("쿠폰이 발급되었습니다.");
					}
	   			},error:function(request,status,error){
				 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		}
		//로그인을 하지 않은 상태면
		else{
			alert("회원에게만 지급되는 쿠폰입니다. 로그인을 해주세요.");
		}
	}

</script>
</html>
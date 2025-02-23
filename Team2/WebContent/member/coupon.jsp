<%@page import="team2.couponMember.db.CouponMemberDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="team2.coupon.db.CouponDTO"%>
<%@page import="team2.coupon.db.CouponDAO"%>
<%@page import="team2.member.db.MemberDAO"%>
<%@page import="team2.basket.db.BasketDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.basket.db.BasketDTO"%>
<%@page import="team2.member.db.MemberDTO"%>
<%@page import="team2.board.db.PDAO"%>
<%@page import="team2.product.db.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team2.board.action.cSet"%>
<%@page import="team2.goods.db.GoodsDAO"%>
<%@page import="java.util.List"%>
<%@page import="team2.animal.db.AnimalDAO"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/searchItem.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String id = (String) session.getAttribute("id");
		
		String category = (String) request.getParameter("b_category");
		
		String num = request.getParameter("num");
		
		String total_discount_rate = request.getParameter("total_discount_rate");
		
		//coupon DB 접근해서 리스트 가져오기
		CouponDAO cdao = new CouponDAO();
		
		Vector vec = cdao.getMemberCouponsList(id);
		
		ArrayList memberCouponList = (ArrayList) vec.get(0);
		ArrayList couponInfoList = (ArrayList) vec.get(1);	
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
	%>
	
	<div id="container">
	
		<input type="hidden" id="num" name="num" value="<%=num%>">
		<input type="hidden" id="total_discount_rate" name="total_discount_rate" value="<%=total_discount_rate%>">
		
		<div class="page_title">
			<span> Coupons </span>
		</div>
		<div class="inner" style="margin:20px;">
			<div class="search_list">
				<table class="list_table" style="width:100%">
				<colgroup>
					<col width="5%">
					<col width="30%">
					<col width="10%">
					<col width="15%">
					<col width="30%">
				</colgroup>
					<tr>
						<th>번호</th>
						<th>할인쿠폰명</th>
						<th>할인금액</th>
						<th>사용가능대상</th>				
						<th>사용기한</th>
					</tr>
			<%if(couponInfoList.size()>0){ 
				for(int i = 0; i < couponInfoList.size(); i++){
					CouponMemberDTO cmdto = (CouponMemberDTO) memberCouponList.get(i);
					CouponDTO cdto = (CouponDTO) couponInfoList.get(i);
			%>
					<tr class="choice_tr1">
					
						<!-- 쿠폰 번호 -->
						<td>
							<%=cmdto.getNum()%>
						</td>
					
						<!-- 할인쿠폰명 -->
						<td>
							<%=cdto.getCo_name()%>
						</td>
						
						<!-- 할인금액 -->
						<td>
							<%=cdto.getCo_rate()%>원
							<input type="hidden" id="co_rate<%=i%>" name="co_rate<%=i%>" value="<%=cdto.getCo_rate()%>">
						</td>
						
						<!-- 사용가능대상 -->
						<td>
							<%=cdto.getCo_target()%>
						</td>
						
						<!-- 사용기한 -->
						<td>
							<%=cdto.getCo_startDate()%>-<%=cdto.getCo_endDate()%>
						</td>
						
					</tr>
			<%		
					}
				}else{ 
			%>
					<tr>
						<td colspan="6">쿠폰이 없습니다.</td>
					</tr>
				<%} %>
				</table>
			</div>
		</div>
	</div>
	
	<jsp:include page="/include/footer.jsp"/>
	
</body>
<script type="text/javascript">
	
	function setParentsText(i) {
		
		var num = document.getElementById('num').value;
		
		var total_discount_rate = document.getElementById('total_discount_rate').value;
		
		total_discount_rate = Number(total_discount_rate);
		
		total_discount_rate += Number(document.getElementById('co_rate' + i).value);
		
		opener.document.getElementById("total_discount_rate").innerHTML = total_discount_rate;
		opener.document.getElementById("discount_rate" + num).innerHTML = document.getElementById("co_rate" + i).value;
		
		opener.document.getElementById('searchCouponBtn' + num).style.display = "none";
		
		opener.document.getElementById('cancelCouponBtn' + num).style.display = "";
		
		window.close();
	}
	
</script>
</html>
<%@page import="team2.coupon.db.CouponDAO"%>
<%@page import="team2.couponMember.db.CouponMemberDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="team2.coupon.db.CouponDTO"%>

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
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
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
		
		int total_price_input = Integer.parseInt(request.getParameter("total_price_input"));
		String total_delivery_fee = request.getParameter("total_delivery_fee");
		
		//coupon DB 접근해서 리스트 가져오기
		CouponDAO cdao = new CouponDAO();
		
		Vector vec = cdao.getMemberCouponsList(id);
		
		ArrayList memberCouponList = (ArrayList) vec.get(0);
		ArrayList couponInfoList = (ArrayList) vec.get(1);	
		
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
	%>
	
	<div id="container">
	
		<input type="hidden" id="id" name="id" value="<%=id%>">
		<input type="hidden" id="num" name="num" value="<%=num%>">
		<input type="hidden" id="total_discount_rate" name="total_discount_rate" value="<%=total_discount_rate%>">
		<input type="hidden" id="total_price_input" value="<%=total_price_input%>">
		<input type="hidden" id="total_delivery_fee" value="<%=total_delivery_fee%>">
		
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
					<col width="10%">
				</colgroup>
					<tr>
						<th>번호</th>
						<th>할인쿠폰명</th>
						<th>할인금액</th>
						<th>사용가능대상</th>				
						<th>사용기한</th>
						<th>사용여부</th>						
					</tr>
			<%if(couponInfoList.size()>0){ 
				for(int i = 0; i < couponInfoList.size(); i++){
					CouponMemberDTO cmdto = (CouponMemberDTO) memberCouponList.get(i);
					CouponDTO cdto = (CouponDTO) couponInfoList.get(i);
					System.out.println(cmdto);
			%>
					<tr class="choice_tr1">
					
						<!-- 쿠폰 번호 -->
						<td>
							<%=cmdto.getNum()%>
							<input type="hidden" id="co_num<%=i%>" value="<%=cmdto.getCo_num()%>">
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
						
						<!-- 사용여부 -->
						<td>
							<%if(cdto.getCo_target().equals(category)){%>
									<%if(cmdto.getUsed().equals("TEMP_USED")){%>
										<input type="button" value="다른상품에 적용중" style="opacity: 0.3; pointer-events: none;">
									<%} else{ %>
										<input type="button" value="적용하기" onclick="setParentsText('<%=i%>')">
									<%} %>
							<%}else{%>
								<button type="button" style="opacity: 0.3; pointer-events: none;"> 적용불가 </button>
							<%}%>
							<input type="hidden" id="used_value" value=<%=cmdto.getUsed()%> >
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
		
		var id = document.getElementById('id').value;
		
		var co_num = document.getElementById('co_num' + i).value;
		
		var num = document.getElementById('num').value;
		
		var total_discount_rate = document.getElementById('total_discount_rate').value;
		
		total_discount_rate = Number(total_discount_rate);
		
		total_discount_rate += Number(document.getElementById('co_rate' + i).value);
		
		var o_sum_money_input = 0;
		o_sum_money_input = (Number(document.getElementById('total_price_input').value) + Number(document.getElementById('total_delivery_fee').value)) - total_discount_rate;
		
		var used_value = document.getElementById('used_value').value;
		
		used_value = document.getElementById('used_value').value;
		
		opener.document.getElementById("total_discount_rate").innerHTML = total_discount_rate;
		opener.document.getElementById("discount_rate" + num).innerHTML = document.getElementById("co_rate" + i).value;
		
		opener.document.getElementById('searchCouponBtn' + num).style.display = "none";
		
		opener.document.getElementById('cancelCouponBtn' + num).style.display = "";
		
		opener.document.getElementById("o_sum_money").innerHTML = o_sum_money_input;
		opener.document.getElementById("o_sum_money_input").value = o_sum_money_input;
		
		opener.document.getElementById('selected_co_num'+num).value = co_num;
		
		$.ajax({
			type:'post',
			url:'./CouponModi.co',
			data:'id='+id+'&co_num='+co_num + '&used_value=' + used_value,
			dataType: 'html',
			success:function(data) {
				window.close();
   			},error:function(request,status,error){
			 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	
	}
	
</script>
</html>
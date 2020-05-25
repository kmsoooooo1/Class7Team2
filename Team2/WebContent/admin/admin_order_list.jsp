<%@page import="team2.order.db.OrderDTO"%>
<%@page import="team2.product.db.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@page import="team2.basket.db.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<link href="${pageContext.request.contextPath}/css/memberList.css"
	rel="stylesheet">
<title>Insert title here</title>
</head>
<body>

	<%
		List<OrderDTO> orderList = (List<OrderDTO>) request.getAttribute("orderList");
		List productInfoList = (List) request.getAttribute("productInfoList");

		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");

		int final_total_price = 0; //총 상품금액
		int final_delivery_fee = 0; //총 배송비
	%>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- Main Content -->
	<div class="board">

		<div class="top">
			<div class="boardname">
				<h2>전체 주문 리스트</h2>
			</div>
			<div class="list-div">
				<table class="list">
					<colgroup>
						<col width="2%" />
						<col width="4%" />
						<col width="5%" />
						<col width="7%" />
						<col width="8%" />
						<col width="7%" />
						<col width="5%" />
						<col width="5%" />
						<col width="4%" />
						<col width="6%" />
						<col width="4%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
						<col width="4%" />
						<col width="5%" />
						<col width="4%" />
						<col width="4%" />
					</colgroup>
					<thead>
						<tr>
							<th>NO.</th>
							<th>주문일자<br>[주문번호]</th>
							<th>수령인</th>
							<th>우편번호</th>
							<th>주소</th>
							<th>휴대전화</th>
							<th>전화번호</th>
							<th>배송메세지</th>
							<th>총결제금액</th>
							<th>결제방법</th>
							<th>입금자</th>
							<th>입금상태</th>
							<th>운송장번호입력</th>
							<th>수정</th>
						</tr>
					</thead>
					<%
						if(orderList.size() == 0){
					%>
					<tbody>
						<tr>
							<td colspan="18" style="text-align: center;">구매 내역이 없습니다.</td>
						</tr>
					</tbody>
					<% } else {

						for (int i = 0; i < orderList.size(); i++) {
							OrderDTO odto = (OrderDTO) orderList.get(i);
							ProductDTO pdto = (ProductDTO) productInfoList.get(i);
							
							//b_code 값들 중에 맨 앞글자 따오기
							char first_letter = odto.getO_p_code().charAt(0);
					%>
						<input type="hidden" id="o_trade_num<%=i%>" name="o_trade_num" value="<%=odto.getO_trade_num()%>">
					
					<form action="" method="post">
						<tbody>
							<!-- 순서 -->
							<td> <%=orderList.size() - i%> </td>
							
							<!-- 주문일자, 주문번호 -->
							<td> 
								<%=orderList.get(0).getO_date()%> <br>
								<a href="#"> [<%=orderList.get(0).getO_trade_num()%>] </a>
							</td>
							
							<!-- 수령인 -->
							<td> <%=odto.getO_receive_name()%> </td>
							
							<!-- 우편번호 -->
							<td> <%=odto.getO_receive_zipcode()%> </td>
							
							<!-- 주소 -->
							<td> <%=odto.getO_receive_addr1() + " " + odto.getO_receive_addr2()%> </td>
							
							<!-- 휴대전화 -->
							<td> <%=odto.getO_receive_mobile()%> </td>
							
							<!-- 전화번호 -->
							<td> <%=odto.getO_receive_phone()%> </td>
							
							<!-- 배송메세지 -->
							<td> <%=odto.getO_memo()%> </td>
							
							<!-- 총결제금액 -->
							<td> <%=odto.getO_sum_money()%> </td>
							
							<!-- 결제방법 -->
							<td> <%=odto.getO_trade_type()%> </td>
							
							<!-- 입금자 -->
							<td> <%=odto.getO_trade_payer()%> </td>
							
							<!-- 입금상태  o_status가 0이면 입금전 1이면 입금후 2이면 배송중-->
							<%if(odto.getO_status() == 0) {%>
								<td> <span style="color: red;"> 입금전 </span> </td>
							<%} else if(odto.getO_status() == 1) {%>
								<td> <span style="color: green;"> 입금완료 </span> </td>
							<%} else if(odto.getO_status() == 2) {%>
								<td> <span style="color: blue;"> 배송중 </span> </td>
							<%} else if (odto.getO_status() == 3) {%>
								<td><span style="color: black;"> 배송완료 </span></td>
							<%}%>
							
							<!-- 운송장번호입력 -->
							<td>
								<input type="text" id="o_trans_num<%=i%>" name="o_trans_num" value="<%=odto.getO_trans_num()%>"> 
							</td>
							
							<!-- 수정 -->
							
							<td> <input type="button" value="수정" onclick="updateOrderStatus('<%=i%>');"> </td>
					
						</tbody>
					</form>
					<%
							}
						}
					%>
				</table>
			</div>
		</div>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp" />

</body>
<script type="text/javascript">

	function updateOrderStatus(i){
	
		$.ajax({
			type:'get',
			url:'./AdminUpdateOrderStatus.ao',
			data:'o_trade_num='+$('#o_trade_num'+i).val() + '&o_trans_num=' + $('#o_trans_num'+i).val(),
			dataType: 'html',
			success:function(data) {
				alert("운송장번호가 추가되었습니다.");
   				window.location.reload(); //현재 페이지 새로고침
   			},error:function(request,status,error){
			 	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
		
// 		document.fr.action="./AdminUpdateOrderStatus.ao";
// 		document.fr.submit();
	}

</script>
</html>
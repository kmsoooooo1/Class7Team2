<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title> 테스트 </title>
</head>
<body>

	<%
		String id = (String) session.getAttribute("id");
		if(id == null){
			id = "";
		}
	
		//AnimalDetailAction 객체에서 저장된 정보를 저장 
		AnimalDTO animalDetail = (AnimalDTO) request.getAttribute("animalDetail");
	
		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price = formatter.format(animalDetail.getA_price());
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<form action="" method="post" name="fr"> 
	
		<h4> <%=animalDetail.getA_morph() %> </h4>
		
		<!-- 동물 코드 -->
		<input type="hidden" name="a_code" value="<%=animalDetail.getA_code()%>">
	
		<table border="1">
			<tr>
				<td> <img src="./upload/multiupload/<%=animalDetail.getA_image().split(",")[0]%>" width="500" height="500"> </td>
				<td>
					<!-- 종 이름 -->
					<span id="a_morph"> <%=animalDetail.getA_morph()%> </span>
					<hr>
					<!-- 판매가, 적립금, 할인판매가 -->
					<table border="1">
						<tr>
							<td> 판매가 </td>
							<td> <%=newformat_price%>원 <% //만약 할인율이 있으면 {%> % OFF <%//}%> </td> 
						</tr>
						<tr>
							<td> 적립금 </td>
							<td> 원 </td>
						</tr>
						<%//만약 할인율이 있으면 {%>
						<tr>
							<td> 할인판매가  </td>
							<td> 원 ( % 할인율) </td>
						</tr>
						<%//}%>
					</table> 
					<hr>
					<!-- 배송방법 -->
					배송방법
						<select name="">
							<option value=""> -[필수]배송방법을 선택해 주세요 - </option>
							<option value=""> --------------- </option>
							<option value=""> 일반포장 </option>
							<option value=""> 퀵서비스(착불) </option>
							<option value=""> 지하철택배(착불) </option>
							<option value=""> 고속버스택배 (+14,000원) </option>
							<option value=""> 매장방문수령 </option>				
						</select>  
					<hr>
					<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
					<table border="1">
						<tr>
							<td> 상품명 </td>
							<td> 상품수 </td>
							<td> 가격 </td>
						</tr>
						<!--
						
							상품정보 자바스크립트로 실시간으로 제어하기	
						
						-->
						<tr>
							<td colspan="3"> TOTAL : 원 (개) </td>
						</tr>
					</table>
					<hr>
					<button type="button"> 바로구매 </button>
					<button type="button"> 장바구니 </button>
					<button type="button"> 관심상품 </button>
					<br>
					<button type="button"> 카카오톡 상담 </button>
				</td>
			</tr>
		</table>
		
		<br>
		<hr>
		<br>
		
		<!-- 동물 추가 내용 -->
		<div>
			제품상세정보 <br>
			<img src="./upload/multiupload/<%=animalDetail.getA_image().split(",")[0]%>" width="600" height="600"> <br> <br>
			<img src="./upload/multiupload/<%=animalDetail.getA_image().split(",")[1]%>" width="600" height="600"> <br> <br>
			<img src="./upload/multiupload/<%=animalDetail.getA_image().split(",")[2]%>" width="600" height="600"> <br> <br>
			<p> 
				<%=animalDetail.getContent()%>
			</p>
			
			
		</div>
		
	</form>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
<script type="text/javascript">
	

</script>
</html>
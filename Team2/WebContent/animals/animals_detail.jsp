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
					이름  <span id="a_morph"> <%=animalDetail.getA_morph()%> </span> 
					<br>
					판매가 <%=newformat_price%>원
					<br>
					배송비 
						<select name="">
							<option value=""> 주문시 결제(선결제) </option>
							<option value=""> 수령시 결제(착불) </option>
						</select>
					<br>
					3,000원 (30,000원 이상 구매 시 무료) 
					<hr>
					배송방법(생물) 
						<select name="" >
							<option value=""> -[필수] 옵션을 선택해 주세요 - </option>
							<option value=""> --------------- </option>
							<option value=""> 고속버스배송 (+10,000원) </option>
							<option value=""> 방문구매 </option>
							<option value=""> 지하철택배(후불) </option>
							<option value=""> 퀵서비스(후불) </option>		
						</select> 
					<hr>
					<!-- 구매하고자 하는 정보 자동으로 올라가는 부분 -->
					<hr>
					<br>
					총 상품금액(수량): 0원 (0개) 
					<br>
					<hr>
					<button type="button"> 바로구매하기 </button>
					<button type="button"> 장바구니 담기 </button>
					<button type="button"> 관심상품등록 </button>
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
	//id값이 'a_morph'인 span태그 안에 있는 값 가져오기
	var a_morph = $('#a_morph').val();
	document.title = a_morph;

</script>
</html>
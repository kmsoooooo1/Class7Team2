<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<h2> 관리자 쿠폰 등록 페이지 </h2>
	
	<form name="fr" action="./CouponAddAction.ac" method="post" enctype="multipart/form-data"> 
		<table border="1">
			<tr>
				<td> 사용가능대상 </td>
				<td>
					<select name="co_target">
						<option value=""> 사용가능대상을 선택해주세요. </option>
						<option value="파충류"> 파충류 </option>
						<option value="양서류"> 양서류 </option>
						<option value="먹이"> 먹이 </option>
						<option value="사육용품"> 사육용품 </option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td> 할인 쿠폰명  </td>
				<td> <input type="text" name="co_name"> </td>
			</tr>
			
			<tr>
				<td> 할인 금액 <br> (ex.5000)</td>
				<td> <input type="text" name="co_rate"> </td>
			</tr>
			
			<tr>
				<td> 쿠폰 사용기한 </td>
				<td> <input type="date" name="co_startDate"> ~ <input type="date" name="co_endDate"> </td>
			</tr>
			
			<tr>
				<td> 쿠폰 배너 이미지 </td>
				<td> <input type="file" name="co_image"> </td>
			</tr>
			
			<tr>
				<td> 등록하는 쿠폰을 이벤트 페이지에 바로 보여줄겁니까? <br> (수정페이지에서 언제든지 수정가능합니다.) </td>
				<td> 
					<label> <input type="radio" name="co_status" value="true"> 예  </label>
					<label> <input type="radio" name="co_status" value="false"> 아니오  </label>
				</td>
			</tr>
			
			<tr>
				<td colspan="2"> <input type="submit" value="추가하기"> </td>
			</tr>
		</table>
	</form>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
 
</body>
</html>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="java.util.List"%>
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
		//AnimalListAction 객체에서 저장된 정보를 저장 
		List<AnimalDTO> admin_animalList = (List<AnimalDTO>) request.getAttribute("admin_animalList");
	%>
	
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<table border="1">
		<tr>
			<th></th>
			<th> 이미지 </th>
			<th> 카테고리 </th>
			<th> 서브 카테고리 </th>
			<th> 서-서브 카테고리 </th>
			<th> 모프(종 이름) </th>
			<th> 성별 </th>
			<th> 상태 </th>
			<th> 코드</th>
			<th> 수량 </th>
			<th> 금액 </th>
			<th> 조회수 </th>
			<th> 등록일자 </th>
			<th> 수정하기 </th>
			<th> 삭제하기 </th>
		</tr>
		<%
			for(int i=0; i<admin_animalList.size(); i++){
				AnimalDTO adto = admin_animalList.get(i);
		%>
			<tr>
				<td><%=adto.getNum()%></td>
				<td><img src="./upload/multiupload/<%=adto.getA_image().split(",")[0]%>" width="50" height="50"></td>
				<td><%=adto.getCategory()%></td>
				<td><%=adto.getSub_category()%></td>
				<td><%=adto.getSub_category_index()%></td>
				<td><%=adto.getA_morph()%></td>
				<td><%=adto.getA_sex()%></td>
				<td><%=adto.getA_status()%></td>
				<td><%=adto.getA_code()%></td>
				<td><%=adto.getA_amount()%></td>
				<td><%=adto.getA_price()%></td>
				<td><%=adto.getA_view_count()%></td>
				<td><%=adto.getDate()%></td>
				<td> <a href=""><button type="button"> 수정 </button></a> </td>
				<td> <a href=""><button type="button"> 삭제 </button></a> </td>
			</tr>
		<%}%>
	</table>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>
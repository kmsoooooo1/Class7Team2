<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<h2> 관리자 동물등록 페이지 </h2>
	
	<form> 
		<table border="1">
			<tr>
				<td> 카테고리 </td>
				<td>
					<select name="category">
						<option value="파충류"> 파충류 </option>
						<option value="양서류"> 양서류 </option>
					</select>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>
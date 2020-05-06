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

	<h2> 회원 로그인 </h2>
	<fieldset>
		<legend>로그인</legend>
		<form action="./MemberLoginAction.me" method="post">
			<table border="1">
				<tr>
				 <td>아이디</td><td><input type="text" name="id"></td>
				</tr>
				<tr>
				 <td>비밀번호</td><td><input type="password" name="pass"></td>
				</tr>
			</table>
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='./MemberJoin.me'">
		</form>
	</fieldset>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>
</html>
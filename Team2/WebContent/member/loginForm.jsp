<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 로그인페이지</title>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	 <form action="./MemberLoginAction.me" method="post" class="box">
	  <h1>로그인</h1>
	   <input type="text" name="id" placeholder="아이디">
	   <input type="password" name="pass" placeholder="비밀번호">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='./MemberJoin.me'">
			<input type="button" value="아이디 찾기" onclick="location.href='./MemberIDFind.me'">
				/
			<input type="button" value="비밀번호 찾기" onclick="location.href='./MemberPWFind.me'">
		</form>
	
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 로그인페이지</title>
<link href="${pageContext.request.contextPath}/css/join.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	 
		<div class="contents">
		<form action="./MemberLoginAction.me" method="post" class="box">
		 <h2>MEMBER LOGIN</h2>
			<input type="text" name="id" placeholder="ID">
			<input type="password" name="pass" placeholder="PASSWORD">
			
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='./MemberJoin.me'" class="btn">
			<input type="button" value="아이디 찾기" onclick="location.href='./MemberIDFind.me'" class="btn">
			<input type="button" value="비밀번호 찾기" onclick="location.href='./MemberPWFind.me'" class="btn">
		</form>
		</div>
	
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>
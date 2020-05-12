<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디찾기 페이지</title>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

<div class="contents">
 <form action="./MemberIDFindAction.me" method="post" class="box">
  <h2>아이디 찾기</h2>
   <label>가입하신 이메일 주소를 입력해주세요</label><br>
   <input type="text" name="email" placeholder="Email">
   <input type="submit" class="submit" value="아이디 찾기">
   <input type="button" class="btn" value="로그인 페이지로" onclick="location.href='./MemberLogin.me';">
 </form>
</div>


	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>

</body>
</html>
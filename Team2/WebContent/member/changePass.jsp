<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 변경하기</title>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

<%
	String id=request.getParameter("id");
%>
<div class="contents">
 <form action="./MemberChangePassAction.me" method="post" class="box">
  <h2><%=id %>님의 새 비밀번호 변경!</h2>
   <input type="password" name="pass" placeholder="비밀번호를 입력하세요"><br>
   <input type="password" name="passc" placeholder="비밀번호 확인"><br>
   <input type="hidden" name="id" value="<%=id %>">
   <input type="submit" value="비밀번호 변경">
   <input type="button" value="변경 취소" onclick="location.href='./MemberLogin.me';" class="btn">
 </form> 
</div>

	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>

</body>
</html>
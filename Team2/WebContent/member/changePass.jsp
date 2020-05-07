<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 변경하기</title>
</head>
<body>
<%
	String id=request.getParameter("id");
%>
<fieldset>
 <legend>비밀번호 변경 페이지</legend>
<%=id %>님의 새 비밀번호 변경!<br>
 <form action="./MemberChangePassAction.me" method="post">
  <label>변경할 비밀번호</label>
   <input type="password" name="pass"><br>
  <label>비밀번호 확인</label><input type="password" name="passc"><br>
   <input type="hidden" name="id" value="<%=id %>">

	<input type="submit" value="비밀번호 변경">
	<input type="button" value="변경 취소" onclick="location.href='./MemberLogin.me';">
 </form>
</fieldset>
</body>
</html>
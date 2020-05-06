<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
<fieldset><legend>비밀번호 찾기</legend>
 <form action="./MemberPWFindAction.me" method="post">
  <label>가입하신 이메일을 입력하세요</label><br>
   <input type="email" name="email"><br>
  <label>ID</label>
   <input type="text" name="id"><br>
   <input type="submit" class="btn" value="비밀번호 찾기">
   <input type="button" class="btn" value="로그인 페이지로" onclick="location.href='./MemberLogin.me';">
 </form>
</fieldset>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ID찾기</title>
</head>
<body>
<fieldset><legend>아이디 찾기</legend>
<form action="./MemberIDFindAction.me" method="post">
<label>당신의 이메일 주소는 무엇입니까?</label><br>
<input type="text" name="email"><br>
<input type="submit" class="btn" value="아이디 찾기">
<input type="button" class="btn" value="로그인 페이지로" onclick="location.href='./login.shw';">
</form>
</fieldset>
</body>
</html>
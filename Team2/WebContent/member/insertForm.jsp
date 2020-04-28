<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입 페이지</h2>
	
	<fieldset>
		<legend>회 원 가 입</legend>
		<form action="./MemberJoinAction.me" method="post">
		<table border="1">
		<tr>
			<td>아이디</td> <td><input type="text" name="id"></td>
		</tr>
		<tr>
			<td>비밀번호</td> <td><input type="text" name="pass1"></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td> <td><input type="text" name="pass2"></td>
		</tr>
		<tr>
			<td>이름</td> <td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>전화번호</td> <td><input type="text" name="phone"></td>
		</tr>
		<tr>
			<td>주소</td> <td><input type="text" name="addr"></td>
		</tr>
		<tr>
			<td>이메일</td> <td><input type="text" name="email"></td>
		</tr>
		</table>
		<input type="submit" value="회원가입">
		</form>	
	</fieldset>
	
	
	
</body>
</html>
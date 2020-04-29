<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원탈퇴</title>
</head>
<body>

<table width="960" cellspacing="0" cellpadding="0" border="0" align="center">
 <tr>
  <td colspan=2>
   <p align="center">
    <form action="./MemberDeleteAction.me" method="post">
 	 <table border="1" width="380" cellpadding="0" cellspacing="0">
	  <tr>
	   <td align="center" colspan="2">
		<font size="4"><b>회원 탈퇴</b></font>
	   </td>
	  </tr>
	  <tr>
	   <td align="center" height="35" width="125">
		<font size="2">비밀번호</font></td>	
	   <td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="password" name="pass" />
	   </td>
	  </tr>
	  <tr>
	   <td align="center" colspan="2" height="35">
		<input type="submit" value="회원 탈퇴" />
		<input type="button" value="초기 화면" 
			    onclick="script:location.href ='./index.jsp' "/>
	   </td>
	  </tr>				
     </table>
    </form>				
  </td>
 </tr>
</table>
</body>
</html>
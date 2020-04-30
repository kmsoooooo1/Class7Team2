<%@page import="team2.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
    //세션값 처리 
    String id =(String) session.getAttribute("id");
  
    if(id == null){
    	response.sendRedirect("./MemberLogin.me");
    }
    
    
    // MemberInfoAction 클래스에서 전달된 정보를 저장 (request영역데이터)
    MemberDTO mb = (MemberDTO)request.getAttribute("mdto");
  %>
  <h1> 회원정보 페이지 </h1>
  <table border="1">
   <tr>
    <th>아이디</th><td><%=mb.getId() %></td>
   </tr>
   <tr>
    <th>비밀번호</th><td><%=mb.getPass() %></td>
   </tr>
   <tr>
    <th>이름</th><td><%=mb.getName() %></td>
   </tr>
   <tr>
    <th>휴대전화</th><td><%=mb.getPhone() %></td>
   </tr>
   <tr>
    <th>우편번호</th><td><%=mb.getZipcode() %></td>
   </tr>
   <tr>
    <th>주소</th><td><%=mb.getAddr1() %></h2></td>
   </tr>
   <tr>
    <th>상세주소</th><td><%=mb.getAddr2() %></td>
   </tr> 
   <tr>
    <th>이메일</th><td><%=mb.getEmail() %></td>
   </tr>
   <tr>
    <th>회원가입일</th><td><%=mb.getReg_date() %></td>
   </tr>
  </table>
  <br>
  <br>
  <h3><a href="./MemberPage.me"> 마이 페이지로 이동... </a></h3>
</body>
</html>
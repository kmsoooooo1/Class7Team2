<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
<title>회원 탈퇴 페이지</title>
</head>
<body>
<%
      //ID값 가져오기 
      String id = (String) session.getAttribute("id");
      if(id == null){
    	 response.sendRedirect("./MemberLogin.me");  
      }   
   %>   
   
   <!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	
   <div class="contents">
     <form action="./MemberDeleteAction.me" method="post" class="box">
      <h2>MEMBER DELETE</h2>
     <input type="hidden" name="id" value="<%=id%>">
     <input type="password" name="pass" placeholder="PASSWORD">
       <input type="submit" value="탈퇴하기">
     </form>    
   </div>


<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>

</body>
</html>
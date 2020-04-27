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
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("ir1");
	
	System.out.println(title);
	System.out.println(content);
%>

<h1>제목</h1>
<h2><%=title %></h2>
<h1>내용</h1>
<p>
	<%=content %>
</p>

</body>
</html>
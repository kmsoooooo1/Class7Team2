<%@page import="team2.board.action.cSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 	cSet cset = (cSet)session.getAttribute("cset");%>
	
	Category : <%=cSet.Category[cset.getC()] %>
	p_Category : <%=cSet.p_Category[cset.getPc()] %>
</body>
</html>
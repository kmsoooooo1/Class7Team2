<%@page import="team2.board.action.cSet"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="./SmartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body>
	<h1>WebContent/board/board_update.jsp</h1>
	
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = (String)request.getAttribute("pageNum");
	%>
	
	<form action="./BoardUpdateAction.bo?pageNum=${pageNum}" method="post">
	<table border ="1">
		<tr>
			<td>글번호</td><td><input type="hidden" name="num" value="<%=bdto.getB_idx() %>">
			<%=bdto.getB_idx() %></td>
			<td>조회수</td><td><%=bdto.getB_view()%></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td>
			<select name="b_category">
				<%for(int i = 0; i<cSet.Category.length; i++){ %>
					<option value=<%=cSet.Category[i] %>><%=cSet.Category[i]%></option>
				<%} %>
			</select>
			</td>
		</tr>
		<tr>
			<td>세부카테고리</td>
			<td>
			<select name="b_p_cate">
				<%for(int i = 0; i<cSet.p_Category.length; i++){ %>
					<option value=<%=cSet.p_Category[i] %>><%=cSet.p_Category[i] %></option>
				<%} %>
			</select>
			</td>
		</tr>

		<tr>
			<td>제목</td><td><input type="text" name="title" value="<%=bdto.getB_title()%>"></td>
		</tr>
	
		<tr>
			<td>첨부파일</td><td><%=bdto.getB_file() %></td>
		</tr>
	
		<tr>
			<td>내용</td><td colspan="3">
			<textarea name="content" cols="20"><%=bdto.getB_content()%>
			</textarea></td>
		</tr>
		
		<tr>
			<td colspan="4">
				<input type="submit" value="수정하기">
				<input type="reset" value="다시 쓰기">
				
				<input type="button" value="뒤로가기"
					onclick="location.href='javascript:history.back()'">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">
			
			</td>
		</tr>
	
	</table>
	</form>
	
	
</body>
</html>
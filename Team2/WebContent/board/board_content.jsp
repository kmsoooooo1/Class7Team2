<%@page import="team2.board.db.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/board/commentInsert.js"></script>
</head>
<body>
	<h1>WebContent/board/board_content.jsp</h1>
	
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = (String)request.getParameter("pageNum");
		
		if(bdto!=null){
	%>
	
	<table border ="1">
		<tr>
			<td>글번호</td><td><%=bdto.getB_idx() %></td>
			<td>조회수</td><td><%=bdto.getB_view() %></td>
		</tr>
		<tr>
			<td>카테고리</td><td><%=bdto.getB_category() %></td>
			<td>제목</td><td><%=bdto.getB_title() %></td>
		</tr>
	
		<tr>
			<td>첨부파일</td><td><%=bdto.getB_file() %></td>
		</tr>
	
		<tr>
			<td>내용</td><td colspan="3"><%=bdto.getB_content() %></td>
	
		</tr>
		
		<tr>
			<td colspan="4">
				<input type="button" value="수정"
					onclick="location.href='./BoardUpdate.bo?pageNum=<%=pageNum%>&num=<%=bdto.getB_idx()%>'">
				<input type="button" value="삭제"
					onclick="">
				<input type="button" value="댓글"
					onclick="">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">
			
			</td>
		</tr>
	</table>
	<%} %>
	<div class="comment_wrap">
		<div>
			<form name="fr" action="./InsertCommentAction.bo" method="post">
				<input type="hidden" name="c_category" value="board">
<%-- 				<input type="hidden" name="b_idx" value=<%=bdto.getB_idx()%>> --%>
				<textarea name="comment"></textarea>
				<button type="button" onclick="return insertCommenctCheck()">등록</button>
			</form>
		</div>
		<div></div>
	</div>
		
	

</body>
</html>
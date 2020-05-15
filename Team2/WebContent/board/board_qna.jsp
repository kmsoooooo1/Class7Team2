<%@page import="team2.board.db.BoardDTO"%>
<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
	<div class="main">
		<div class="">
			<span class="title">Q&A</span>
			<p class="desc"></p>
		</div>
		
	<%
		ArrayList boardList = (ArrayList)request.getAttribute("boardList");
		Criteria cri = (Criteria)request.getAttribute("cri");
		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
		String pageNum = (String)request.getAttribute("pageNum");
	%>
			
		<table class="boardList" border="1">
		  <tr class="board_tr">
		  	<th class="board_th">No.</th>
		    <th class="board_th">Title</th>
		    <th class="board_th">Writer</th>
		    <th class="board_th">View</th>
		    <th class="board_th">like</th>
		    <th class="board_th">Date</th>
		  </tr>
		  
  <%
    for(int i=0;i<boardList.size();i++){ 
            BoardDTO bdto = (BoardDTO) boardList.get(i);
  %>
		  <tr class="board_tr">
		  	<td class="board_td"><%=bdto.getB_idx() %></td>
		  	<td class="board_td"><%=bdto.getB_title() %></td>
		  	<td class="board_td"><%=bdto.getB_writer() %></td>
		  	<td class="board_td"><%=bdto.getB_view() %></td>
		  	<td class="board_td"><%=bdto.getB_like() %></td>
		  	<td class="board_td"><%=bdto.getB_reg_date() %></td>
		  </tr>
  <% } %>
		</table>
		<button type="button" onclick="location.href='./Insert.bo?C=2'">글쓰기</button>
		
		<div class="page_wrap">
			<ul class="pageList">
			<c:if test="${pageMaker.prev }">
			<li onclick="location.href='./notice.bo?pageNum=${pageMaker.startPage-1 }'">[이전]</li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
			<li>
				<a href='<c:url value="./notice.bo?pageNum=${pageNum}"/>'><i class="fa">[${pageNum }]</i></a>
			</li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<li onclick="location.href='./notice.bo?pageNum=${pageMaker.endPage+1 }'">[다음]</li>
			</c:if>
		
			</ul>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp"/>
</body>
</html>